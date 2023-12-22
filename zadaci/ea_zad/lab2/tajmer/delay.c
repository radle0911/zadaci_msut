#include "delay.h"

// delay funkcija za mislisekunde
void delay_ms(uint32_t ms)
{
    RCC->APB1ENR |= RCC_APB1ENR_TIM12EN; // fclk = 2x42 MHz = 84MHz
    TIM12->PSC = 83;                     // 0x0053;                // 84 MHz / (83 + 1) = 1MHz  = 1us
    TIM12->ARR = 1000;                   // 0x03E8;                // 1000(1001) puta = 1000 * 1us = 1ms
                       //  1000 + 1 / (1MHz) = 1.001ms
                       //  mozda je bolje staviti 0x03e7 onda
                       //  da bude bas tacno
    TIM12->CR1 = 0x0084;       // ARPE On, CMS disable, Up counting (moze i sa or
                               // operatorom al brze ovako)
    TIM12->EGR |= TIM_EGR_UG;  // Reset flag generisanje update eventa
    TIM12->CR1 |= TIM_CR1_CEN; // Start counting

    while (ms > 0)
    {
        // sa narednom petljom se zadrzavamo 1ms
        while ((TIM12->SR & TIM_SR_UIF) == 0x0000)
            ; // ova petlja je delay od 1ms

        --ms; // smanjujemo ms varijablu za 1

        TIM12->SR &= ~TIM_SR_UIF; // vracamo na 0
                                  // kako bi mogla opet uci u ovu petlju
                                  // i zadrzati se 1ms
    }
    // Prije nego sto izadjemo iz ove petlje potrebno je da zaustavimo brojanje
    // i da ugasimo TIM12 clock

    TIM12->CR1 &= ~TIM_CR1_CEN;
    RCC->APB1ENR &= ~RCC_APB1ENR_TIM12EN;
}

//delay funkcija za mikrosekudu
void delay_us(uint32_t us){
    RCC->APB1ENR |= RCC_APB1ENR_TIM12EN;
    TIM12->PSC = 0x0000;   // 16 bitni registar 
                            // ne mjenjamo nista ostavljamo 84MHz

    TIM12 -> ARR = 0X053;  // stavili smo 83 jer je formula : 
                            // ARR + 1 / freq = 84/84MHz = 1us

    TIM12 -> CR1 = 0x0084;                // ARPE On, CMS disable, Up counting
    TIM12 -> EGR = TIM_EGR_UG;            // Reset flag generisanje update eventa
    TIM12 -> CR1 |= TIM_CR1_CEN;           // Start counting

    //prethodno je sve objasnjeno ovdje je sve isto 
    while(us > 0) {
        while((TIM12 -> SR & TIM_SR_UIF) == 0x0000);
            --us;
            TIM12->SR &= ~TIM_SR_UIF;
    }
    TIM12->CR1 &= ~TIM_CR1_CEN;
    RCC -> AHB1ENR &= ~RCC_APB1ENR_TIM12EN;
}

























