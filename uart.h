#pragma once

#include <stdint.h>

typedef volatile struct __attribute__((packed)) {
    uint32_t rbr_thr_dll;    	// Receive Buffer,Transmit Holding or Divisor Latch Low byte Register
    uint32_t ier_dlh;        	// Interrupt Enable or Divisor Latch high byte Register
    uint32_t fcr_iir;        	// FIFO Control or Interrupt Identification Register
    uint32_t lcr;               // Line Control Register
    uint32_t mcr;               // Modem Control Register
    uint32_t lsr;               // Line Status Register
    uint32_t msr;               // Modem Status Register
    uint32_t lpdll;          	// Low Power Divisor Latch (Low) Register
    uint32_t lpdlh;          	// Low Power Divisor Latch (High) Register
    uint32_t srbr_sthr;      	// Shadow Receive/Trasnmit Buffer Register
    uint32_t far;               // FIFO Access Register
    uint32_t tfr;               // Transmit FIFO Read
    uint32_t rfw;               // Receive FIFO Write
    uint32_t usr;               // UART Status Register
    uint32_t tfl;               // Transmit FIFO Level
    uint32_t rfl;               // Receive FIFO Level
    uint32_t srr;               // Software Reset Register
    uint32_t srts;              // Shadow Request to Send
    uint32_t sbcr;              // Shadow Break Control Register
    uint32_t sdmam;             // Shadow DMA Mode
    uint32_t sfe;            	// Shadow FIFO Enable
    uint32_t srt;            	// Shadow RCVR Trigger
    uint32_t stet;           	// Shadow TX Empty Trigger
    uint32_t htx;               // Halt TX
    uint32_t dmasa;             // DMA Software Acknowledge			
} UART_Typedef;              	
                                			          
void blocking_send(UART_Typedef *uart, uint8_t msg_byte);
void blocking_send_arr(UART_Typedef *uart, uint8_t *msg_byte, uint32_t num_bytes);
