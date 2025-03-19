TITLE_FILE              .EQU  0
MAIN_FILE               .EQU  1

ROMDIR_PAGE             .EQU  0  ; This field is required
ROMDIR_OFFSET           .EQU  1  ; This field is required
ROMDIR_FLAG             .EQU  3
ROMDIR_DEST             .EQU  4
ROMDIR_SIZE             .EQU  6  ; This field is required
ROMDIR_ENTRY_SIZE       .EQU  8  ; This field is required

ROM_HEADER_SIZE         .EQ   410
ROMFILE_ALIGN           .EQU  1
ROMSIZE                 .EQU  $100*512  ; 128KB size ROM
; ROM_NODIR
ROM_SCREENBLANK_VALUE   .EQU  $FF ; Clear to white
ROMPAGECOUNT            .EQU  256

* --------------------------------------------------------------------------
* These constants should not be edited.  You should allow their values to 
* be computed based on the values that you've entered above.  
ROMPAGESIZE          .EQU  ROMSIZE/ROMPAGECOUNT
ROMDIR_FILE0_PAGE    .EQU  ROM_HEADER_SIZE/ROMPAGESIZE
ROMDIR_FILE0_OFFSET  .EQU  ROM_HEADER_SIZE-{ROMDIR_FILE0_PAGE*ROMPAGESIZE}
ROMDIR_FILE1_LOC     .EQU  ROM_HEADER_SIZE+ROMDIR_ENTRY_SIZE
ROMDIR_FILE1_PAGE    .EQU  ROMDIR_FILE1_LOC/ROMPAGESIZE
ROMDIR_FILE1_OFFSET  .EQU  ROMDIR_FILE1_LOC-{ROMDIR_FILE0_PAGE*ROMPAGESIZE}
* --------------------------------------------------------------------------
