/*Entry Point*/
ENTRY(Reset_Handler)

/*Highst address of user mode stack*/
_estack = ORIGIN(RAM) + LENGTH(RAM)  /*end of RAM type memory

_Min_Heap_Size = 0x200     //required amount of _Min_Heap_Size
_Min_Stack_Size  = 0x400  //reuqired amount of _Min_Heap_Size

/*Memory definition*/
MEMORY{
    RAM(xrw)    : ORIGIN = 0X20000000, LENGTH = 20K
    FLASH(rx)   : ORIGIN = 0x8000000,  LENGTH = 64K
}

/*Sections*/
Sections
{
    /* The startup code into "FLASH" Rom type memory*/
    .isr_vector :
    {
        . = ALIGN(4);
        KEEP(*(.isr_vector)) /*startup code*/
        . = ALIGN(4);
    } >FLASH

    /* The program code and other data into "FLASH" rom type memory*/
    .text :
    {
        . = ALIGN(4);
        *(.text)        /* .text sections(code) */
        *(.text*)       /* text* sections(code) */
        *(.glue_7)      /* glue arm to thumbs code */
        *(.glue_7t)     /* glue thumb to arm code */
        *(.eh_frame)

        KEEP (*(.init))
        KEEP (*(.fini))

        . = ALUGN(4);
        _etext =.;      /* define a global symbols at end of code */
    }>FLASH

    /*constant data into "FLASH" rom type memory*/
    .rodata :
    {
        . = ALIGN(4);
        *(.rodata)          /* .rodata sections */
        *(.rodata*)         /* .rodata sections */
        . = ALIGN(4)
    }>FLASH

    /* init data sections into "RAM" ram type memory*/
    .data :
    {
        . = ALIGN(4);
        _sdata = .;                 /*global symbol at data start*/
        *(.data)                    /* data sections */
        *(.data*)                   /* data* sections */

        . = ALIGN(4);
        _edata = .;            /* define global symbol at dataa end */
    }>RAM AR> FLASH

    /*uinint data sections into "RAM" ram type memory */
    . = ALIGN(4);
    .bss :
    {
        /* this is used by the startup in order to init the .bss section */
        _sbss = .;     /*define a global symbol at bss start */
        __bss_start__ = _sbss;
        *(.bss)
        *(.bss*)
        *(COMMON)
         . = ALIGN(4);
    _ebss = .;         /* define a global symbol at bss end */
    __bss_end__ = _ebss;
    } >RAM

  /* User_heap_stack section, used to check that there is enough "RAM" Ram  type memory left */
  ._user_heap_stack :
  {
    . = ALIGN(8);
    PROVIDE ( end = . );
    PROVIDE ( _end = . );
    . = . + _Min_Heap_Size;
    . = . + _Min_Stack_Size;
    . = ALIGN(8);
  } >RAM
  
}
