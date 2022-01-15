CC=aarch64-linux-gnu-gcc
AS=aarch64-linux-gnu-as
LD=aarch64-linux-gnu-ld
OBJCPY=aarch64-linux-gnu-objcopy
MKIMG=mkimage
ARCH=arm64

all:	startup.uimg

startup.uimg: startup.bin
	$(MKIMG) -A $(ARCH) -C none -O linux -T kernel -d startup.bin -a 0x84000000 -e 0x84000000 $@

startup.bin: startup
	$(OBJCPY) -O binary $< $@

startup: startup.o
	$(LD) -T startup.ld $< -o $@

startup.o: startup.s
	$(AS) -g -o $@ $<


clean:
	rm -rf *.o *.uimg *.bin startup
