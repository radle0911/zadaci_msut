#include "stm32f4xx.h"
#include "usart.h"
#include "delay.h"

#define BUFF_SIZE  50 

void initGpioDMA2(uint16_t * buff0, uint16_t * buff1, uint16_t tsize);

int main(void)
{
	uint32_t utmp32, k = 0;
	uint8_t n = 0;
	uint16_t buff0[BUFF_SIZE];
	uint16_t buff1[BUFF_SIZE];
	
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;
	GPIOA->MODER &= ~0x00000003;  
	GPIOA->PUPDR |= 0x00000002;		
	
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;  								//  
    GPIOD->MODER |= 0x55000000;             							// 
    GPIOD->OTYPER |= 0x00000000;										// 
    GPIOD->OSPEEDR |= 0xFF000000; 										// 
	
	initUSART2(USART2_BAUDRATE_921600);
	printUSART2("\n\nwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\n");
	printUSART2("w GPIO DMA demo");
	printUSART2("\nwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\n");
	initGpioDMA2(buff0, buff1, BUFF_SIZE);
	
	
	while(1)
	{	
		if((DMA2_Stream5->CR & DMA_SxCR_CT) == DMA_SxCR_CT)
    	{// we can read buffer 0
			if(n == 0)
			{
				printUSART2("-> DMA2: checking buff0\n");
				for(k=0;k<(BUFF_SIZE);k++)
				{
					if(buff0[k] & 0x0001)
					{
						GPIOD->ODR |= 0xF000;
					}
					else
					{
						GPIOD->ODR &= ~(0xF000);
					}
				}
				n = 1;
				printUSART2("-> DMA2: completed 0\n");
			}
		}
		else
		{// we can read buffer 1
			if(n == 1)
			{
				printUSART2("-> DMA2: checking buff1\n");
				for(k=0;k<(BUFF_SIZE);k++)
				{
					if(buff0[k] & 0x0001)
					{
						GPIOD->ODR |= 0xF000;
					}
					else
					{
						GPIOD->ODR &= ~(0xF000);
					}
				}
				n = 0;
				printUSART2("-> DMA2: completed 1\n");
			}
		}
		
	}
}

void initGpioDMA2(uint16_t * buff0, uint16_t * buff1, uint16_t tsize)
{
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// setup TIM3 for ADC1 TRGO event
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	RCC->APB2ENR |= RCC_APB2ENR_TIM1EN; 								// enable TIM1
	TIM1->PSC = 0x00A8-0x0001;											// set TIM1 counting prescaler to 42 (p406)
																		// 84MHz/100 = 840kHz 
	TIM1->ARR = 0x03E8;													// reload value set to 10 kHz!
	TIM1->CR1 = 0x0084;													// ARPE On, CMS disable, Up counting
																		// UEV disable, TIM3 enable(p392)
	TIM1->CR2 = TIM_CR2_MMS_1;											// Update event is used to as trigger output (TRGO)
	
	TIM1->DIER |= (TIM_DIER_UDE)|(TIM_DIER_TDE);						// update event DMA request generation	
	TIM1->EGR |= (TIM_EGR_UG);											// update event, reload all config p363

	TIM1->CR1 |= TIM_CR1_CEN;											// start counter

	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// Setup DMA2 controller for ADC1 p179
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	RCC->AHB1ENR |= RCC_AHB1ENR_DMA2EN;									// enable DMA1 clock
	
	DMA2_Stream5->CR = 0x00000000;										// disable stream 0 (ADC1)
	while((DMA2_Stream5->CR & DMA_SxCR_EN) == DMA_SxCR_EN);				// wait until the DMA transfer is completed
	
	DMA2->LISR = 0x00000000;	
	DMA2->HISR = 0x00000000;	
	
	DMA2_Stream5->PAR = (uint32_t)&GPIOA->IDR;
	DMA2_Stream5->M0AR = (uint32_t)buff0;								// memory address of first buffer
	DMA2_Stream5->M1AR = (uint32_t)buff1;								// memory address of first buffer
	DMA2_Stream5->NDTR = tsize;											// number of samples to write
								
	DMA2_Stream5->CR |= (DMA_SxCR_CHSEL_2)|(DMA_SxCR_CHSEL_1);			// select channel 6
	DMA2_Stream5->CR |= DMA_SxCR_PL;									// select stream priority to very high
																		// - DMA is flow controller
																		// - Peripheral address pointer is fixed																		
	DMA2_Stream5->CR |= DMA_SxCR_MINC;									// Memory address pointer is incremented
																		// in accordance with the memory data size																	
	DMA2_Stream5->CR |= DMA_SxCR_DBM;									// Double buffer mode																
	DMA2_Stream5->CR |= DMA_SxCR_CIRC;									// Double buffer mode
	DMA2_Stream5->CR |= DMA_SxCR_PSIZE_0;								// Peripheral data size:
																		// - Half Word 16-bit
	DMA2_Stream5->CR |= DMA_SxCR_MSIZE_0;								// Memory data size:
																		// - Half Word 16-bit
	DMA2_Stream5->CR &= ~DMA_SxCR_DIR;									// Data transfer direction: 
																		// - 00 -> Peripheral-to-memory
	DMA2_Stream5->CR |= DMA_SxCR_EN;									// enable stream 0 (ADC1)

}
