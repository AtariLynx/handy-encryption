
* === cartdefs.i ============================================================
* 
* Cartridge Definitions for HandyAsm and HandyROM  --  Handy Software
* 
* Confidential and Proprietary
* Copyright (C) 1989, Epyx, Inc.
* 
* Date       Name              Description
* ---------  ----------------  ----------------------------------------------
* 26 May 89  =RJ Mical=        Created this file!
* 
* ===========================================================================



* This file contains definitions that describe the contents and layout of the
* game cartridge.  This file should be used both during the assembly of 
* the program and during the compilation of the ROM image, thereby allowing
* (and guaranteeing) that the values will be the same in both places.  
* 
* The original copy of this file is distributed in the system's 6502:examples 
* directory.  You should copy this file into your own directory, and then 
* edit the copy to suit your own requirements.  


* Here's the file number definitions.  These are used by the HandyAsm CART 
* macros and as the arguments to the HandyROM FILE directive.  
TITLE_FILE	.EQU	0
MAIN_FILE	.EQU	1


* These constants define the layout of the file directory entry.  
* Each constant describes the byte offset of the field from the beginning
* of the entry.  You can change the offsets as you like, and remove some of 
* the fields if you don't need them.  
* 
* Note that these constants must have reasonable values even if you intend 
* on using ROM_NODIR to specify that you don't want HandyROM to build a 
* directory into your ROM image.  This is because the Handy boot process 
* requires the ROM to have at least one directory entry.  Refer to the Handy
* Programmer's Guide for details.
ROMDIR_PAGE		.EQU	0	; This field is required
ROMDIR_OFFSET		.EQU	1	; This field is required
ROMDIR_FLAG		.EQU	3
ROMDIR_DEST		.EQU	4
ROMDIR_SIZE		.EQU	6	; This field is required
ROMDIR_ENTRY_SIZE	.EQU	8	; This field is required


* The ROMFILE_ALIGN value is used to define the byte boundary to which the 
* file's first byte will be aligned.   This constant must be defined, and it 
* must have a reasonable power-of-2 value (such as 1, 2, 4, 8, etc).  
ROMFILE_ALIGN		.EQU	1


* Edit this value as needed to declare the size of your ROM.  
ROMSIZE			.EQU	$100*512


* If you don't want a file directory in your ROM and you aren't going to be 
* using the CART file system, you should define the ROM_NODIR constant.  If 
* ROM_NODIR is defined, the file system support code will be omitted when the 
* CART system is assembled and HandyROM will not add a directory to your ROM.
; ROM_NODIR


* This value is used by the ROM loader when blanking the display to a solid 
* color.  This value is written to all of the GREEN and BLUERED registers.
ROM_SCREENBLANK_VALUE	.EQU	$F3 ; Clear to blue-grey


* Edit this value as needed to declare the number of pages in your ROM.  
* You should never need to change this value!
ROMPAGECOUNT		.EQU	256


* --------------------------------------------------------------------------
* These constants should not be edited.  You should allow their values to 
* be computed based on the values that you've entered above.  
ROMPAGESIZE		.EQU	ROMSIZE/ROMPAGECOUNT
ROMDIR_FILE0_PAGE	.EQU	ROM_HEADER_SIZE/ROMPAGESIZE
ROMDIR_FILE0_OFFSET	.EQU	ROM_HEADER_SIZE-{ROMDIR_FILE0_PAGE*ROMPAGESIZE}
ROMDIR_FILE1_LOC	.EQU	ROM_HEADER_SIZE+ROMDIR_ENTRY_SIZE
ROMDIR_FILE1_PAGE	.EQU	ROMDIR_FILE1_LOC/ROMPAGESIZE
ROMDIR_FILE1_OFFSET	.EQU	ROMDIR_FILE1_LOC-{ROMDIR_FILE0_PAGE*ROMPAGESIZE}
* --------------------------------------------------------------------------
