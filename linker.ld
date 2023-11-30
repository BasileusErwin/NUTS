OUTPUT_ARCH(i386);
OUTPUT_FORMAT(elf32-i386);

ENTRY(bootMain)

SECTIONS {
  . = 0x100000;
  .boot : { *(.boot) }
  .text : { *(.text) }
}
