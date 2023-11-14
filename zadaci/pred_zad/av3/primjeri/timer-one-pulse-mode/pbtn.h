#ifndef __PBTN_H_
#define __PBTN_H_

#include "stm32f4xx.h"
#include "delay.h"

#define PBTN_IRQ_IDLE			0
#define PBTN_IRQ_DETECTED		1
#define PBTN_IRQ_WAIT4LOW		2
#define PBTN_IRQ_DEBOUNCE		3


void initPBTN(void);
uint8_t chkPBTN(void);


#endif 
