#include "stm32f4xx.h"
#include "delay.h"
#include "usart.h"
#include "wwdg.h"



int main(void) 
{
	uint32_t update_timer, cnt = 0;
	
	uint8_t wdt_rst = chk4StartupWWDG();
	
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// init system peripherals
	///-----------------------------------------------------------------	
	initUSART2(USART2_BAUDRATE_921600);
	initSYSTIM();
	delay_ms(500);
	
	initWWDG();
	initPBTN();
	
	update_timer = getSYSTIM();
	if(wdt_rst)
	{
		printUSART2("\n-> SYS: WDT reset\n");
	}
	else
	{
		printUSART2("\n-> SYS: POR reset\n");
	}
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	
	while(1)
	{	
		if(chk4TimeoutSYSTIM(update_timer, 1000) == (SYSTIM_TIMEOUT))
		{
			update_timer = getSYSTIM();
			cnt++;
			printUSART2("-> SYS: CNT[%x]\n",cnt);
		}
		
		chkPBTN();
		chkWWDG();
	}
}



