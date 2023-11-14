#include "pbtn.h"

volatile uint8_t g_pbtn_irq_state = (PBTN_IRQ_IDLE);
volatile uint32_t g_pbtn_irq_timer = 0;

void initPBTN(void)
{
	RCC->APB2ENR |= RCC_APB2ENR_SYSCFGEN;								// enable clock on SYSCFG register
	NVIC_EnableIRQ(EXTI0_IRQn);
	SYSCFG->EXTICR[0] = SYSCFG_EXTICR1_EXTI0_PA;						// select PA 0 as interrupt source p259
	EXTI->IMR = EXTI_IMR_MR0;											// enable interrupt on EXTI_Line0
	EXTI->EMR &= ~EXTI_EMR_MR0;											// disable event on EXTI_Line0
	EXTI->RTSR = EXTI_RTSR_TR0;	
	EXTI->FTSR = 0x00000000;		
}

uint8_t chkPBTN(void)
{
	switch(g_pbtn_irq_state)
	{
		case(PBTN_IRQ_IDLE):
		{
			break;
		}
		case(PBTN_IRQ_DETECTED):
		{
			g_pbtn_irq_state = (PBTN_IRQ_WAIT4LOW); 
			break;
		}
		case(PBTN_IRQ_WAIT4LOW):
		{
			if((GPIOA->IDR & 0x0001) == 0x0000)
			{
				g_pbtn_irq_state = (PBTN_IRQ_DEBOUNCE);
				g_pbtn_irq_timer = getSYSTIM(); 
			}
			break;
		}
		case(PBTN_IRQ_DEBOUNCE):
		{
			if(chk4TimeoutSYSTIM(g_pbtn_irq_timer, 50) == (SYSTIM_TIMEOUT))
			{
				g_pbtn_irq_state = (PBTN_IRQ_IDLE); 
			}
		}
		default:
		{
			break;
		}
	}
	
	return g_pbtn_irq_state;
}

void EXTI0_IRQHandler(void)
{
	if((EXTI->PR & EXTI_PR_PR0) == EXTI_PR_PR0)							// EXTI_Line0 interrupt pending?
	{
		if(g_pbtn_irq_state == (PBTN_IRQ_IDLE))
		{
			g_pbtn_irq_state = (PBTN_IRQ_DETECTED);
			TIM4->CR1 &= ~TIM_CR1_CEN;	
			TIM4->CR1 |= TIM_CR1_CEN;	
		}
		EXTI->PR = EXTI_PR_PR0;											// clear EXTI_Line0 interrupt flag
	}
}

