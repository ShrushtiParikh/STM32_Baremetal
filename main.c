

void delay(int n)
{
    for(int i = 0 ; i < n ; i++)
    {
        for(int j = 0 ; j < 1000 ; j++)
        {
            _asm__("nop"); //assembly instruction for waiting
        }
    }
}

int main(void)
{
    //enable gpioc clock
    RCC->APB2ENR |= RCC_APB2ENR_IOPCEN;

    //configure pin PC13 as output
    GPIOC->CRH &= ~(GPIO_CRH_MODE13 | GPIO_CRH_CNF13); //clear bits
    GPIOC->CRH |= GPIO_CRH_MODE13_0; //outputmode , max speed 10 MHZ

    while(1)
    {
        //toggle PC13
        GPIOC->ODR ^= GPIO_ODR_ODR13;
        delay(1000);
    }
}