#include "stm32f4xx.h"
#include "delay.h"
#include "usart.h"

int main(void)
{
	uint32_t led_timer;
	uint8_t k, n;
	uint16_t states[8] = {0xF000,0xE000,0xC000,0x8000,0x0000,0x1000,0x3000,0x7000};
	
	uint32_t utmp32 = 0;
	
	initUSART2(USART2_BAUDRATE_921600);
	enIrqUSART2();
	initSYSTIMER();
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// setup peripherals
	///-----------------------------------------------------------------
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;  								
    GPIOD->MODER |= 0x55000000;             							
    GPIOD->OTYPER |= 0x00000000;										
    GPIOD->OSPEEDR |= 0xFF000000; 		
    
    led_timer = getSYSTIMER();
	printUSART2("-> SYS: init completed\n");								
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	
	k = 0;
	while(1)
	{
		if(chk4TimeoutSYSTIMER(led_timer, 500000) == (SYSTIMER_TIMEOUT))
		{// non blocking
			GPIOD->ODR &= 0x0FFF;
			GPIOD->ODR |= states[k];
			k++;
			if(k == 8)
				k = 0;
			
			led_timer = getSYSTIMER();
		}
		
		//chkRxBuffUSART2();
	}
}

