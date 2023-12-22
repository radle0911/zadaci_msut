#include "stm32f4xx.h"
#include "adc.h"
#include "usart.h"
#include "delay.h"

#define ADC_BUFF_SIZE		1000

void blinkLED(void);
void initLED();
volatile uint16_t g_led_state[8] = {0xF000,0xE000,0xC000,0x8000,0x0000,0x1000,0x3000,0x7000};
volatile uint8_t g_led_k;


int main(void)
{
	uint32_t utmp32, k = 0;
	uint8_t n = 0, c;
	uint16_t utmp16;
	uint16_t adc_buff0[ADC_BUFF_SIZE];
	uint16_t adc_buff1[ADC_BUFF_SIZE];
	
	initLED();
	initUSART2(USART2_BAUDRATE_921600);
	initDmaADC1(adc_buff0, adc_buff1, ADC_BUFF_SIZE);					// init ADC1 in double buffer DMA mode

	while(1)
	{
		c = getcharUSART2();
		if((DMA2_Stream0->CR & DMA_SxCR_CT) == DMA_SxCR_CT)
    	{// we can read buffer 0
		
			for(k=0;k<(100);k++)
			{
				utmp16 = adc_buff0[k];
				putcharUSART2((utmp16&0xFF00)>>8);
				putcharUSART2(utmp16&0x00FF);
			}
		}
		else
		{// we can read buffer 1
			n = 1;
			for(k=0;k<(100);k++)
			{
				utmp16 = adc_buff1[k];
				putcharUSART2((utmp16&0xFF00)>>8);
				putcharUSART2(utmp16&0x00FF);
			}
		}
		blinkLED();
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

void blinkLED(void)
{
	GPIOD->ODR &= 0x0FFF;
	GPIOD->ODR |= g_led_state[g_led_k];
	g_led_k++;
	if(g_led_k == 8)
		g_led_k = 0;	
}
