
##############################################################################
##
## Makefile for Handy ROM build process
##
## Proprietary and Confidential
##
## This MAKEFILE assumes an environment set up for the Aztec C compiler
##
##############################################################################




BUILDROM=	buildrom.o global.o main.o 
PREMOD=		premod.o
POSTMOD=	postmod.o

EXTDISK=	df1

.c.o:
	cc +L +C +D $*


all:
	make buildchk
	make buildrom
	make premod
	make postmod

buildrom: $(BUILDROM)
	ln $(BUILDROM) -lc32

premod: $(PREMOD)
	ln $(PREMOD) -lc32

postmod: $(POSTMOD)
	ln $(POSTMOD) -lc32

buildchk: buildchk.o
	ln buildchk.o -lc32


boot.bin: boot.src checkstring.src cartdefs.i romdir.i romsize.i
	asm boot +s

buildcheck.bin: boot.src cartdefs.i romdir.i romsize.i
	asm boot +dBUILDCHECK +sbuildcheck.sym +obuildcheck.bin

