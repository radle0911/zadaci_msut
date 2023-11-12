#define STM32F407xx
#include "stm32f4xx.h"

int main(void)
{
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// inicijalizacija
	///-----------------------------------------------------------------
	// #define  RCC_AHB1ENR_GPIODEN                 ((uint32_t)0x00000008)
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;                                //
	// 31 ----------------------------------- 0
	// |15|14|13|12|
	// |01 01|01 01|0000|0000|0000|0000|0000|0000 
    GPIOD->MODER |= 0x55000000;             							// 
    GPIOD->OTYPER |= 0x00000000;										// 
    GPIOD->OSPEEDR |= 0xFF000000; 										// 
	
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;
	// 31 ----------------------------------- 0
	// |0000|0000|0000|0000|0000|0000|0000|0011 
	GPIOA->MODER &= ~0x00000003;  
	GPIOA->PUPDR |= 0x00000002;								
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	
	
	while(1)
	{
		if((GPIOA->IDR & 0x0001) == 0x0001)
		{
			GPIOD->ODR |= 0xF000;
		}
		else
		{
			GPIOD->ODR &= ~0xF000;
		}
	}
}
