#ifndef __USART_H
#define __USART_H
#include "stm32f4xx.h"

#define USART2_BAUDRATE_460800		0x0000005B
#define USART2_BAUDRATE_115200		0x0000016C
#define USART2_BAUDRATE_9600		0x00001117

void 	initUSART2(uint32_t baudrate);
void 	putcharUSART2(uint8_t data);

#endif 
