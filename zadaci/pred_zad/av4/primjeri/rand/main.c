#include "stm32f4xx.h"
#include "usart.h"
#include "delay.h"
#include "arm_math.h"
#include "rand.h"

int main(void)
{
	uint32_t utmp32, k = 0;
	uint32_t cnt0 = 0;
	uint32_t cnt1 = 0;
	uint32_t N = 0;
	//float r;
	
	initUSART2(USART2_BAUDRATE_115200);
	printUSART2("\nwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\n");
	printUSART2("w Starting RNG test app... ");
	printUSART2("\nwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww\n");
	initSYSTIM();
	
	uint32_t update_timer = getSYSTIM();
	while(1)
	{
		utmp32 = genRIN();
		if(utmp32 > 0x7FFFFFFF)
			cnt1++;
		else
			cnt0++;
		N++;
		
		if(chk4TimeoutSYSTIM(update_timer, 200) == (SYSTIM_TIMEOUT))
		{	
			update_timer = getSYSTIM();
			k++;
			//printUSART2("[%d] RIN: [%x] --- 0|1 [%f|%f] COUNT[%d]\n", k, utmp32, ((float)cnt0)/N, ((float)cnt1)/N, N);
			printUSART2("[%d] RIN: [%x] --- 0|1 [%d|%d] COUNT[%d]\n", k, utmp32, cnt0, cnt1, N);
		}
			
		//r = genURFN();
		//printUSART2("URFN: %f\n", r);
		//r = genGRFN(1,2);
		//printUSART2("GRFN: %f\n", r);
	}
}
