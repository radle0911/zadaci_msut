#include "adc.h"

void initADC1(void)
{/// initialize ADC on PA1 -> ADC123_IN1 (pin 23 on chip)
	//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	// ADC initialization
	//------------------------------------------------------------------ 
	
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN; 								/** GPIOA Periph clock enable */	
	RCC->APB2ENR |= RCC_APB2ENR_ADC1EN; 								/** ADC1 Periph clock enable */	
	GPIOA->MODER |= GPIO_MODER_MODER1;  								/** Set Analog mode on pin 1 */
	GPIOA->PUPDR &= ~GPIO_PUPDR_PUPDR1; 								/** No pullup or pulldown */
	
	ADC1->CR1 = 0x00000800;												// 12-bit resolution (15 ADCCLK cycles), 1 channel
																		// discontinious mode on regular channels
																		// single conversion mode
	ADC1->SMPR1 = 0x00000000;											// conversion time 3 cycles of 84MHz clock!
	ADC1->SQR1 = 0x000000000;											// select one channel in regular sequence
	ADC1->SQR3 = 0x000000001;											// select channel 1
	ADC1->CR2 =  0x000000200;
	ADC->CCR = 0x00030000;												// ADC clock is (0.6,14MHz) 84/8 = 14MHz!!!
}

uint16_t getADC1(void)
{
	uint16_t r_val;
	
	ADC1->CR2 |= ADC_CR2_ADON;											// turn on the ADC
	ADC1->CR2 |= ADC_CR2_SWSTART;										// start conversion of regular channels
	
	while((ADC1->SR & ADC_SR_EOC) != ADC_SR_EOC);						// wait for regular channel to complete the conversion
	
	r_val = ADC1->DR;													// get the data

	ADC1->CR2 &= ~ADC_CR2_ADON;											// turn off the ADC
	return r_val; 
}

void initDmaADC1(uint16_t * dBuff1, uint16_t * dBuff2, uint16_t size)
{
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// Init ADCs
	/// ADC1 -> PC5 IN15
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOCEN;								/** GPIOC Periph clock enable */
	
	GPIOC->MODER |= GPIO_MODER_MODER5;									/** Set Analog mode on pin 5 */
	GPIOC->PUPDR &= ~GPIO_PUPDR_PUPDR5; 								/** No pullup or pulldown */
	RCC->APB2ENR |= RCC_APB2ENR_ADC1EN; 								/** ADC1 Periph clock enable */					
					
	
	ADC1->CR1 = 0x00000800;												// 12-bit resolution (15 ADCCLK cycles), 1 channel
	//ADC1->CR1 = ADC_CR1_RES|ADC_CR1_DISCEN;								// 6 bit resolution (9 ADCCLK cycles),1 channel	
																		// Discontinious mode on regular channels
																		// single conversion mode
	ADC1->SMPR1 = 0x00000000;											// conversion time 3 cycles of 84MHz clock!
	ADC1->SQR1 = 0x000000000;											// select one channel in regular sequence
	ADC1->SQR2 = 0x000000000;
	ADC1->SQR3 = 0x00000000F;											// select channel 15
	ADC1->CR2 =  0x000000200;
	
	ADC->CCR = 0x00010000;												// ADC clock 84/4 = 21MHz!
	
	
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// setup TIM3 for ADC1 TRGO event
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	RCC->APB1ENR |= RCC_APB1ENR_TIM3EN; 								// enable TIM3 
	TIM3->PSC = 0x0064-0x0001;											// set TIM3 counting prescaler to 42 (p406)
																		// 84MHz/100 = 840kHz 
	TIM3->ARR = 0x0054;													// reload value set to 10 kHz!
	TIM3->CR1 = 0x0084;													// ARPE On, CMS disable, Up counting
																		// UEV disable, TIM3 enable(p392)
	TIM3->CR2 = 0x0000;
	TIM3->CR2 = TIM_CR2_MMS_1;											// Update event is used to as trigger output (TRGO)

	TIM3->EGR |= TIM_EGR_UG;											// update event, reload all config p363
	TIM3->CR1 |= TIM_CR1_CEN;											// start counter

	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// Setup ADCs with DMA
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	ADC1->CR2 = ADC_CR2_DMA;											// enable DMA
	ADC1->CR2 |= ADC_CR2_DDS;											// enable DDS
	ADC1->CR2 |= ADC_CR2_EXTEN_0;										// trigger detection on the rising edge
	ADC1->CR2 |= (ADC_CR2_EXTSEL_3);									// 1000: Timer 3 TRGO event
	ADC1->CR2 |= ADC_CR2_ADON;
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// Setup DMA2 controller for ADC1 p179
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	RCC->AHB1ENR |= RCC_AHB1ENR_DMA2EN;									// enable DMA2 clock
	
	DMA2_Stream0->CR = 0x00000000;										// disable stream 0 (ADC1)
	while((DMA2_Stream0->CR & DMA_SxCR_EN) == DMA_SxCR_EN);				// wait until the DMA transfer is completed
	
	DMA2->LISR = 0x00000000;	
	DMA2->HISR = 0x00000000;	
	
	DMA2_Stream0->PAR = (uint32_t)&ADC1->DR;							// peripheral port register address (ADC1)
	DMA2_Stream0->M0AR = (uint32_t)dBuff1;								// memory address of first buffer
	DMA2_Stream0->M1AR = (uint32_t)dBuff2;								// memory address of first buffer
	DMA2_Stream0->NDTR = size;											// number of samples to write
	
	DMA2_Stream0->CR &= ~DMA_SxCR_CHSEL;								// select channel 0 for ADC1
	DMA2_Stream0->CR |= DMA_SxCR_PL;									// select stream priority to very high
																		// - DMA is flow controller
																		// - Peripheral address pointer is fixed																		
	DMA2_Stream0->CR |= DMA_SxCR_MINC;									// Memory address pointer is incremented
																		// in accordance with the memory data size																	
	DMA2_Stream0->CR |= DMA_SxCR_DBM;									// Double buffer mode
	DMA2_Stream0->CR |= DMA_SxCR_PSIZE_0;								// Peripheral data size:
																		// - Half Word 16-bit
	DMA2_Stream0->CR |= DMA_SxCR_MSIZE_0;								// Memory data size:
																		// - Half Word 16-bit
	DMA2_Stream0->CR &= ~DMA_SxCR_DIR;									// Data transfer direction: 
																		// - 00 -> Peripheral-to-memory
	DMA2_Stream0->CR |= DMA_SxCR_EN;									// enable stream 0 (ADC1)
}


