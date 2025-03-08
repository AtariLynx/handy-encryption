
/* *** main.c ***************************************************************
 *
 * Main Routine  --  Monitor ROM Builder
 *
 * Copyright (C) 1989, Epyx, Inc.
 * All Rights Reserved
 *
 * CONFIDENTIAL and PROPRIETARY
 *
 * HISTORY      NAME            DESCRIPTION
 * -----------  --------------  --------------------------------------------
 * 14 Mar 1989  =RJ Mical=      Created this file.
 *
 * *********************************************************************** */


#include "rombin.h"



extern	BOOL	OpenFiles();

UBYTE fname[80];
int romsize;


VOID	main(argc, argv)
int	argc;
char	**argv;
{
	int	retvalue;

	retvalue = 0;

	/* Note that this program doesn't call any sort of 
	 * CleanupEverything() routine, so any routine that fails 
	 * its task is obliged to clean up any partial work it may 
	 * have managed to complete.
	 */

	romsize = 1024*128;
	strcpy (fname, "BOOT:image.rom");

	if (argc > 1) strcpy (fname, argv[1]);
	if (argc > 2) romsize = 1024*atoi(argv[2]);

	if (NOT BuildROM(romsize)) retvalue = 10;

	exit(retvalue);
}



