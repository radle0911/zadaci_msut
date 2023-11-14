#include "stm32f4xx.h"
#include "delay.h"
#include "usart.h"

void initInputPWM(void);

volatile uint32_t g_pwm_input_cnt = 0;

int main(void)
{
	uint32_t update_timer, cnt = 0;
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// init system peripherals
	/// connect PA0 with female-to-female wire jumper to PA8
	///-----------------------------------------------------------------
	initUSART2(USART2_BAUDRATE_921600);
	initSYSTIM();

	printUSART2("-> SYS: init completed\n");
	update_timer = getSYSTIM();
	initInputPWM();
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	
	while(1)
	{	
		if(chk4TimeoutSYSTIM(update_timer, 100) == (SYSTIM_TIMEOUT))
		{
			update_timer = getSYSTIM();
			cnt++;
			printUSART2("-> SYS: CNT[%d]: [%d]\n",cnt, g_pwm_input_cnt);
		}	
	}
	
	return 0;
}


void initInputPWM(void)
{
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;  								// enable clock for GPIOA
	GPIOA->MODER &= ~GPIO_MODER_MODER8;
    GPIOA->MODER |= GPIO_MODER_MODER8_1;             					// activate alternate function on PA8
    GPIOA->AFR[1] |= 0x00000001;
	//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	// Init TIM1@168MHz
	// TIM1_CH1 (PA8) is connected to T1
	//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 
	RCC->APB2ENR |= RCC_APB2ENR_TIM1EN; 								// enable TIM1 on APB2 
	TIM1->PSC = 0x00A8 - 0x0001;										// set TIM1 counting prescaler set to 168 -> 1MHz 
	//TIM1->PSC = 168*10-1;												// set TIM1 counting prescaler set to 1680 -> 100kHz 
	
	TIM1->ARR = 0xFFFF;													// set TIM1 period to 65.535ms
	TIM1->CR1 = 0x0000;
	TIM1->CR2 = 0x0000;
	TIM1->CCMR1 &= ~(TIM_CCMR1_CC1S);
	TIM1->CCMR1 |= (TIM_CCMR1_CC1S_0);									// CC1 channel is configured as input and mapped to T1 
	
	TIM1->SMCR |= (TIM_SMCR_TS_2)|(TIM_SMCR_TS_0);						// 101: Filtered Timer Input 1 (TI1FP1)	
	TIM1->SMCR |= (TIM_SMCR_SMS_2);										// 100: Reset Mode - Rising edge of the selected trigger input (TRGI) reinitializes the counter
																		// and generates an update of the registers 
																														
	TIM1->CCER &= ~(TIM_CCER_CC1NP);									// 
	TIM1->CCER &= ~(TIM_CCER_CC1P);										// non-inverted/rising edge
	TIM1->CCER |= (TIM_CCER_CC1E);										// enable capture input

	TIM1->DIER |= (TIM_DIER_CC1IE);										// TIM3 capture event triggers the interrupt
	NVIC_EnableIRQ(TIM1_CC_IRQn);
	TIM1->CR1 |= TIM_CR1_CEN;
}


void TIM1_CC_IRQHandler(void)
{
	if(TIM1->SR & TIM_SR_CC1IF)
	{
		uint32_t ccr1 = TIM1->CCR1;
		if(ccr1 != 0x0000 ) 
		{
			g_pwm_input_cnt++;
		}
	}	
	TIM1->SR = ~TIM_SR_CC1IF;
}

