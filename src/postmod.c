
#include <stdio.h>

main (argc, argv)
int argc;
char *argv[];
	{
	int i, j, temp, numblocks;
	unsigned char array[51];
	FILE *fpin, *fpout;

	if (argc != 4) {
		puts ("Usage:\n\tPOSTMOD <input> <output> <numblocks>\n");
		exit (1);
		}

	numblocks = atoi(argv[3]);
	if ( (numblocks<1) || (numblocks>5) ) {
		printf ("Invalid number of blocks: %d\n", numblocks);
		exit (1);
		}

	if ( !(fpin = fopen (argv[1],"r") ) ) {
		printf ("Error opening input file: %s\n", argv[1]);
		exit (1);
		}
	if ( !(fpout = fopen (argv[2],"w") ) ) {
		printf ("Error opening output file: %s\n", argv[2]);
		exit (1);
		}

	putc (256-numblocks, fpout);

	for (j=0; j<numblocks; j++) {
		for (i=50; i>=0; i--) {
			if ( (temp = getc(fpin)) < 0) {
				printf ("Error reading input file: %s\n", argv[1]);
				exit (1);
				}
			array[i] = temp;
			}

		for (i=0; i<51; i++) {
			putc (array[i], fpout);
			}
		}

	if (getc(fpin) >= 0) {
		printf ("Warning: input file longer than %d blocks\n", numblocks);
		}

	fclose (fpin);
	fclose (fpout);
	exit (0);
	}

