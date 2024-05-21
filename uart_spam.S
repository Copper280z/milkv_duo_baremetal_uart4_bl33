#include "cv180xb_chip.h"

.section .text
.global start_spam
start_spam:
	la	s0, banner_0
0:
	lbu	a0, (s0)
	beqz	a0, exit_banner_0
	jal	ra, uart0_send
	addi	s0, s0, 1
	j	0b

exit_banner_0:
	la	s0, banner_1
1:
	lbu	a0, (s0)
	beqz	a0, exit_banner_1
	jal	ra, uart0_send
	addi	s0, s0, 1
	j	1b

exit_banner_1:

	//uart4
	jal	ra, uart4_init

	la	s0, uart4_banner_0
2:
	lbu	a0, (s0)
	beqz	a0, exit_uart4_banner_0
	jal	ra, uart4_send
	addi	s0, s0, 1
	j	2b

exit_uart4_banner_0:
	la	s0, uart4_banner_1
3:
	lbu	a0, (s0)
	beqz	a0, exit_uart4_banner_1
	jal	ra, uart4_send
	addi	s0, s0, 1
	j	3b

exit_uart4_banner_1:
	j	start_spam

loop:
	wfi
	la s0, banner_2
2:
	lbu a0, (s0)
	beqz a0, exit_2
	jal ra, uart0_send
	addi s0, s0, 1
	j 2b
exit_2:
	j loop

uart4_init:
	//SD1_GPIO0 -> UART4_RX, func1
	li	t0, PINMUX_SD1_GPIO0
	lw	t1, (t0)
	andi	t1, t1, ~FMUX_GPIO_FUNCSEL_SD1_GPIO0_MASK  
	ori	t1, t1, SD1_GPIO0__UART4_RX
	sw	t1, (t0) 

	//SD1_GPIO1 -> UART4_TX, func1
	li	t0, PINMUX_SD1_GPIO1
	lw	t1, (t0)
	andi	t1, t1, ~FMUX_GPIO_FUNCSEL_SD1_GPIO1_MASK  
	ori	t1, t1, SD1_GPIO1__UART4_TX
	sw	t1, (t0) 


	//Write "1" to LCR[7](DLAB) bit
	li	t0, UART4_LCR
	li	t1, DLAB
	sw	t1, (t0)

	//Set divisor
	//divisor = 14 for 115200
	//Lower 8 bits
	li	t1, (14 & 0xFF)
	li	t0, UART4_THR
	sw	t1, (t0)
	
	//Upper 8 bits
	li	t1, (14 >> 8) & 0xFF
	li	t0, UART4_DLH
	sw	t1, (t0)

	//LCR 8n1
	//Set "0" to DLAB
	li	t1, (DLS_8BITS | (STOP_1BIT << STOP_BIT_SHIFT)) & ~PARITY_ENABLE_MASK
	li	t0, UART4_LCR
	sw	t1, (t0)

	ret
	

uart0_send:
	/* Wait for tx idle */
	li t0, UART0_LSR
	lw t1, (t0)
	andi t1, t1, 0x20
	beqz t1, uart0_send
	/* Send a char */
	li t0, UART0_THR
	sw a0, (t0)
	ret

uart4_send:
	/* Wait for tx idle */
	li t0, UART4_LSR
	lw t1, (t0)
	andi t1, t1, 0x20
	beqz t1, uart4_send
	/* Send a char */
	li t0, UART4_THR
	sw a0, (t0)
	ret

.section .rodata
banner_0: 
	.asciz "UART0: =======Milkv-duo=======\r\n"
	.word 0x0
banner_1: 
	.asciz "UART0: Hello Milkv-duo, from C!\r\n"
	.word 0x0
banner_2:
	.asciz "UART0: Error looping!\r\n"
	.word 0x0
uart4_banner_0: 
	.asciz "UART4: =======Milkv-duo=======\r\n"
	.word 0x0
uart4_banner_1: 
	.asciz "UART4: Hello Milkv-duo!, from C!\r\n"
	.word 0x0
