#include "rtc.h"

volatile uint8_t rtc_str[20];
volatile uint8_t rtc_aaflag = 0;

void initRTC(void)
{ 
	uint32_t *t_str;
	
	RCC->APB1ENR |= RCC_APB1ENR_PWREN;									// Enable APB1 clock to RTC
	PWR->CR |= PWR_CR_DBP;												// Enable access to RTC and RTC Backup registers and backup SRAM enabled
	
	// select additional HSE clock prescaler (max 31)
	RCC->CFGR |= 0x00080000;											// RTC clock set to HSE(8MHz)/8 = 1MHz 
	
	RCC->BDCR |= RCC_BDCR_RTCSEL;										// HSE as clock source
	RCC->BDCR |= RCC_BDCR_RTCEN;										// enable RTC clock
	
	RTC->WPR = 0xCA;													// disable write protection for RTC
	RTC->WPR = 0x53;
	RTC->ISR |= RTC_ISR_RSF;											// enable calendar and time shadow register syncronisation
	while((RTC->ISR & RTC_ISR_RSF) != RTC_ISR_RSF);

	RTC->ISR |= RTC_ISR_INIT;											// enter initialization mode
	while((RTC->ISR & RTC_ISR_INITF) != RTC_ISR_INITF);					// wait for initialization
	
	RTC->PRER =  0x00630000;											// PREDIV_A = 99, must be completed in two write cycles
	RTC->PRER |= 0x0000270F;											// PREDIV_S = 79999
																		// (PREDIV_A+1)*(PREDIV_S+1) = 8MHz == HSE
	RTC->TR = 0x00080000;												// enter time values in shadow register
	RTC->DR = 0x00172306;												// enter date values in shadow register
	RTC->SSR = 0x00000000;
	
	//RTC->CR &= ~(RTC_CR_TSE);											// disable time stamp
	RTC->ISR &= ~(RTC_ISR_INIT);										// exit initialization mode
	RTC->CR &= ~(RTC_CR_TSIE);											// disable timestamp interrupt
	
	RTC->WPR = 0xFF;													// enable write protection for RTC
}

uint8_t * getRTC(void)
{
	uint8_t k, t_str[20];
	uint32_t utmp32;
	uint32_t t_time = RTC->TR;
	rtc_str[0] = 0x00;
	t_str[0] = 0x00;
	
	
	for(k=0;k<20;k++)
	{
		t_str[k] = 0x00;
		rtc_str[k] = 0x00;
	}
		
	utmp32 = (t_time&0x00300000)>>20; 	
	getStr4NumMISC(PRINT_ARG_TYPE_DECIMAL_WORD, &utmp32, t_str);
	catstrMISC((uint8_t *)rtc_str, t_str);

	for(k=0;k<20;k++)
		t_str[k] = 0x00;
		
	utmp32 = (t_time&0x00070000)>>16; 
	getStr4NumMISC(PRINT_ARG_TYPE_DECIMAL_WORD, &utmp32, t_str);
	catstrMISC((uint8_t *)rtc_str, t_str);
	
	for(k=0;k<20;k++)
		t_str[k] = 0x00;
		
	utmp32 = (t_time&0x00007000)>>12; 
	getStr4NumMISC(PRINT_ARG_TYPE_DECIMAL_WORD, &utmp32, t_str);
	catstrMISC((uint8_t *)rtc_str, t_str);
	
	for(k=0;k<20;k++)
		t_str[k] = 0x00;
		
	utmp32 = (t_time&0x00000F00)>>8; 
	getStr4NumMISC(PRINT_ARG_TYPE_DECIMAL_WORD, &utmp32, t_str);
	catstrMISC((uint8_t *)rtc_str, t_str);
	
	
	for(k=0;k<20;k++)
		t_str[k] = 0x00;
		
	utmp32 = (t_time&0x00000070)>>4; 
	getStr4NumMISC(PRINT_ARG_TYPE_DECIMAL_WORD, &utmp32, t_str);
	catstrMISC((uint8_t *)rtc_str, t_str);
	
	
	for(k=0;k<20;k++)
		t_str[k] = 0x00;
		
	utmp32 = (t_time&0x00000000F); 
	getStr4NumMISC(PRINT_ARG_TYPE_DECIMAL_WORD, &utmp32, t_str);
	catstrMISC((uint8_t *)rtc_str, t_str);

	return (uint8_t *)rtc_str;
}

void setupAlarmARTC(void)
{/// setup Alarm A with one minute alarm at each :00 seconds, with interrupt
	EXTI->IMR |= (1<<17);												// enable interrupt on EXTI_Line17
	EXTI->EMR &= ~(1<<17);												// disable event on EXTI_Line17
	EXTI->RTSR |= (1<<17);		
	EXTI->FTSR &= ~(1<<17);

	RTC->WPR = 0xCA;													// disable write protection for RTC
	RTC->WPR = 0x53;
	
	RTC->CR &= ~(RTC_CR_ALRAE);											// disable Alarm A
	while((RTC->ISR & RTC_ISR_ALRAWF) != RTC_ISR_ALRAWF);				// wait until we can update the Alarm A values
	RTC->ALRMAR = (RTC_ALRMAR_MSK4)|(RTC_ALRMAR_MSK3)|(RTC_ALRMAR_MSK2);
	RTC->ALRMAR &= ~((RTC_ALRMAR_ST)|(RTC_ALRMAR_SU)); 
	
	RTC->ALRMAR = 0x80808004;											// alarm at each 00 second
	RTC->ALRMASSR = 0x00000000;											// sub second register value is omitted
	
	RTC->ISR &= ~(RTC_ISR_ALRAF);	
	RTC->CR &= ~(RTC_CR_TSIE);											// disable timestamp interrupt
	RTC->CR |= (RTC_CR_ALRAIE)|(RTC_CR_ALRAE);

	RTC->WPR = 0xFF;													// disable write protection for RTC
	NVIC_EnableIRQ(RTC_Alarm_IRQn);										// enable alarm irq
	
}

void RTC_Alarm_IRQHandler(void)
{/// RTC Alarm Handler
	if((RTC->ISR & RTC_ISR_ALRAF) == RTC_ISR_ALRAF)
	{
		RTC->ISR &= ~(RTC_ISR_ALRAF);									// clear the Alarm A flag
		rtc_aaflag = 1;
		EXTI->PR |= (1<<17);											// clear EXTI_Line17 interrupt flag
	}
}

uint8_t chkAlarmRTC(void)
{
	uint8_t rval = rtc_aaflag;
	
	if(rtc_aaflag)
	{
		rtc_aaflag = 0;
	}
	
	return rval;
}


