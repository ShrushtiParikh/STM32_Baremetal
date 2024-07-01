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
