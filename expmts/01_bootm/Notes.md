# U-Boot standalone elf file boot

It is possible to run an ELF executable file using U-Boot. However, it involves a process to be followed.
Below are these steps:

1. Create an ELF executable using linker script to specify section addresses.
2. Convert this ELF file to binary so that it can be loaded using U-Boot. U-Boot does not interpret ELF headers so this is a required step. Use Objcopy to accomplish this. 
   1. Eg: 
   
      ```
      aarch64-linux-gnu-objcopy -O binary startup startup.bin 
      ```
      (Here startup is the input ELF file)
   
   2. This causes a lot of info from the ELF file to be stripped off and only bare text/data segments will remain in the final bin file.
3. Use mkimage tool to convert bin file to uimg file. uimg file is a U-Boot specific file that contains 64 bytes of header info pertaining to the binary file - containing load address, entry point address, OS type and many such info. This info will be used by a special command in U-Boot called bootm to figure out where to uncompress/load the binary file and where to find the entry point to your binary.
   1. Eg:
    
        ```
        mkimage -A arm64 -C none -O linux -T kernel -d startup.bin -a 0x84000000 -e 0x84000000 startup.uimg
        ```
4. Copy this file to some location in the ext4 filesystem of your board and reboot the board.
5. Enter U-Boot prompt and load this uimg file to an initial copy location. If you have a compressed file, this will be loaded in this address and then uncompressed to load address by the bootm command later.
   1. Eg; 
        ```
        ext4load mmc 1 0x81000000 /boot/startup.uimg 
        ```

6. Finally, call the bootm command
   1. Bootm command will uncompress/load your uimg file without the Uboot's 64 bytes of header info to it's new location and then jump to the entry point address. This load and entry point address is the same as what you gave when using the mkimage command earlier
   2. Eg: 
    ```
    bootm 0x81000000
    ```
    This will cause the image file (without 64 bytes of header) to be copied to it's load address of 0x84000000 and then control jumps to it's entry point address - 0x84000000