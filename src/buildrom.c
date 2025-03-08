
/* *** buildrom.c ***********************************************************
 *
 * Build the ROM Image  --  Handy ROM Image Binary Builder
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


UBYTE	*AllocMem();

extern UBYTE fname[];



BOOL	BuildROM(romsize)
LONG	romsize;
{
	BOOL	retvalue;
	UBYTE	*image;
	FILE	*file;
	int	n;

	retvalue = FALSE;
	image = NULL;

	if ((image = AllocMem(romsize, NULL)) == NULL) 
		{
		printf("Couldn't allocate buffer of size %ld\n", romsize);
		goto DONE;
		}

	if ( (file = fopen(fname, "r")) == NULL)
		{
		printf("Couldn't open %s for input\n", fname);
		goto DONE;
		}
	fread(image, romsize, 1, file);
	fclose(file);

	if ( (file = fopen("boot.raw", "r")) == NULL)
		{
		printf("Couldn't open boot.raw for input\n");
		goto DONE;
		}
	printf ("boot.raw - %d bytes\n", n = fread(image, 1, 256, file) );
	fclose(file);

	if ( (file = fopen("boot2.raw", "r")) == NULL)
		{
		printf("Couldn't open boot2.raw for input\n");
		goto DONE;
		}
	printf ("boot2.raw - %d bytes\n", fread(image+n, 1, 256, file) );
	fclose(file);

	if ( (file = fopen(fname, "w")) == NULL)
		{
		printf("Couldn't open %s for output\n", fname);
		goto DONE;
		}
	fwrite(image, romsize, 1, file);
	fclose(file);

	retvalue = TRUE;

DONE:
	if (image) FreeMem(image, romsize);
	return(retvalue);
}





