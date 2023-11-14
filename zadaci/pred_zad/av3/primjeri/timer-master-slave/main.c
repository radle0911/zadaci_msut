#include "stm32f4xx.h"
#include "delay.h"
#include "usart.h"

void initMSTIM(uint16_t psc);

int main(void) 
{
	uint32_t update_timer, cnt = 0;	
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// init system peripherals
	///-----------------------------------------------------------------	
	initUSART2(USART2_BAUDRATE_921600);
	initSYSTIM();
	initMSTIM(1);
	initPBTN();
	
	update_timer = getSYSTIM();
	printUSART2("\n-> SYS: init completed\n");
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	
	while(1)
	{	
		if(chk4TimeoutSYSTIM(update_timer, 1000) == (SYSTIM_TIMEOUT))
		{
			update_timer = getSYSTIM();
			cnt++;
			printUSART2("-> SYS: CNT[%x]\n",cnt);
		}
		
		chkPBTN();
	}
}

void initMSTIM(uint16_t psc)
{
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// setup PWM AFR mode on TIM4 
	/// CH1, CH2, CH3 & CH4 -> PD12, PD13, PD14 & PD15
	///----------------------------------------------------------------
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;  								//
    GPIOD->MODER |= 0xAA000000;             							//
    GPIOD->OTYPER |= 0x00000000; 										//
	GPIOD->AFR[1] |= 0x22220000;										//
	
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// Setup TIM2 Timer in master mode 
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	RCC->APB1ENR |= RCC_APB1ENR_TIM2EN; 								// enable TIMER
	TIM2->PSC = (0x0054*psc) - 0x0001;									// set TIMER counting prescaler to 84 -> 1us period
	TIM2->ARR = 0x03E8;													// reload value set to 1000 -> 1kHz clock
	TIM2->CR1 = 0x0084;													// autoreload on, up counting mod
	
	TIM2->CR2 = (TIM_CR2_MMS_1);										// update event is used to as trigger output (TRGO)
	TIM2->EGR |= TIM_EGR_UG;											// on update event, reload all config p363
	

	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// Setup TIM4 Timer in slave PWM mode 
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	RCC->APB1ENR |= RCC_APB1ENR_TIM4EN; 								// enable TIM4 on APB1 
	TIM4->PSC = 0x0001 - 0x0001;										// set TIM4 counting prescaler to 1
	TIM4->ARR = 0x1338;													// period of the PWM to 5 seconds
	
	TIM4->SMCR = (TIM_SMCR_SMS_2)|(TIM_SMCR_SMS_1)|(TIM_SMCR_SMS_0);	// TIM4 clocked by master timer TIM2, external mode
	TIM4->SMCR |= (TIM_SMCR_TS_0);										// set internal trigger to TIM2  
	
	
	TIM4->CCR1 = 1000;											
	TIM4->CCR2 = 2000;
	TIM4->CCR3 = 3000;
	TIM4->CCR4 = 4000;
	
	TIM4->CCMR1 |= (TIM_CCMR1_OC1PE)|(TIM_CCMR1_OC1M_2)|(TIM_CCMR1_OC1M_1);
	TIM4->CCMR1 |= (TIM_CCMR1_OC2PE)|(TIM_CCMR1_OC2M_2)|(TIM_CCMR1_OC2M_1);	
	TIM4->CCMR2 |= (TIM_CCMR2_OC3PE)|(TIM_CCMR2_OC3M_2)|(TIM_CCMR2_OC3M_1);	
	TIM4->CCMR2 |= (TIM_CCMR2_OC4PE)|(TIM_CCMR2_OC4M_2)|(TIM_CCMR2_OC4M_1);					
																		// set PWM 1 mod, enable OC1PE preload mode 
																		
	// set active mode high for pulse polarity
	TIM4->CCER |= ((TIM_CCER_CC1P)|(TIM_CCER_CC2P)|(TIM_CCER_CC3P)|(TIM_CCER_CC4P));
	TIM4->CR1 |= (TIM_CR1_ARPE)|(TIM_CR1_URS);
	
	// update event, reload all config 
	TIM4->EGR |= TIM_EGR_UG;											
	// activate capture compare mode
	TIM4->CCER |= (TIM_CCER_CC1E)|(TIM_CCER_CC2E)|(TIM_CCER_CC3E)|(TIM_CCER_CC4E);
	
	// start timers							
	TIM2->CR1 |= TIM_CR1_CEN;										
	TIM4->CR1 |= TIM_CR1_CEN;
}




