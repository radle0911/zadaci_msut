#include "stm32f4xx.h"
#include "adc.h"
#include "usart.h"
#include "delay.h"

void doLED(void);
void initLED();
volatile uint16_t g_led_state[8] = {0xF000,0xE000,0xC000,0x8000,0x0000,0x1000,0x3000,0x7000};
volatile uint8_t g_led_k;

int main(void)
{
	uint8_t c;
	uint32_t utmp32, k = 0,n ;
	uint16_t utmp16;
	
	initLED();
	initUSART2(USART2_BAUDRATE_115200);
	initADC1();

	//printUSART2("Starting MATLAB - USART2 - ADC App...\n",&utmp32);
	while(1)
	{
		c = getcharUSART2();
		for(n=0;n<128;n++)
		{
			utmp16 = getADC1();
			putcharUSART2((utmp16&0xFF00)>>8);
			putcharUSART2(utmp16&0x00FF);
		}
		
		k++;
		doLED();
	}
}

void initLED(void)
{
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// STM32F407 on Board LED init PD12-PD15 
	///-----------------------------------------------------------------
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;  								// aktiviramo GPIOD port (takt impulsi)
    GPIOD->MODER |= 0x55000000;             							// proglasimo pinove 12,13,14,15 kao izlaz
    GPIOD->OTYPER |= 0x00000000;										// onemogucimo 
    GPIOD->OSPEEDR |= 0xFF000000; 										// maksimalna brzina (tranzicije 100MHz)
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 
	GPIOD->ODR &= 0x0FFF;
}

void doLED(void)
{
	GPIOD->ODR &= 0x0FFF;
	GPIOD->ODR |= g_led_state[g_led_k];
	g_led_k++;
	if(g_led_k == 8)
		g_led_k = 0;	
}
