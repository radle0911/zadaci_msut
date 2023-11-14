#include "stm32f4xx.h"
#include "usart.h"

void delay_soft_ms(uint32_t cnt);

int main(void)
{
	uint32_t utmp32 = 0;	
	initUSART2(USART2_BAUDRATE_115200);
	
	while(1)
	{
		printUSART2("-> SYS: dec [%d]\n",utmp32);
		printUSART2("-> SYS: hex [0x%x]\n",utmp32);
		printUSART2("-> SYS: bin [%b]\n",utmp32);
		printUSART2("[uint32_t] hex: \e[34m%x\e[39m \tbin: \e[33m%b\e[39m \tdec: \e[35m%d\e[39m\n\n",utmp32,utmp32,utmp32);
		
		delay_soft_ms(1000);
		utmp32++;
	}
}

void delay_soft_ms(uint32_t cnt)
{/// primitivna rutina za kasnjenje 									
	volatile uint32_t time = cnt*10500;											
																		// izbjegavati softverski definirane rutine																// za kasnjenje
	while(time)
	{
		time--;
	}														
	
	return;
}

