#include"stm32f4xx.h"

int main(){
    //WWWWWWWWWWWWWWWWWWWWWW INICIJALIZACIJA LED DIODA WWWWWWWWWWWWWWWWWWWWWWWWWWWW
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIODEN;
    // Posto su led diode definisane na pinovima 
    // PD12,PD13,PD14,PD15 MODER 
    // definisemo na sljedeci nacin:
    GPIOD->MODER |= 0x55000000;
    // Postavili smo sve led diode kao izlaz
    GPIOD->OTYPER |= 0x00000000;
    // OTYPER je PUSH-PULL [0] 
    GPIOD->OSPEEDR |= 0xff000000;
    // Brzinu prelaza iz high u low i obrnuto
    // postavili smo na 100 MHz koristeci se 
    //  OSPEEDR 

// Sada postavljamo kada se stisne dugme USER

    // USER button se nalazi na portu PA0
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;
    GPIOA->MODER |= 0x00000000;
    GPIOA->OTYPER |= 0x00000000;
    GPIOA->OSPEEDR |= 0xff000000;
    GPIOA->PUPDR |= 0x00000002;
    //Postavljamo pull-up/pull-down register PA0 na
    // 10 - pull-down zato sto zelimo da reaguje 
    //kad dugme se stisne 
    // ma da kako smo napisali kod ovo nije ni potrebno cak.. 

    //WWWWWWWWWWWWWWWWW INICIJALIZACIJA JE ZAVRSENA WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW

    // Ispod pisemo kod 
    while(1){
        if((GPIOA->IDR & 0x0001)== 0x0001)
        GPIOD->ODR |= 0xf000;
        else
        GPIOD->ODR &= ~0xf000;
    }

}




