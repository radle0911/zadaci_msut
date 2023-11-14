#include "stm32f4xx.h"
#include "delay.h"
#include "usart.h"
#include "rtc.h"

int main(void) 
{
	uint32_t update_timer, cnt = 0;
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww
	/// init system peripherals
	///-----------------------------------------------------------------	
	initUSART2(USART2_BAUDRATE_921600);
	initSYSTIM();
	initRTC();
	setupAlarmARTC();
	
	update_timer = getSYSTIM();
	printUSART2("-> SYS: init completed\n");
	///wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww 	
	
	
	while(1)
	{	
		if(chkAlarmRTC())
		{
			cnt++;
			uint32_t subs = RTC->SSR;
			uint32_t time = RTC->TR;
			uint32_t date = RTC->DR;
			printUSART2("-> RTC: CNT[%x] DR[0x%x] TR[0x%x] SSR[0x%x]\n",cnt, date, time, subs);
		}	
	}
}

