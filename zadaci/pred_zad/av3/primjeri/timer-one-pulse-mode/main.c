#include "stm32f4xx.h"
#include "delay.h"
#include "usart.h"
#include "pbtn.h"

void initOpmTIMER(void);

int main(void)
{
	uint32_t cnt = 0;
	uint8_t btn_state = 0, tbnt_state = 0;
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// init system peripherals
	///-----------------------------------------------------------------	
	initUSART2(USART2_BAUDRATE_921600);
	initSYSTIM();
	initPBTN();
	initOpmTIMER();
	
	printUSART2("-> SYS: init completed\n");
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	
	while(1)
	{			
		
		tbnt_state = chkPBTN();
		if(tbnt_state != btn_state)
		{
			if(btn_state == (PBTN_IRQ_IDLE))
			{
				printUSART2("-> PBTN: action [%d]\n",cnt);
				cnt++;
			}
			btn_state = tbnt_state;
		}
	}
}

void initOpmTIMER(void)
{
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// setup TIM4 CH1, CH2, CH3 & CH4 -> PD12, PD13, PD14 & PD15
	///----------------------------------------------------------------
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;  								//
    GPIOD->MODER |= 0xAA000000;             							//
    GPIOD->OTYPER |= 0x00000000; 										//
	GPIOD->AFR[1] |= 0x22220000;										//  
	
	{ 
		RCC->APB1ENR |= RCC_APB1ENR_TIM4EN; 							// enable TIM4 on APB1 
		TIM4->PSC = 0xA410 - 0x0001;									// set TIM4 counting prescaler 
																		// 84MHz/42000 = 2kHz -> 500us
		TIM4->ARR = 3000*2;												
		
		TIM4->CCR1 = 500*2;												
		TIM4->CCR2 = 1000*2;
		TIM4->CCR3 = 1500*2;
		TIM4->CCR4 = 2000*2;
		
		TIM4->CCMR1 |= (TIM_CCMR1_OC1PE)|(TIM_CCMR1_OC1M_2)|(TIM_CCMR1_OC1M_1);
		TIM4->CCMR1 |= (TIM_CCMR1_OC2PE)|(TIM_CCMR1_OC2M_2)|(TIM_CCMR1_OC2M_1);	
		TIM4->CCMR2 |= (TIM_CCMR2_OC3PE)|(TIM_CCMR2_OC3M_2)|(TIM_CCMR2_OC3M_1);	
		TIM4->CCMR2 |= (TIM_CCMR2_OC4PE)|(TIM_CCMR2_OC4M_2)|(TIM_CCMR2_OC4M_1);					
																			//// set PWM 1 mod, enable OC1PE preload mode 
																			
		//// set active mode high for pulse polarity
		TIM4->CCER |= ((TIM_CCER_CC1P)|(TIM_CCER_CC2P)|(TIM_CCER_CC3P)|(TIM_CCER_CC4P));
		TIM4->CR1 = (TIM_CR1_ARPE)|(TIM_CR1_OPM);
		
		// update event, reload all config 
		TIM4->EGR |= TIM_EGR_UG;											
		// activate capture compare mode
		TIM4->CCER |= (TIM_CCER_CC1E)|(TIM_CCER_CC2E)|(TIM_CCER_CC3E)|(TIM_CCER_CC4E);
		// start counter										
		//TIM4->CR1 |= TIM_CR1_CEN;	
	}										
}
