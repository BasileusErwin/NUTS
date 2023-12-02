; multiboot header
; doc at https://www.gnu.org/software/grub/manual/multiboot/multiboot.html
section .boot
align 4

; magic number for multiboot
multibootMagic equ 0x1BADB002
; flags
multibootFlags equ 0
; checksum
multibootChecksum equ -(multibootMagic + multibootFlags)

multibootHeader:
  dd multibootMagic
  dd multibootFlags
  dd multibootChecksum

section .text

extern main
; boot entry point
; this is where the bootloader will jump to
global bootMain
bootMain:
  mov esp, stackTop ; set the stack pointer
  mov ebp, esp ; set the base pointer
  call main

bootDie:
  hlt ; halt the CPU
  jmp bootDie ; jump back to the beginning

; stack section for the kernel
section .bss

stackBottom:
  resb 8192; 8KB of stack
stackTop:
