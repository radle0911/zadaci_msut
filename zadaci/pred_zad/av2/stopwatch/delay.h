#ifndef __DELAY_H
#define __DELAY_H

#include "stm32f4xx.h"

void 		delay_ms(uint32_t ms);				// 													
void 		delay_us(uint32_t ms);				// 


void 		initSTOPWATCH(void);
void 		startSTOPWATCH(void);
uint32_t 	stopSTOPWATCH(void);

#endif 
