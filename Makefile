AS = i686-elf-as
COMP = i686-elf-gcc
EXEC = myos.bin
RM = rm

OBJECTS = boot.o kernel.o

.PHONY: all
all: $(EXEC)

boot.o: boot.s
	$(AS) @^ -o $@

kernel.o: kernel.c
	$(COMP) -c @^ -o $@ -std=gnu99 -ffreestanding -O2 -Wall -Wextra

myos.bin: linker.ld boot.o kernel.o
	$(COMP) -T linker.ld -o $@ -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

clean:
	- $(RM) $(EXEC)
	- $(RM) $(OBJECTS)
