#include "iwdg.h"

volatile uint8_t g_iwdg_flag = 0;

__inline uint8_t chk4StartupIWDG(void)
{
	uint8_t wdg_rst = 0;
	if(RCC->CSR&(RCC_CSR_WDGRSTF))										// check if this is start from WDT reset
	{
		wdg_rst = 1;
		RCC->CSR |= (RCC_CSR_RMVF);
	}
	return wdg_rst;
}

void initIWDG(uint16_t sec)
{// sec: [1-16]
	IWDG->KR = 0x5555;													// enable write to config reg's
	IWDG->PR = 0x0006;													// set prescaler to 256, LSI is 32kHz
	
	if(sec == 0)
		sec = 10;
	
	if(sec > 16)
		sec = 16;
		
	IWDG->RLR = 125*sec;												// set timeout in seconds
	
	IWDG->KR = 0xAAAA;													// reload counter value with value in RLR register
	IWDG->KR = 0xCCCC;													// start IWDG
}

__inline void feedIWDG(void)
{
	IWDG->KR = 0xAAAA;	 												// -> feed the dog added to IRQ
	g_iwdg_flag = 1;
}

void chkIWDG(void)
{
	if(g_iwdg_flag)
	{
		g_iwdg_flag = 0;
		printUSART2("-> IWDG: refreshed\n");
	}
}

