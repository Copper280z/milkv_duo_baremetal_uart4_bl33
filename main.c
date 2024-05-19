#include "gpio.h"

extern void start_spam();

int main() {
    start_spam();
    while(1){
        volatile int a;
        a+=1;
    };
    // *(GPIOC+GPIO_SWPORTA_DDR) |= 1<<24;
    // int a = 4;
    // while (1) {
    //     a += 1;
    //     if (a%100 == 0){
    //         *GPIOC = ~(*GPIOC);
    //     }
    // }
    return 0;
}
