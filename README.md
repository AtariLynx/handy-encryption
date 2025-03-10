# Handy Cartridge Encryption System

This repository contains the encryption system for the Atari Lynx (also known as Handy).

- `adf`: Amiga Disk File format images with encryption system, keyfiles and empty disks used during process 
- `binaries`: Binary executables for building boot loader from source code and performing pre and post processing on boot loader, as well as performing encryption using three keyfile diskettes.
- `encrypt`: Boot loader source code and script to perform encryption process
- `keyfiles`: Contents of three keyfile parts that together can create private key for encryption. Also includes final private key in BigEndian format.
- `src`: Source code for utilities `buildchk`, `premod`, `postmod` and `buildrom`

## Getting started

Short version for now:

Use the diskette files inside the `adf` folder with WinUAE. The next steps assume your are familiar with WinUAE.

1. Boot using `handy-encryption.adf` from an Kickstart 1.3 ROM Amiga system.
1. After booting insert an diskette with your unencrypted ROM file on it. Copy it over to your current directory.
   ```
   copy df0:yourfile.rom yourfile.rom
   ```
1. Run the `doit` AmigaDOS script and pass the name of the ROM file and its size in KB.
   ```
   execute doit yourfile.rom 256
   ```
1. When prompted use the `rsa.adf` diskette. The script will copy the first part of the boot loader to it.
1. Eject the RSA diskette.
1. Start another WinUAE instance, again with Kickstart 1.3 and the `epyx-keyfile1.adf` file inserted in floppy drive to boot from it. This will boot and start the `realbig` program directly, prompting you to insert the disk with `df0:keyfile.1`. Press Return as this diskette is currently inserted. 
1. When prompted for `keyfile.2`, eject the current diskette and insert `epyx-keyfile2.adf` and press Return. 
1. Repeat for `epyx-keyfile3.adf`.
1. Insert `rsa.adf` and the encryption tool will copy the now encrypted file to this disk as `output`.
1. Eject the RSA disk from the encryption emulator.
1. Insert it again in the first emulator you started. Press Return to continue.
1. Eject the RSA disk again and insert in the second emulator. Press Return once more.
1. Again, eject the RSA disk and reinsert in the first emulator. Press Return a final time.

After this sequence your original ROM file is available now in the RAM drive of the first emulator. Make sure to copy it from the first emulator onto a diskette, such as `rsa.adf` which is inserted now anyway. If you forget to copy it from the emulator, it will be lost after a restart, requiring you to repeat the process.

A longer version of the use of these encryption disks will be available later.

