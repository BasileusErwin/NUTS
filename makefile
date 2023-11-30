.PHONY: qemu clean

kernel: boot.o linker.ld
	gcc -m32 -nostdlib -ffreestanding -static -T linker.ld -o kernel boot.o

boot.o: boot.nasm
	nasm -f elf32 boot.nasm -o boot.o

clean:
	rm -f kernel boot.o

qemu: kernel
	qemu-system-i386 -kernel kernel
