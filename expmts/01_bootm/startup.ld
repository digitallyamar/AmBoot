ENTRY(_start)
SECTIONS
{
	. = 0x0;
	.startup . : { startup.o(.text) }
}	
