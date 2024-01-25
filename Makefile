
CROSS_COMPILE = riscv64-unknown-elf-

NAME            := uart4_bl33

INCLUDEDIRS     += ./
SOURCECODEDIRS  += ./

AS		:= $(CROSS_COMPILE)as
CC		:= $(CROSS_COMPILE)gcc
CXX		:= $(CROSS_COMPILE)g++
LD		:= $(CROSS_COMPILE)ld
AR		:= $(CROSS_COMPILE)ar
OC              := $(CROSS_COMPILE)objcopy
OD		:= $(CROSS_COMPILE)objdump


#CFLAGS		:= -g -ggdb -Wall -O0 -mcmodel=medany -mabi=lp64d -march=rv64imfd -nostdlib -nostartfiles -lm

SRC		:= uart4_bl33.S


.PHONY: all clean
all: $(NAME)

$(NAME): $(SRC)
	$(CC) -nostdlib -fno-builtin -march=rv64gc -mabi=lp64f -g -Wall -Ttext=0x80200000 -o $(NAME).elf $(SRC)
	$(OC) -O binary $(NAME).elf $(NAME).bin
	$(OD) -s -d $(NAME).elf > $(NAME).txt
	cp $(NAME).bin gen_fip/
	cd gen_fip && ./run.sh cd -

clean:
	rm $(NAME).elf $(NAME).txt $(NAME).bin
