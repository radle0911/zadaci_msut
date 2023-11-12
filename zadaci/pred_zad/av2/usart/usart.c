#include "usart.h"

void initUSART2(uint32_t baudrate)
{
	//wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	// USART2 initialization on PA2 -> TX & PA3 -> RX
	//------------------------------------------------------------------ 
	RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN; 									
	RCC->APB1ENR |= RCC_APB1ENR_USART2EN; 								
	GPIOA->MODER |= (GPIO_MODER_MODER2_1)|(GPIO_MODER_MODER3_1); 	
	// GPIOA->AFR[0 ili 1] ide AF-0... sve do AF-15 	
	// PA0 prvih 7 pinova AFR[0] od 8 do 15 AFR[1] kontrolisemo
	// koristimo PA2 i PA3 za RX i TX
	GPIOA->AFR[0] |= 0x00007700;	// svaki od hex cifara predstavlja alt funkciju pina, 77 se stavlja da bi postavili PA2 i PA3 u alt funkciju pina									
	USART2->BRR = baudrate;												// default 1 stop bit, 8 data bits, no parity	
																		// no flow control
	USART2->CR1 = USART_CR1_UE|USART_CR1_TE;							// enable usart		
}

void putcharUSART2(uint8_t data)
{/// print one character to USART2
	while(!(USART2->SR & USART_SR_TC));									// wait until last transmission is over
	
	USART2->DR = data;													// send data
}
