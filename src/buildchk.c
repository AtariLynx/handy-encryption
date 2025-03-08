
/* *** buildchk.c ***********************************************************
 *
 * Build the Security code  --  Handy ROM security code builder
 *
 * Copyright (C) 1989, Epyx, Inc.
 * All Rights Reserved
 *
 * CONFIDENTIAL and PROPRIETARY
 *
 * HISTORY      NAME             DESCRIPTION
 * -----------  ---------------   --------------------------------------------
 * 5 Apr 1990   Stephen Landrum  Created this file.
 *
 * *********************************************************************** */


#include "rombin.h"



#define HASH_COUNT		2
#define BUFFERLENGTH		32
#define RESULTLENGTH 	(BUFFERLENGTH/2)
#define RSAPAGELENGTH	51

#define ROMDIR_PAGE			0
#define ROMDIR_OFFSET		1
#define ROMDIR_FLAG			3
#define ROMDIR_DEST			4
#define ROMDIR_SIZE			6
#define ROMDIR_ENTRY_SIZE	8



UBYTE	*AllocMem();

BOOL	BuildChk();

UBYTE fname[80];

int romsize;


int sbox[] = {
	0x42,0x47,0x8A,0x1B,0x01,0x53,0x68,0x1F,
	0x30,0x7A,0x14,0x84,0x05,0xFA,0xC6,0xAD,
	0xD8,0xFB,0xD2,0x0D,0x64,0x9D,0x93,0xF4,
	0x49,0x21,0x76,0xD5,0x6F,0xBB,0x9E,0xDC,
	0x92,0x8C,0x31,0x60,0x26,0xA8,0xC7,0x3E,
	0xB8,0x7E,0xCE,0xC1,0xDD,0x9B,0xF9,0xC2,
	0x97,0xF5,0xFC,0xBE,0xA9,0x3B,0x9C,0x6D,
	0xAA,0x10,0xE4,0x43,0xD1,0x5E,0x0E,0xB1,
	0xCB,0xC5,0xB3,0x94,0x44,0x4E,0xC8,0xF8,
	0xEC,0x5F,0xCA,0xE6,0x0F,0x8B,0x1C,0x4A,
	0x0C,0x06,0xE3,0x2F,0xE5,0x19,0x1A,0x2E,
	0x69,0x88,0xEF,0x0B,0x9A,0x46,0x55,0x3A,
	0x11,0x1D,0xA5,0xC0,0x87,0x48,0x29,0x17,
	0x8D,0x78,0xAB,0xEE,0x7D,0x54,0x08,0x1E,
	0xA0,0xED,0x6C,0x13,0xD9,0xB9,0x81,0xAE,
	0x95,0xA3,0x18,0xD7,0x66,0xBA,0x99,0xEA,
	0xD3,0xA7,0xF2,0xD6,0x04,0xA1,0xF3,0x5B,
	0x77,0x3D,0xA6,0x09,0xB4,0x86,0x6B,0x4F,
	0xDE,0x50,0x52,0x22,0x2B,0x16,0x57,0xDF,
	0x65,0x4D,0xE0,0xAF,0xCD,0x3C,0x90,0x72,
	0x5A,0xF0,0xE2,0x2A,0x8F,0xE9,0xFF,0x28,
	0xB6,0x89,0xB2,0xF1,0x9F,0x61,0x6A,0x12,
	0x80,0x98,0x37,0x67,0xFE,0xB7,0x41,0x45,
	0x2D,0x6E,0xCF,0x75,0x0A,0x25,0xE1,0x7F,
	0xAC,0x2C,0x82,0x7B,0x23,0x4C,0x4B,0x33,
	0x58,0x32,0xF7,0x35,0xEB,0x85,0xC4,0xBF,
	0x8E,0x5D,0x63,0x5C,0x39,0x3F,0xA4,0xE8,
	0xBD,0x36,0x00,0x71,0xF6,0x51,0x20,0xCC,
	0x27,0xB0,0xD0,0xDA,0x96,0x74,0xBC,0x24,
	0xB5,0xE7,0x02,0x91,0xC9,0x07,0x59,0x79,
	0xC3,0xA2,0x83,0x15,0x40,0x56,0x34,0x03,
	0xDB,0xD4,0x62,0xFD,0x73,0x70,0x7C,0x38
	};


int bchk[] = { 410, 512, 0 };



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

	if (NOT BuildChk(romsize)) retvalue = 10;

	exit(retvalue);
}




