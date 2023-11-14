#include "stm32f4xx.h"
#include "delay.h"
#include "usart.h"

int main(void)
{
	uint32_t led_timer, cnt = 0;
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// init system peripherals
	///-----------------------------------------------------------------
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;  								// 
    GPIOD->MODER |= 0x55000000;             							// 
    GPIOD->OTYPER |= 0x00000000;										// 
    GPIOD->OSPEEDR |= 0xFF000000; 										// 
		
	initUSART2(USART2_BAUDRATE_921600);
	initSYSTIM();

	printUSART2("-> SYS: init completed\n");
	led_timer = getSYSTIM();
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	
	while(1)
	{	
		if(chk4TimeoutSYSTIM(led_timer, 500) == (SYSTIM_TIMEOUT))
		{
			GPIOD->ODR ^= 0xA000;
			
			led_timer = getSYSTIM();
			cnt++;
			printUSART2("-> SYS: CNT [%d]\n",cnt);
		}	
	}
	
	return 0;
}
