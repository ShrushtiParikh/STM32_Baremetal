/* Entry Point */
ENTRY(Reset_Handler)

/* Highest address of the user mode stack */
_estack = ORIGIN(RAM) + LENGTH(RAM);  /* End of RAM */

/* Minimum Heap and Stack sizes */
_Min_Heap_Size = 0x200;   /* Required amount of heap */
_Min_Stack_Size = 0x400;  /* Required amount of stack */

/* Memory Definitions */
MEMORY
{
    RAM (xrw)    : ORIGIN = 0x20000000, LENGTH = 20K
    FLASH (rx)   : ORIGIN = 0x08000000, LENGTH = 64K
}

/* Section Definitions */
SECTIONS
{
    /* The startup code goes first into FLASH */
    .isr_vector :
    {
        . = ALIGN(4);
        KEEP(*(.isr_vector)) /* Interrupt vectors */
        . = ALIGN(4);
    } >FLASH

    /* The program code and other data goes into FLASH */
    .text :
    {
        . = ALIGN(4);
        *(.text)           /* .text sections (code) */
        *(.text*)          /* .text* sections (code) */
        *(.rodata)         /* .rodata sections (constants, strings, etc.) */
        *(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
        . = ALIGN(4);
    } >FLASH

    /* Constant data goes into FLASH */
    .rodata :
    {
        . = ALIGN(4);
        *(.rodata)         /* .rodata sections (constants, strings, etc.) */
        *(.rodata*)        /* .rodata* sections (constants, strings, etc.) */
        . = ALIGN(4);
    } >FLASH

    /* .data section which is used for initialized data */
    .data : AT (ADDR(.text) + SIZEOF(.text))
    {
        . = ALIGN(4);
        _sdata = .;        /* Start of .data section */
        *(.data)           /* .data sections */
        *(.data*)          /* .data* sections */
        . = ALIGN(4);
        _edata = .;        /* End of .data section */
    } >RAM

    /* .bss section which is used for uninitialized data */
    .bss :
    {
        . = ALIGN(4);
        _sbss = .;         /* Start of .bss section */
        *(.bss)            /* .bss sections */
        *(.bss*)           /* .bss* sections */
        *(COMMON)          /* COMMON sections */
        . = ALIGN(4);
        _ebss = .;         /* End of .bss section */
    } >RAM

    /* User heap section */
    ._user_heap_stack :
    {
        . = ALIGN(4);
        PROVIDE ( end = . );
        PROVIDE ( _end = . );
        . = . + _Min_Heap_Size;
        . = . + _Min_Stack_Size;
        . = ALIGN(4);
    } >RAM

    /* Stacks */
    _estack = ORIGIN(RAM) + LENGTH(RAM);
    _sidata = LOADADDR(.data);
}
