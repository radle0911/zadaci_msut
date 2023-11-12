#include "stm32f4xx.h"

void delay_soft_ms(uint32_t cnt);

int main(void)
{
	uint32_t k;
	uint16_t states[8] = {0xF000,0xE000,0xC000,0x8000,0x0000,0x1000,0x3000,0x7000};
	
	
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// inicijalizacija
	///-----------------------------------------------------------------
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;  								//  
    GPIOD->MODER |= 0x55000000;             							// 
    GPIOD->OTYPER |= 0x00000000;										// 
    GPIOD->OSPEEDR |= 0xFF000000; 										// 
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	
	k = 0;
	while(1)
	{
		GPIOD->ODR &= 0x0FFF;
		GPIOD->ODR |= states[k];
		
		delay_soft_ms(100);
		
		k++;
		if(k == 8)
			k = 0;
	}
}

void delay_soft_ms(uint32_t cnt)
{/// primitivna rutina za kasnjenje 									
	volatile uint32_t time = cnt*10500;											
																		// 																// za kasnjenje
	while(time)
	{
		time--;
	}														
	
	return;
}

