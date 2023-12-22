#include "stm32f4xx.h"
#include "rand.h"
#include "usart.h"
#include "delay.h"

volatile uint16_t pwm_val= 0;
volatile uint16_t rand_buff[256];
int main(void)
{
	uint8_t c;
	uint32_t utmp32, n;
	uint16_t utmp16;
	
	for(n=0;n<256;n++)
		rand_buff[n] = 0x00000000;
	
	initUSART2(USART2_BAUDRATE_115200);
	initSYSTIM();
	initSYSTIMER();


	while(1)
	{
		c = getcharUSART2();
		for(n=0;n<10240;n++)
		{
			uint16_t idx = genRIN()>>24;
			rand_buff[idx]++;
		}
		
		for(n=0;n<256;n++)
		{
			putcharUSART2((rand_buff[n]>>24)&0x000000FF);
			putcharUSART2((rand_buff[n]>>16)&0x000000FF);
			putcharUSART2((rand_buff[n]>>8)&0x000000FF);
			putcharUSART2((rand_buff[n])&0x000000FF);
		}
	}
}
