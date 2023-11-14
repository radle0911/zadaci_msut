#include "stm32f4xx.h"
#include "delay.h"
#include "usart.h"

#define PWM_CNT_ARRAY_SIZE			10

int main(void)
{
	uint32_t cnt = 0, time;
	uint16_t pwm[PWM_CNT_ARRAY_SIZE] = {0,2,5,11,23,50,109,235,509,999};
	uint8_t pwm_cnt = 0;
	
	initUSART2(USART2_BAUDRATE_115200);
	printUSART2("\nwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\n");
	printUSART2("w Starting test app...");
	printUSART2("\nwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\n");
	
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// setup PWM on TIM4 CH1, CH2, CH3 & CH4 -> PD12, PD13, PD14 & PD15
	///----------------------------------------------------------------
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;  								//
    GPIOD->MODER |= 0xAA000000;             							//
    GPIOD->OTYPER |= 0x00000000; 										//
	GPIOD->AFR[1] |= 0x22220000;										//  
	
	{ 
		RCC->APB1ENR |= RCC_APB1ENR_TIM4EN; 							// enable TIM4 on APB1 
		TIM4->PSC = 0x0054 - 0x0001;									// set TIM4 counting prescaler 
																		// 84MHz/84 = 1MHz -> count each 1us
		TIM4->ARR = 0x03E8;												// period of the PWM 1ms
		
		TIM4->CCR1 = 0x0000;											// duty cycle for the PWM set to 0%
		TIM4->CCR2 = 0x0000;
		TIM4->CCR3 = 0x0000;
		TIM4->CCR4 = 0x0000;
		
		TIM4->CCMR1 |= (TIM_CCMR1_OC1PE)|(TIM_CCMR1_OC1M_2)|(TIM_CCMR1_OC1M_1);
		TIM4->CCMR1 |= (TIM_CCMR1_OC2PE)|(TIM_CCMR1_OC2M_2)|(TIM_CCMR1_OC2M_1);	
		TIM4->CCMR2 |= (TIM_CCMR2_OC3PE)|(TIM_CCMR2_OC3M_2)|(TIM_CCMR2_OC3M_1);	
		TIM4->CCMR2 |= (TIM_CCMR2_OC4PE)|(TIM_CCMR2_OC4M_2)|(TIM_CCMR2_OC4M_1);					
																			// set PWM 1 mod, enable OC1PE preload mode 
																			
		// set active mode high for pulse polarity
		TIM4->CCER &= ~((TIM_CCER_CC1P)|(TIM_CCER_CC2P)|(TIM_CCER_CC3P)|(TIM_CCER_CC4P));
		TIM4->CR1 |= (TIM_CR1_ARPE)|(TIM_CR1_URS);
		
		// update event, reload all config 
		TIM4->EGR |= TIM_EGR_UG;											
		// activate capture compare mode
		TIM4->CCER |= (TIM_CCER_CC1E)|(TIM_CCER_CC2E)|(TIM_CCER_CC3E)|(TIM_CCER_CC4E);
		// start counter										
		TIM4->CR1 |= TIM_CR1_CEN;											
	}
		
	while(1)
	{		
		TIM4->CCR1 = pwm[pwm_cnt];
		TIM4->CCR2 = pwm[pwm_cnt];
		TIM4->CCR3 = pwm[pwm_cnt];
		TIM4->CCR4 = pwm[pwm_cnt];	
		
		printUSART2("-> SW: test [%d]\n",cnt);
		cnt++;
		uint32_t utmp32 = TIM4->CNT;
		printUSART2("-> TIM4->CNT: [%d]\n",utmp32);
		delay_ms(500);
		pwm_cnt++;
		if(pwm_cnt == (PWM_CNT_ARRAY_SIZE))
			pwm_cnt = 0;
	}
}

