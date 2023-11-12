#include"stm32f4xx.h"

void delay_ms(uint32_t);

int main(){
    // INICIJALIZACIJA LED DIODA
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;
    GPIOD->MODER |= 0x55000000;
    GPIOD->OTYPER |= 0x00000000;
    GPIOD->OSPEEDR |= 0xff000000;

    uint16_t stanja[8] = {0x1000, 0x3000, 0x7000, 0xf000,0xe000,0xc000,0x8000,0x0000};
    uint8_t tmp = 0;

    while(1){
        GPIOD->ODR &= ~0xf000;
        //delay_ms(500);
       // zasto je ovo gore potrebno sta ono radi ??? 
        GPIOD->ODR |= stanja[tmp];
        delay_ms(500);
        ++tmp;
        if(tmp == 8)
        tmp = 0;
    }
}


void delay_ms(uint32_t ms){
    volatile uint32_t us = ms*10500;
    while(us){
        --us;
    }
}