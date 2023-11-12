#include <stdio.h>
#include <stdint.h>
#include "fnc.h"

int main(void)
{
	uint16_t utmp16 = 402;
	
	printf("Mikroprocesorski sistemi u telekomunikacijama: [TK%d]\n",utmp16); 
	
	testFNC();
	
	return 0;
}