BOOL	BuildChk(romsize)
LONG	romsize;
{
	BOOL	retvalue;
	UBYTE	*image;
	FILE	*file;
	int	i, j, k, l, sum, tickler, pagesize;
	UBYTE	hbuffer0[RESULTLENGTH], hbuffer1[BUFFERLENGTH];

	pagesize = romsize/256;
	bchk[2] = pagesize;

	retvalue = FALSE;
	image = NULL;

	if ((image = AllocMem(romsize, NULL)) == NULL) {
		printf("Couldn't allocate buffer of size %ld\n", romsize);
		goto DONE;
		}


/* Read in ROM image file */

	if ( (file = fopen(fname, "r")) == NULL) {
		printf ("Couldn't open %s for input\n", fname);
		goto DONE;
		}
	i = fread(image, 1, romsize, file);
	j = getc(file);
	fclose(file);

	if ((i!=romsize) || (j!=EOF)) {
		printf ("\nFile %s is not %dK long\n", fname, romsize/1024);
		goto DONE;
		}

/* Search for directory entries */
	i = 0;
	do {
		j = bchk[i++];
		k = j+ROMDIR_ENTRY_SIZE;
		if ( (image[j+ROMDIR_DEST+1] >= 0x24)  &&
			  (image[k+ROMDIR_DEST+1] >= 0x04)  &&
			  (image[j+ROMDIR_OFFSET+1] < (pagesize>>8))  &&
			  (image[k+ROMDIR_OFFSET+1] < (pagesize>>8)) &&
			  (image[j+ROMDIR_DEST]+(image[j+ROMDIR_DEST+1]<<8)+
				image[j+ROMDIR_SIZE]+(image[j+ROMDIR_SIZE+1]<<8) <= 0xfc00) &&
			  (image[k+ROMDIR_DEST]+(image[k+ROMDIR_DEST+1]<<8)+
				image[k+ROMDIR_SIZE]+(image[k+ROMDIR_SIZE+1]<<8) <= 0xfc00) )
					break;
		} while (i<3);

	if (!j) {
		printf ("Invalid directory structure in ROM file\n");
		goto DONE;
		}

	if ( (file = fopen("romdir.i", "w")) == NULL) {
		printf ("Couldn't open romdir.i for output\n");
		goto DONE;
		}

	printf ("Found directory at %d\n", j);

	fprintf (file, "FILE0PAGE\t.EQ $%02x\n", image[j+ROMDIR_PAGE]);
	fprintf (file, "FILE0OFFSET\t.EQ $%02x%02x\n",
					image[j+ROMDIR_OFFSET+1], image[j+ROMDIR_OFFSET]);
	fprintf (file, "FILE0ADDRESS\t.EQ $%02x%02x\n",
					image[j+ROMDIR_DEST+1], image[j+ROMDIR_DEST]);
	fprintf (file, "FILE0SIZE\t.EQ $%02x%02x\n\n",
					image[j+ROMDIR_SIZE+1], image[j+ROMDIR_SIZE]);

	j += ROMDIR_ENTRY_SIZE;

	fprintf (file, "FILE1PAGE\t.EQ $%02x\n", image[j+ROMDIR_PAGE]);
	fprintf (file, "FILE1OFFSET\t.EQ $%02x%02x\n",
					image[j+ROMDIR_OFFSET+1], image[j+ROMDIR_OFFSET]);
	fprintf (file, "FILE1ADDRESS\t.EQ $%02x%02x\n",
					image[j+ROMDIR_DEST+1], image[j+ROMDIR_DEST]);
	fprintf (file, "FILE1SIZE\t.EQ $%02x%02x\n\n",
					image[j+ROMDIR_SIZE+1], image[j+ROMDIR_SIZE]);


/* Prepare to perform hash */

	for (i=0; i<RESULTLENGTH; i++) {
		hbuffer0[i] = 0;
		hbuffer1[i] = 0;
		}

/*	j = (RSAPAGELENGTH*3+1)+(RSAPAGELENGTH*5+1); */
	j = ((RSAPAGELENGTH*(3+5)-1) + (romsize/4096))  &  (~((romsize/4096)-1));
	l = 0;
	while (j<romsize) {
/*
		if ((j & (romsize/4096-1))  &&  (j > (romsize/256-romsize/4096))) {
			j = romsize/256;
			}
 */
		if (!(l++&0x3f)) {
			putchar ('.');		/* give user some feedback */
			fflush (stdout);
			}

		sum = 0x100;
		for (i=RESULTLENGTH-1; i>=0; i--) {
			sum = *(image+j++) + (sum&0xff00);
			k = 0;
			while (k < ((romsize/65536)-1)) {
				sum = (sum&0xff) + *(image+j++) + (sum>>8);
				k++;
				}
			hbuffer1[i+RESULTLENGTH] = sum & 0xff;
			}

		tickler = 0;
		sum = 0;
		for (k=0; k<HASH_COUNT; k++) {
			for (i=BUFFERLENGTH-1; i>=0; i--) {
				sum = (sum&0xff) + hbuffer1[i] + (sum>>8);
/* -* /
printf ("-%02x", sum&0xff);
/ *- */
				hbuffer1[i] = sum & 0xff;
				sum = (sum&0xff) + tickler + (sum>>8);
/* -* /
printf ("/%02x:%02x", sum&0xff, sbox[sum&0xff]);
/ *- */
				sum = sbox[sum&0xff] + (sum&0xff00);
				tickler++;
				}
/*  -* /
printf ("\n");
/ *- */
			}
/* -* /
printf ("(%d) - ", j);
/ *- */
		for (i=0; i<RESULTLENGTH; i++) {
			hbuffer1[i] ^= hbuffer0[i];
			hbuffer0[i] = hbuffer1[i];
/* -* /
printf ("%02x", hbuffer1[i]);
/ *- */
			}
/* -* /
printf ("\n");
/ *- */
		}

	putchar ('\n');


	if ( (file = fopen("checkstring.src", "w")) == NULL) {
		printf("Couldn't open checkstring.src for output\n");
		goto DONE;
		}

	fprintf (file, "\t.HS ");
	for (i=0; i<RESULTLENGTH; i++) fprintf (file, "%02x", hbuffer0[i]);
	fprintf (file, "\n\n");
	
	fclose(file);

	retvalue = TRUE;

DONE:
	if (image) FreeMem(image, romsize);
	return(retvalue);
}





