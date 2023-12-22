#ifndef __USART_H
#define __USART_H


#include "stm32f4xx.h"

#define USART_BAUDRATE_460800	0x0000005B // 42MHz / 460800 = 91 (APB1 = 42MHz)
#define USART_BAUDRATE_115200	0x0000016C
#define USART_BAUDRATE_9600	0x00001117


void setBaudrateUSART2(uint32_t baudrate);
void putCharUSART2(uint8_t data);




#endif
