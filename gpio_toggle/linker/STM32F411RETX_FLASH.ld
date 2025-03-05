/* Based on https://github.com/ARM-software/CMSIS_5/blob/5.9.0/Device/ARM/ARMCM4/Source/GCC/gcc_arm.ld */

/*---------------------- Flash Configuration ----------------------------------
  <h> Flash Configuration
    <o0> Flash Base Address <0x0-0xFFFFFFFF:8>
    <o1> Flash Size (in Bytes) <0x0-0xFFFFFFFF:8>
  </h>
  -----------------------------------------------------------------------------*/
__ROM_BASE = 0x08000000;
__ROM_SIZE = 512K;

/*--------------------- Embedded RAM Configuration ----------------------------
  <h> RAM Configuration
    <o0> RAM Base Address    <0x0-0xFFFFFFFF:8>
    <o1> RAM Size (in Bytes) <0x0-0xFFFFFFFF:8>
  </h>
 -----------------------------------------------------------------------------*/
__RAM_BASE = 0x20000000;
__RAM_SIZE = 128K;

/*--------------------- Stack / Heap Configuration ----------------------------
  <h> Stack / Heap Configuration
    <o0> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
    <o1> Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
  </h>
  -----------------------------------------------------------------------------*/
__STACK_SIZE = 0x00000400;
__HEAP_SIZE  = 0x00000000;

MEMORY
{
    FLASH (rx)  : ORIGIN = __ROM_BASE, LENGTH = __ROM_SIZE
    RAM   (rwx) : ORIGIN = __RAM_BASE, LENGTH = __RAM_SIZE
}

/* Linker script to place sections and symbol values. Should be used together
 * with other linker script that defines memory regions FLASH and RAM.
 * It references following symbols, which must be defined in code:
 *   Reset_Handler : Entry of reset handler
 *
 * It defines following symbols, which code can use without definition:
 *   __exidx_start
 *   __exidx_end
 *   __copy_table_start__
 *   __copy_table_end__
 *   __zero_table_start__
 *   __zero_table_end__
 *   __etext
 *   __data_start__
 *   __preinit_array_start
 *   __preinit_array_end
 *   __init_array_start
 *   __init_array_end
 *   __fini_array_start
 *   __fini_array_end
 *   __data_end__
 *   __bss_start__
 *   __bss_end__
 *   __end__
 *   end
 *   __HeapLimit
 *   __StackLimit
 *   __StackTop
 *   __stack
 */
ENTRY(Reset_Handler)

SECTIONS
{
    .text :
    {
        KEEP(*(.isr_vector))
        *(.text*)

        KEEP(*(.init))
        KEEP(*(.fini))

        /* .ctors */
        *crtbegin.o(.ctors)
        *crtbegin?.o(.ctors)
        *(EXCLUDE_FILE(*crtend?.o *crtend.o) .ctors)
        *(SORT(.ctors.*))
        *(.ctors)

        /* .dtors */
        *crtbegin.o(.dtors)
        *crtbegin?.o(.dtors)
        *(EXCLUDE_FILE(*crtend?.o *crtend.o) .dtors)
        *(SORT(.dtors.*))
        *(.dtors)

        *(.rodata*)

        KEEP(*(.eh_frame*))
    } > FLASH

    .ARM.extab :
    {
        *(.ARM.extab* .gnu.linkonce.armextab.*)
    } > FLASH

    __exidx_start = .;
    .ARM.exidx :
    {
        *(.ARM.exidx* .gnu.linkonce.armexidx.*)
    } > FLASH
    __exidx_end = .;

    .copy.table :
    {
        . = ALIGN(4);
        __copy_table_start__ = .;

        LONG(__etext)
        LONG(__data_start__)
        LONG((__data_end__ - __data_start__) / 4)

        __copy_table_end__ = .;
    } > FLASH

    .zero.table :
    {
        . = ALIGN(4);
        __zero_table_start__ = .;
        __zero_table_end__ = .;
    } > FLASH

    /**
     * Location counter can end up 2byte aligned with narrow Thumb code but
     * __etext is assumed by startup code to be the LMA of a section in RAM
     * which must be 4byte aligned
     */
    __etext = ALIGN(4);

    .data : AT (__etext)
    {
        __data_start__ = .;
        *(vtable)
        *(.data)
        *(.data.*)

        . = ALIGN(4);
        /* preinit data */
        PROVIDE_HIDDEN (__preinit_array_start = .);
        KEEP(*(.preinit_array))
        PROVIDE_HIDDEN (__preinit_array_end = .);

        . = ALIGN(4);
        /* init data */
        PROVIDE_HIDDEN (__init_array_start = .);
        KEEP(*(SORT(.init_array.*)))
        KEEP(*(.init_array))
        PROVIDE_HIDDEN (__init_array_end = .);

        . = ALIGN(4);
        /* finit data */
        PROVIDE_HIDDEN (__fini_array_start = .);
        KEEP(*(SORT(.fini_array.*)))
        KEEP(*(.fini_array))
        PROVIDE_HIDDEN (__fini_array_end = .);

        KEEP(*(.jcr*))
        . = ALIGN(4);
        /* All data end */
        __data_end__ = .;
    } > RAM

    .bss (NOLOAD) :
    {
        . = ALIGN(4);
        __bss_start__ = .;
        *(.bss)
        *(.bss.*)
        *(COMMON)
        . = ALIGN(4);
        __bss_end__ = .;
    } > RAM AT > RAM

    .heap (INFO) :
    {
        . = ALIGN(8);
        __end__ = .;
        PROVIDE(end = .);
        . = . + __HEAP_SIZE;
        . = ALIGN(8);
        __HeapLimit = .;
    } > RAM

    .stack (ORIGIN(RAM) + LENGTH(RAM) - __STACK_SIZE) (INFO) :
    {
        . = ALIGN(8);
        __StackLimit = .;
        . = . + __STACK_SIZE;
        . = ALIGN(8);
        __StackTop = .;
    } > RAM
    PROVIDE(__stack = __StackTop);

    ASSERT(__StackLimit >= __HeapLimit, "data + heap + stack sections exceed RAM limit")

    /* Additional symbols for current startup script */
    PROVIDE(_sdata = __data_start__);
    PROVIDE(_edata = __data_end__);
    PROVIDE(_sidata = LOADADDR(.data));
    PROVIDE(_sbss = __bss_start__);
    PROVIDE(_ebss = __bss_end__);
    PROVIDE(_estack = __StackTop);

    /* Remove information from the compiler libraries */
    /DISCARD/ :
    {
        libc.a ( * )
        libm.a ( * )
        libgcc.a ( * )
    }

    .ARM.attributes 0 : { *(.ARM.attributes) }
}