#include "stm32f4xx.h"
#include "delay.h"
#include "usart.h"

int main(void)
{
	uint32_t cnt = 0, time;
	
	initUSART2(USART2_BAUDRATE_115200);
	printUSART2("\nwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\n");
	printUSART2("w Starting stopWATCH() test app...\n");
	printUSART2("\nwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\n");
	
	initSTOPWATCH();
	initSYSTIMER();
	
	while(1)
	{
		printUSART2("-> SW: test [%d]\n",cnt);
		cnt++;
		
		startSTOPWATCH();
		delay_ms(100);
		delay_ms(100);
		time = stopSTOPWATCH();
		printUSART2("     -> [100 ms] with delay_ms: [%d] us\n",time);
		
		time = getSYSTIMER();
		while(chk4TimeoutSYSTIMER(time, 100000) == (SYSTIMER_KEEP_ALIVE));
		time = getSYSTIMER() - time;
		printUSART2("     -> [100 ms] with systimer: [%d] us\n",time);
				
		delay_ms(1000);
	}
}

