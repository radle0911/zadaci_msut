#include"stm32f4xx.h"
#include"delay.h"


int main(){
    // prvo sto radimo je govorimo sta koristimo
    // INICIJALIZACIJA : 
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;
    GPIOD->MODER |= 0x55000000;
    GPIOD->OTYPER |= 0x00000000;
    GPIOD->OSPEEDR |= 0xFF000000;
    //INICIJALIZACIJA ZAVRSENA !!!!!!!!!!!!!!   

void del(uint32_t ms);

    uint8_t k = 0;
    uint16_t stanja[8] = {0xF000,0xE000,0xC000,0x8000,0x0000,0x1000,0x3000,0x7000};

    while(1){

        GPIOD->ODR = stanja[k];
        delay_ms(500);
        //delay_us(500000);
        //del(500); // funkcija otprilike da izazivamo delay

        ++k;

        if(k==8)
        k =0;
    }

}

// ovo je otprilike funkcija da izazivamo deley
void del(uint32_t ms){
    volatile uint32_t us = ms*10500;
    while(us)
    --us;
}