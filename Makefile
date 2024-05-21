
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


# CFLAGS		:= -g -ggdb -Wall -O0 -mcmodel=medany -mabi=lp64d -march=rv64imfd -nostdlib -nostartfiles -lm

# add linker flags with -Wl,blahblah
# --verbose outputs the linker script ld uses
#
# $(CC) -nostdlib -fno-builtin -march=rv64gc -mabi=lp64f -g -Wall -Ttext=0x80200000 -o $(NAME).elf $(SRC) -Wl,--verbose

SRCex		:= uart4_bl33.S
# SRC		:= uart4_bl33.S
SRC		:= main.c crt0.S uart.c


.PHONY: all clean
all: $(NAME)

$(NAME): $(SRC)
	$(CC) -nostdlib -ffreestanding -nostartfiles -nodefaultlibs -march=rv64gc \
		-mabi=lp64f -g -Wall\
		-o $(NAME).elf $(SRC) -Wl,--verbose,-T,simple.ld
	# $(CC) -nostdlib -fno-builtin -march=rv64gc -mabi=lp64f -g -Wall -Ttext=0x80200000 -o $(NAME).elf $(SRC) -Wl,--verbose
	$(OC) --keep-section=.bl33magic -O binary $(NAME).elf $(NAME).bin
	$(OD) -s -d $(NAME).elf > $(NAME).txt
	cp $(NAME).bin gen_fip/
	cd gen_fip && ./run.sh cd -

ex:$(SRCex)
	$(CC) -nostdlib -fno-builtin -march=rv64gc -mabi=lp64f -g -Wall -Ttext=0x80200000 -o example.elf $(SRCex) -Wl,--verbose
	$(OC) -O binary example.elf example.bin
	$(OD) -s -d example.elf > example.txt
	# cp $(NAME).bin gen_fip/
	# cd gen_fip && ./run.sh cd -

clean:
	rm $(NAME).elf $(NAME).txt $(NAME).bin
