#include "adc.h"

void initADC1(void)
{/// initialize ADC on PA1 -> ADC123_IN1 (pin 23 on chip)
	//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	// init ADC on PA1
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
	ADC->CCR = 0x00030000;												// ADC clock is (0.6,14MHz) 84/8 = 10.5MHz!!!
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
