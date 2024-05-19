#pragma once
#include <stdint.h>

#define GPIO0_BASE 0x03020000
#define GPIO1_BASE 0x03021000
#define GPIO2_BASE 0x03022000
#define GPIO3_BASE 0x03023000
#define RTCSYS_GPIO_BASE 0x05021000


// gpio register offsets
#define GPIO_SWPORTA_DR 0x0
#define GPIO_SWPORTA_DDR 0x004
#define GPIO_INTEN 0x030
#define GPIO_INTTYPE_LEVEL 0x038
#define GPIO_INT_POLARITY 0x03c
#define GPIO_INTSTATUS 0x040
#define GPIO_RAW_INTSTATUS 0x044
#define GPIO_DEBOUNCE 0x048
#define GPIO_PORTA_EOI 0x04c
#define GPIO_EXT_PORTA 0x050
#define GPIO_LS_SYNC 0x060


volatile uint8_t * const GPIOA = (uint8_t *) GPIO0_BASE;
volatile uint8_t * const GPIOB = (uint8_t *) GPIO1_BASE;
volatile uint8_t * const GPIOC = (uint8_t *) GPIO2_BASE;
