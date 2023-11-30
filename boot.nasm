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
; boot entry point
; this is where the bootloader will jump to
global bootMain
bootMain:
.bootCleanScreen:
  mov dx, 0x0720 ; white on black space
  mov cx, 2000 ; 80 * 25
  mov ebx, 0xb8000 ; video memory

.bootCleanChar:
  mov [ebx], dx ; write to video memory ; [ebx] is a pointer to the memory location
  dec cx
  add ebx, 2
  cmp cx, 0
  jne .bootCleanChar

.bootPrintOk:
  mov edx, 0x3e4b3e4f ; "OK"
  mov ebx, 0xb8000 ; video memory
  mov [ebx], edx ; write to video memory

bootDie:
  hlt ; halt the CPU
  jmp bootDie ; jump back to the beginning
