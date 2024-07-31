#include <stdint.h>

#define RCC_BASE    0x40021000
#define GPIOC_BASE  0x40011000

#define RCC_APB2ENR   *(volatile uint32_t *)(RCC_BASE   + 0x18)
#define GPIOC_CRH     *(volatile uint32_t *)(GPIOC_BASE + 0x04)
#define GPIOC_ODR     *(volatile uint32_t *)(GPIOC_BASE + 0x0C)
// bit fields
#define RCC_IOPCEN   (1<<4)
#define GPIOC13      (1UL<<13)

void delay(int n)
{
    for(int i = 0 ; i < n ; i++)
    {
        for(int j = 0 ; j < 1000 ; j++)
        {
            asm("nop"); //assembly instruction for waiting
        }
    }
}

int main(void)
{
    //enable gpioc clock
    RCC_APB2ENR |= RCC_IOPCEN;
    GPIOC_CRH   &= 0xFF0FFFFF;
    GPIOC_CRH   |= 0x00200000;
    //configure pin PC13 as output
    
    while(1)
    {
        //toggle PC13
        GPIOC_ODR |=  GPIOC13;
        for (int i = 0; i < 500000; i++); // arbitrary delay
        GPIOC_ODR &= ~GPIOC13;
        for (int i = 0; i < 500000; i++); // arbitrary delay
    }
}