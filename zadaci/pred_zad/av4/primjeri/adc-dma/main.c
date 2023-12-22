#include "stm32f4xx.h"
#include "adc.h"
#include "usart.h"
#include "delay.h"

#define ADC_BUFF_SIZE		1024
static uint16_t adc_buff0[ADC_BUFF_SIZE];
static uint16_t adc_buff1[ADC_BUFF_SIZE];

int main(void)
{
	uint32_t utmp32, k = 0;
	uint8_t n = 0;

	initUSART2(USART2_BAUDRATE_921600);
	initDmaADC1(adc_buff0, adc_buff1, ADC_BUFF_SIZE);					// init ADC1 in double buffer DMA mode
	delay_ms(10);
	
	while(1)
	{
		if((DMA2_Stream0->CR & DMA_SxCR_CT) == DMA_SxCR_CT)
    	{// we can read buffer 0
			if(n == 1)
			{
				k = 0;
				n = 0;
			}
			
			printUSART2("R[0: %d] W[1: %d] adc_buff1",k, DMA2_Stream0->NDTR);
      		utmp32 = adc_buff0[k];
		}
		else
		{// we can read buffer 1
			if(n == 0)
			{
				k = 0;
				n = 1;
			}
			
			printUSART2("R[1: %d] W[0: %d] adc_buff1",k, DMA2_Stream0->NDTR);
			utmp32 = adc_buff1[k];
		}
		k++;
		if(k >= (ADC_BUFF_SIZE))
			k = 0;
		
			
		printUSART2("-> ADC: %d\n\n",utmp32);
		delay_ms(10);
	}
}
