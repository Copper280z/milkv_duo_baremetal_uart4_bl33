/* Script for -z combreloc */
/* Copyright (C) 2014-2020 Free Software Foundation, Inc.
   Copying and distribution of this script, with or without modification,
   are permitted in any medium without royalty provided the copyright
   notice and this notice are preserved.  */
OUTPUT_FORMAT("elf64-littleriscv", "elf64-littleriscv",
	      "elf64-littleriscv")
OUTPUT_ARCH(riscv)
/* MEMORY */
/* { */
/*     RAM (rwx)  : ORIGIN = 0x80000000, LENGTH = 64M */
/* } */
ENTRY(_start)
SECTIONS
{
  . = 0x80200000;
  .text          :
  {
    *(.text.magic)
    *(.text.startup)
    *(.text .stub .text.* .gnu.linkonce.t.*)
  }
  .note.gnu.build-id  : { *(.note.gnu.build-id) }
  .rodata : { *(.rodata) }
  /* . = 0x8000000; */
  .data : { *(.data) }
  .sdata : { *(.sdata) }
  .debug : { *(.debug) }
  . += 1000;
  /* PROVIDE(__stack_top = ORIGIN(RAM) + LENGTH(RAM)); */
  __global_pointer$ = .;
  . +=100;
  __stack_top = .;
  _end = .;
}

