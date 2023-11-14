#include "delay.h"

void delay_ms(uint32_t ms)
{/// delay in ms 
 
	RCC->APB1ENR |= RCC_APB1ENR_TIM12EN; 								// 
	TIM12->PSC = 0x0054 - 0x0001;										// APB1@42MHz
																		// fck_psc / (PSC[15:0] + 1) =>
																		// => 84MHz / (83 + 1 ) = 84MHz / 84 =>
																		// => 1MHz = 1us(mikrosekunda)
	TIM12->ARR = 0x03E8;												// reload 1000 us = 1ms
	TIM12->CR1 = 0x0084;												// ARPE On, CMS disable, Up counting

	TIM12->EGR |= TIM_EGR_UG;											// reload all config p363
// linija TIM_EGR_UG je konstanta koja predstavlja bit za generisanje Update eventa-a za registar EGR za tajmer TIM12
	TIM12->CR1 |= TIM_CR1_CEN;											// start counter
	// govorimo da clock krene sa brojanjem 
	while(ms > 0)
	{
																		
		while((TIM12->SR & TIM_SR_UIF) == 0x0000);						// wait for update event  UIF ce otici u 1 i ostati 
		// znaci TIM->SR (status register ) treba cijelo vrijeme da bude 0 kako bi normalno sve radilo
		
		TIM12->SR &= ~TIM_SR_UIF;										// clear the update event interrupt flag
																		// u linij iznad vracamo UIF ponovo na 0
		ms--;
	} 
	TIM12->CR1 &= ~TIM_CR1_CEN;											// stop counter 
	RCC->APB1ENR &= ~RCC_APB1ENR_TIM12EN;								// disable TIM 
}

void delay_us(uint32_t us)
{/// delay in us 
    
	RCC->APB1ENR |= RCC_APB1ENR_TIM12EN; 								// enable TIM12 za registar APB1 2x42 = 84 MHz
	TIM12->PSC = 0x0000;										// 0 nista ne skaliramo 
																		// 
	TIM12->ARR = 0x0053;			// ovdje je bolje staviti 0x0053 jer ARR + 1 		// reload value set to 1 us
	// vrijeme reload-a = ARR + 1 / Takt brojaca (84MHz) = 83 + 1 / 84 MHz = 1us
	// 0x0054 = 84 to znaci da ce brojati od 0 do 83 pa uraditi reload
	TIM12->CR1 = 0x0084;												// ARPE On, CMS disable, Up counting
																		// UEV disable, TIM4 enable(p392)

	TIM12->EGR |= TIM_EGR_UG;											//reload all config p363
	TIM12->CR1 |= TIM_CR1_CEN;											// start counter
	while(us > 0)
	{
																		
		while((TIM12->SR & TIM_SR_UIF) == 0x0000);						// wait for update event
		
		TIM12->SR &= ~TIM_SR_UIF;										// clear the update event interrupt flag
		us--;
	} 
	TIM12->CR1 &= ~TIM_CR1_CEN;											// stop counter 
	RCC->APB1ENR &= ~RCC_APB1ENR_TIM12EN;								// disable TIM4 
}
	
