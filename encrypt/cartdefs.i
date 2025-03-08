
* === cartdefs.i ============================================================
*
* Cartridge Definitions for HandyAsm and HandyROM  --  Handy Software
*
* Confidential and Proprietary
* Copyright (C) 1989, Epyx, Inc.
*
* Date       Name              Description
* ---------  ----------------  ----------------------------------------------
* 20-Apr-89  =RJ Mical=        Created this file!
*
* ===========================================================================


ROM_HEADER_SIZE		.EQ 410


ROMDIR_PAGE		.EQ 0
ROMDIR_OFFSET		.EQ 1
ROMDIR_FLAG		.EQ 3
ROMDIR_DEST		.EQ 4
ROMDIR_SIZE		.EQ 6
ROMDIR_ENTRY_SIZE	.EQ 8


ROMFILE_ALIGN		.EQ 1


 #IFNDEF ROMSIZE
ROMSIZE			.EQ $100*512
 #ENDIF


ROMPAGECOUNT		.EQ 256



ROMPAGESIZE		.EQ ROMSIZE/ROMPAGECOUNT
ROMDIR_FILE0_PAGE	.EQ ROM_HEADER_SIZE/ROMPAGESIZE
ROMDIR_FILE0_OFFSET	.EQ ROM_HEADER_SIZE-{ROMDIR_FILE0_PAGE*ROMPAGESIZE}
ROMDIR_FILE1_LOC	.EQ ROM_HEADER_SIZE+ROMDIR_ENTRY_SIZE
ROMDIR_FILE1_PAGE	.EQ ROMDIR_FILE1_LOC/ROMPAGESIZE
ROMDIR_FILE1_OFFSET	.EQ ROMDIR_FILE1_LOC-{ROMDIR_FILE1_PAGE*ROMPAGESIZE}


