#ifndef __IWDG_H
#define __IWDG_H

#include "stm32f4xx.h"
#include "delay.h"
#include "usart.h"

uint8_t chk4StartupIWDG(void);
void 	initIWDG(uint16_t sec);
void 	feedIWDG(void);
void 	chkIWDG(void);
#endif 
