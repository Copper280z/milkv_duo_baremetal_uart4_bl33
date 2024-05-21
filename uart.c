#include "uart.h"

void blocking_send(UART_Typedef *uart, uint8_t msg_byte) {

    // wait for tx to be idle
    while ((uart->lsr & (1<<5)) == 0) {};

    // send the byte
    uart->rbr_thr_dll = msg_byte;
}

void blocking_send_arr(UART_Typedef *uart, uint8_t *msg_byte, uint32_t num_bytes) {

    for (int i=0;i<num_bytes;i++) {
        blocking_send(uart, msg_byte[i]);
    }
}
