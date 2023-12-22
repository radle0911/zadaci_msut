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
	uint32_t utmp32, k = 0;
	uint16_t utmp16;
	
	initSYSTIMER();
	initLED();
	initUSART2(USART2_BAUDRATE_115200);
	initADC1();
	
	
	while(1)
	{
		utmp32 = getADC1();

		printUSART2("-> ADC[%d]:  [%d/4095]\n",k,utmp32);
		
		utmp32 = ((3000*utmp32)/4095);
		printUSART2("-> ADC: %d[mV]\n",utmp32);
		
		delay_ms(100);
		k++;
		doLED();
	}
}

void initLED(void)
{
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// STM32F407 on Board LED init PD12-PD15 
	///-----------------------------------------------------------------
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;  								// 
    GPIOD->MODER |= 0x55000000;             							// 
    GPIOD->OTYPER |= 0x00000000;										// 
    GPIOD->OSPEEDR |= 0xFF000000; 										// 
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
