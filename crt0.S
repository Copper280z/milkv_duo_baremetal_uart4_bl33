
; .section .text.unlikely
.section .text.magic
_magic:
    /* BL33 information */
    j _start
    .balign 4
    .word 0x33334c42  /* b'BL33' */
    .word 0xdeadbeea  /* CKSUM */
    .word 0xdeadbeeb  /* SIZE */
    .quad 0x80200000  /* RUNADDR */
    .word 0xdeadbeec
    j _start
    .balign 4

/* Information end */

.section .text.startup
.globl _start
_start:
    .cfi_startproc
    .cfi_undefined ra
    .option push
    .option norelax
    la gp, __global_pointer$
    .option pop
    la sp, __stack_top
    add s0, sp, zero
    jal zero, main
    .cfi_endproc
    .end




; // https://github.com/u-boot/u-boot/blob/3be9f399e911cfc437a37ac826441f1d96da1c9b/drivers/sysreset/sysreset_cv1800b.c#L38
; // https://twilco.github.io/riscv-from-scratch/2019/04/27/riscv-from-scratch-2.html
