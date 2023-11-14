#include "stm32f4xx.h"
#include "delay.h"
#include "usart.h"

#define IRQ_IDLE			0
#define IRQ_DETECTED		1
#define IRQ_WAIT4LOW		2
#define IRQ_DEBOUNCE		3

volatile uint32_t g_irq_cnt = 0;
volatile uint8_t g_gpioa_irq_state = (IRQ_IDLE);
volatile uint32_t g_irq_timer = 0;

void serviceIRQA(void);

int main(void)
{
	uint32_t led_timer;
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// init system peripherals
	///-----------------------------------------------------------------
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;  								// 
    GPIOD->MODER |= 0x55000000;             							// 
    GPIOD->OTYPER |= 0x00000000;										// 
    GPIOD->OSPEEDR |= 0xFF000000; 										// 
		
	initUSART2(USART2_BAUDRATE_921600);
	initSYSTIMER();
	
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;
	GPIOA->MODER &= ~0x00000003;  										// 
	
	RCC->APB2ENR |= RCC_APB2ENR_SYSCFGEN;								// enable clock on SYSCFG register
	NVIC_EnableIRQ(EXTI0_IRQn);
	SYSCFG->EXTICR[0] = SYSCFG_EXTICR1_EXTI0_PA;						// select PA 0 as interrupt source p259
	EXTI->IMR = EXTI_IMR_MR0;											// enable interrupt on EXTI_Line0
	EXTI->EMR &= ~EXTI_EMR_MR0;											// disable event on EXTI_Line0
	EXTI->RTSR = EXTI_RTSR_TR0;	
	EXTI->FTSR = 0x00000000;	
	
	printUSART2("-> SYS: init completed\n");
	led_timer = getSYSTIMER();
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	
	while(1)
	{	
		if(chk4TimeoutSYSTIMER(led_timer, 500000) == (SYSTIMER_TIMEOUT))
		{
			GPIOD->ODR ^= 0xA000;
			led_timer = getSYSTIMER();
		}
			
		
		serviceIRQA();
	}
}


//void EXTI0_IRQHandler(void)
//{// with 
	//if((EXTI->PR & EXTI_PR_PR0) == EXTI_PR_PR0)							// EXTI_Line0 interrupt pending?
	//{
		//GPIOD->ODR ^= 0x5000;           								// Toggle the pin 
		//g_irq_cnt++;
		//printUSART2("-> IRQ event [%d]\n",g_irq_cnt);
		
		//EXTI->PR = EXTI_PR_PR0;											// clear EXTI_Line0 interrupt flag
	//}
//}

void EXTI0_IRQHandler(void)
{
	if((EXTI->PR & EXTI_PR_PR0) == EXTI_PR_PR0)							// EXTI_Line0 interrupt pending?
	{
		if(g_gpioa_irq_state == (IRQ_IDLE))
		{
			GPIOD->ODR ^= 0x5000;           								// Toggle the pin 
			g_gpioa_irq_state = (IRQ_DETECTED);
		}
		EXTI->PR = EXTI_PR_PR0;											// clear EXTI_Line0 interrupt flag
	}
}

void serviceIRQA(void)
{
	switch(g_gpioa_irq_state)
	{
		case(IRQ_IDLE):
		{
			break;
		}
		case(IRQ_DETECTED):
		{
			g_irq_cnt++;
			printUSART2("-> IRQ event [%d]\n", g_irq_cnt);
			g_gpioa_irq_state = (IRQ_WAIT4LOW); 
			break;
		}
		case(IRQ_WAIT4LOW):
		{
			if((GPIOA->IDR & 0x0001) == 0x0000)
			{
				g_gpioa_irq_state = (IRQ_DEBOUNCE);
				g_irq_timer = getSYSTIMER(); 
			}
			break;
		}
		case(IRQ_DEBOUNCE):
		{
			if(chk4TimeoutSYSTIMER(g_irq_timer, 50000) == (SYSTIMER_TIMEOUT))
			{
				g_gpioa_irq_state = (IRQ_IDLE); 
			}
		}
		default:
		{
			break;
		}
	}
}
