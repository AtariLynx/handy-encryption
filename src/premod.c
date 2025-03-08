
#include <stdio.h>

main (argc, argv)
int argc;
char *argv[];
	{
	int i, j, checksum=0, numblocks=0;
	unsigned char array[50];
	FILE *fpin, *fpout;

	if (argc != 3) {
		puts ("Usage:\n\tPREMOD <input> <output>\n");
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

	while (i=getc(fpin), ungetc(i,fpin), i>=0) {
		printf ("Block %d\n", numblocks++);

		for (i=49; i>=0; i--) {
			if ( (j = getc(fpin)) < 0) {
				printf ("Error reading input file: %s\n", argv[1]);
				exit (1);
				}
			array[i] = j-checksum;
			checksum = j;
			}

		putc (0x15, fpout);
		for (i=0; i<50; i++) {
			putc (array[i], fpout);
			}
		}

	if (checksum) {
		printf ("Invalid checksum on input file: %s\n", argv[1]);
		exit (1);
		}

	fclose (fpin);
	fclose (fpout);
	exit (0);
	}

