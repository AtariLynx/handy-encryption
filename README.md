# Handy Cartridge Encryption System

This repository contains the encryption system for the Atari Lynx (also known as Handy).

- `adf`: Amiga Disk File format images with encryption system, keyfiles and empty disks used during process 
- `binaries`: Binary executables for building boot loader from source code and performing pre and post processing on boot loader, as well as performing encryption using three keyfile diskettes.
- `encrypt`: Boot loader source code and script to perform encryption process
- `keyfiles`: Contents of three keyfile parts that together can create private key for encryption. Also includes final private key in BigEndian format.
- `src`: Source code for utilities `buildchk`, `premod`, `postmod` and `buildrom`
