#include <stdint.h>
#include "cv180xb_chip.h"
#include "uart.h"

// extern void start_spam();

UART_Typedef *UART0 = (UART_Typedef*) UART0_BASE_ADDR;

int main() {
    // start_spam();
    char *msg = "Woo UART driver in C!!!\r\n";
    while(1){
        blocking_send_arr(UART0, (uint8_t*)msg, 26);       
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
