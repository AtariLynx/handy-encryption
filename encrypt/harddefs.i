; Saturday 10-Mar-90 15:19:54
* === harddefs.i ============================================================
*
* Hardware Definitions  --  Handy Software
*
* Confidential and Proprietary
* Copyright (C) 1988, Epyx, Inc.
*
* Date		Name		Description
* ---------	--------------	---------------------------------------------
* 9-Mar-90	SHL		Added new stereo register definitions
* 7-Mar-90	SHL		Removed MAGRDYx definitions
*				Commented out MSTEREO until get real info
* 26-Feb-90	SHL		Corrected some bit definitions
* 13-Feb-90	SHL		Added a few more missing definitions
* 9-Feb-90	SHL		Added rest of the hardware definitions
*				Added CPU interrupt and reset vectors
* 7-Feb-90	SHL		Removed Apple emulation compatibility
* 25 May 89	-RJ		Deleted LEFT_ and RIGHT_FIRE_BUTTON defs
* 22 May 89	-RJ		Added RESTLESS definition, changed LIGHT_OFF
*				to EXTERNAL_POWER
* 11 May 89	-RJ		Changed sprite definitions to track the
*				definitions caused by the Shadow-E chip bug
* 10 May 89	-RJ		Added INNER_ and OUTER_BUTTON and MSTEREO and
*				CART0,1_IO_INACTIVE definitions
* 20 Apr 89	-RJ		Changed the game button definitions to match
*				the new way to handle Pause, Restart, Flip and
*				Game Options 1 & 2.  Added bit defs to DISPCTL
* 19 Apr 89	RG Goudy	Added serial port bit definitions
* 18 Apr 89	-RJ		The RELOAD_ definition comments say "reload"
* 19 Mar 89	-RJ		Added TURBO_DISABLE definition to MAPCTL
* 17 Jan 89	-RJ		Added POWERON and MOTORON of SYSCTL1
*				Renamed RCART to RCART_0 and added RCART_1
*				Deleted VIDEO/MIKEYTEST, added MTEST0/1/2
* 2 Jan 89	-RJ		Added EVER_ON and NO_COLLIDE
* 31 Dec 88	-RJ		When HANDYMATH is non-zero, the hardware
*				math registers now aren't defined here either
*				Added JOYSTICK and SWITCHES flag definitions
* 30 Dec 88	-RJ		Added sprite type defs.  Renamed REUSE_NONE
*				et al to the more accurate RELOAD_NONE et al
* 24-Dec-88	-RJ		Added sprite control register and audio
*				channel declarations and control bits
* 22 Dec 88	-RJ		Redefined all addresses, turning them into
*				symbols that Handebug will recognize
*
* Mid 87	=RJ Mical=	Created this file!
*
* ===========================================================================


* Size of a display buffer
DISPLAY_BUFSIZE	.EQ $1FE0


* First address of the block of hardware addresses.
HARDWARE_START	.EQ $FC00


* SUZY_ADDRESS is used by reset code to initialize the hardware.
* This address is written to and then read from as part of initiatlization
SUZY_ADDRESS	.EQ $FC92


* SUZY registers from $FC00-$FC7F (both sprite and MATH) clear the upper byte
* when the lower byte is stored to.

* Sprite engine registers - *'ed values are used internally by SUZY and
* cannot be usefully initialized externally.

		.OR $FC00
TMPADRL		.DS 1	; FC00 *
TMPADRH		.DS 1	; FC01 *
TILTACUML	.DS 1	; FC02 *
TILTACUMH	.DS 1	; FC03 *
HOFFL		.DS 1	; FC04
HOFFH		.DS 1	; FC05
VOFFL		.DS 1	; FC06
VOFFH		.DS 1	; FC07
VIDBASL		.DS 1	; FC08
VIDBASH		.DS 1	; FC09
COLLBASL	.DS 1	; FC0A
COLLBASH	.DS 1	; FC0B
VIDADRL		.DS 1	; FC0C *
VIDADRH		.DS 1	; FC0D *
COLLADRL	.DS 1	; FC0E *
COLLADRH	.DS 1	; FC0F *
SCBNEXTL	.DS 1	; FC10
SCBNEXTH	.DS 1	; FC11
SPRDLINEL	.DS 1	; FC12 *
SPRDLINEH	.DS 1	; FC13 *
HPOSSTRTL	.DS 1	; FC14 *
HPOSSTRTH	.DS 1	; FC15 *
VPOSSTRTL	.DS 1	; FC16 *
VPOSSTRTH	.DS 1	; FC17 *
SPRHSIZL	.DS 1	; FC18
SPRHSIZH	.DS 1	; FC19
SPRVSIZL	.DS 1	; FC1A
SPRVSIZH	.DS 1	; FC1B
STRETCHL	.DS 1	; FC1C *
STRETCHH	.DS 1	; FC1D *
TILTL		.DS 1	; FC1E *
TILTH		.DS 1	; FC1F *
SPRDOFFL	.DS 1	; FC20 *
SPRDOFFH	.DS 1	; FC21 *
SCVPOSL		.DS 1	; FC22 *
SCVPOSH		.DS 1	; FC23 *
COLLOFFL	.DS 1	; FC24
COLLOFFH	.DS 1	; FC25
VSIZACUML	.DS 1	; FC26 *
VSIZACUMH	.DS 1	; FC27 *
HSIZOFFL	.DS 1	; FC28
HSIZOFFH	.DS 1	; FC29
VSIZOFFL	.DS 1	; FC2A
VSIZOFFH	.DS 1	; FC2B
SCBADRL		.DS 1	; FC2C *
SCBADRH		.DS 1	; FC2D *
PROCADRL	.DS 1	; FC2E *
PROCADRH	.DS 1	; FC2F *


* Math engine registers

		.OR $FC52
MATHD		.DS 1	; FC52
MATHC		.DS 1	; FC53
MATHB		.DS 1	; FC54
MATHA		.DS 1	; FC55
MATHP		.DS 1	; FC56
MATHN		.DS 1	; FC57
		.OR $FC60
MATHH		.DS 1	; FC60
MATHG		.DS 1	; FC61
MATHF		.DS 1	; FC62
MATHE		.DS 1	; FC63
		.OR $FC6C
MATHM		.DS 1	; FC6C
MATHL		.DS 1	; FC6D
MATHK		.DS 1	; FC6E
MATHJ		.DS 1	; FC6F


* More SUZY control registers

		.OR $FC80
SPRCTL0		.DS 1	; FC80
* Sprite control 0 bit definitions
BITS_MASK	.EQ %11000000	; Mask for settings bits per pixel
* Sprite bits-per-pixel definitions
ONE_PER_PIXEL	.EQ %00000000
TWO_PER_PIXEL	.EQ %01000000
THREE_PER_PIXEL	.EQ %10000000
FOUR_PER_PIXEL	.EQ %11000000
* More sprite control 0 bit definitions
HFLIP		.EQ %00100000
VFLIP		.EQ %00010000
* Sprite types - redefined to reflect the reality caused by the shadow error
; NORMAL_SPRITE		.EQ %00000111
SHADOW_SPRITE		.EQ %00000111

XOR_SPRITE		.EQ %00000110
XOR_SHADOW_SPRITE	.EQ %00000110

NONCOLL_SPRITE		.EQ %00000101

; SHADOW_SPRITE		.EQ %00000100
NORMAL_SPRITE		.EQ %00000100

; BSHADOW_SPRITE	.EQ %00000011
BOUNDARY_SPRITE		.EQ %00000011

; BOUNDARY_SPRITE	.EQ %00000010
BSHADOW_SPRITE		.EQ %00000010

BACKNONCOLL_SPRITE	.EQ %00000001

BACKGROUND_SPRITE	.EQ %00000000
BACK_SHADOW_SPRITE	.EQ %00000000


SPRCTL1		.DS 1	; FC81
* Sprite control 1 bit definitions
LITERAL		.EQ %10000000
ALGO_3		.EQ %01000000	; broken, do not set this bit!
RELOAD_MASK	.EQ %00110000
* Sprite reload mask definitions
RELOAD_NONE	.EQ %00000000	; Reload nothing
RELOAD_HV	.EQ %00010000	; Reload hsize, vsize
RELOAD_HVS	.EQ %00100000	; Reload hsize, vsize, stretch
RELOAD_HVST	.EQ %00110000	; Reload hsize, vsize, stretch, tilt
* More sprite control 1 bit definitions
REUSE_PALETTE	.EQ %00001000
SKIP_SPRITE	.EQ %00000100
DRAW_UP		.EQ %00000010
DRAW_LEFT	.EQ %00000001


SPRCOLL		.DS 1	; FC82
* SPRCOLL bit definitions
NO_COLLIDE	.EQ %00100000

SPRINIT		.DS 1	; FC83

		.OR $FC88
SUZYHREV	.DS 1	; FC88
SUZYSREV	.DS 1	; FC89

		.OR $FC90
SUZYBUSEN	.DS 1	; FC90

SPRGO		.DS 1	; FC91
* These are the SPRGO flag definitions
EVER_ON		.EQ %00000100
SPRITE_GO	.EQ %00000001

SPRSYS		.DS 1	; FC92
* These are the SPRSYS flag definitions when writing
SIGNMATH	.EQ %10000000
ACCUMULATE	.EQ %01000000
;NO_COLLIDE	.EQ %00100000	; same as for SPRCOLL
VSTRETCH	.EQ %00010000
LEFTHAND	.EQ %00001000
UNSAFEACCESSRST	.EQ %00000100
SPRITESTOP	.EQ %00000010
* These are the SPRSYS flag definitions when reading
MATHWORKING	.EQ %10000000
MATHWARNING	.EQ %01000000
MATHCARRY	.EQ %00100000
VSTRETCHING	.EQ %00010000
LEFTHANDED	.EQ %00001000
UNSAFEACCESS	.EQ %00000100
SPRITETOSTOP	.EQ %00000010
SPRITEWORKING	.EQ %00000001

		.OR $FCB0
JOYSTICK	.DS 1	; FCB0
JOY_DOWN	.EQ %10000000
JOY_UP		.EQ %01000000
JOY_RIGHT	.EQ %00100000
JOY_LEFT	.EQ %00010000
OPTION1_BUTTON	.EQ %00001000
OPTION2_BUTTON	.EQ %00000100
INNER_BUTTON	.EQ %00000010
OUTER_BUTTON	.EQ %00000001
RESTART_BUTTON	.EQ OPTION1_BUTTON
FLIP_BUTTON	.EQ OPTION2_BUTTON

SWITCHES	.DS 1	; FCB1
CART1_IO_INACTIVE .EQ %00000100
CART0_IO_INACTIVE .EQ %00000010
PAUSE_SWITCH	.EQ %00000001

RCART_0		.DS 1	; FCB2
RCART_1		.DS 1	; FCB3


* LEDS output register only exists on early wire-wrap prototypes
		.OR $FCC0
LEDS		.DS 1	; FCC0


* The parallel IO port only exists on early wire-wrap prototypes
		.OR $FCC2
IOStatus	.DS 1	; FCC2
IOData		.DS 1	; FCC3

HOWIE		.DS 1	; FCC4


* The Mikey Timers
* First the logical timer names are defined, then the timer register offsets
		.OR $FD00
HCOUNT		; FD00
TIMER0		; FD00
	.DS 4
MAG0A		; FD04
TIMER1		; FD04
	.DS 4
VCOUNT		; FD08
TIMER2		; FD08
	.DS 4
MAG0B		; FD0C
TIMER3		; FD0C
	.DS 4
SERIALRATE	; FD10
TIMER4		; FD10
	.DS 4
MAG1A		; FD14
TIMER5		; FD14
	.DS 4
TIMER6		; FD18
	.DS 4
MAG1B		; FD1C
TIMER7		; FD1C
	.DS 4

* Here's the timer offsets
TIM_BACKUP	.EQ 0
TIM_CONTROLA	.EQ 1
TIM_COUNT	.EQ 2
TIM_CONTROLB	.EQ 3

* TIM_CONTROLA control bits
ENABLE_INT	.EQ %10000000
RESET_DONE	.EQ %01000000
ENABLE_RELOAD	.EQ %00010000
ENABLE_COUNT	.EQ %00001000
AUD_CLOCK_MASK	.EQ %00000111
* Clock settings
AUD_LINKING	.EQ %00000111
AUD_64		.EQ %00000110
AUD_32		.EQ %00000101
AUD_16		.EQ %00000100
AUD_8		.EQ %00000011
AUD_4		.EQ %00000010
AUD_2		.EQ %00000001
AUD_1		.EQ %00000000

* TIM_CONTROLB control bits
TIMER_DONE	.EQ %00001000
LAST_CLOCK	.EQ %00000100
BORROW_IN	.EQ %00000010
BORROW_OUT	.EQ %00000001


AUDIO0		.DS 8	; FD20
AUDIO1		.DS 8	; FD28
AUDIO2		.DS 8	; FD30
AUDIO3		.DS 8	; FD38
* Here's the audio channel offsets
AUD_VOLCNTRL	.EQ 0
AUD_FEEDBACK	.EQ 1
AUD_OUTPUT	.EQ 2
AUD_SHIFT	.EQ 3
AUD_BACKUP	.EQ 4
AUD_CONTROL	.EQ 5
AUD_COUNTER	.EQ 6
AUD_OTHER	.EQ 7
* The AUD_CONTROL bits are almost identical to the TIM_CONTROLA bits.
* Here's the AUD_CONTROL control bits that are different from the TIM_CONTROLA
* control bits.
* See TIM_CONTROLA above for the other definitions
FEEDBACK_7		.EQ %10000000
ENABLE_INTEGRATE	.EQ %00100000


; Stereo control registers follow
; Stereo capability does not exist in all Lynxes
; Left and right may be reversed, and if so will be corrected in a later
; release

		.OR $FD40
ATTENREG0	.DS 1	; FD40	; Stereo attenuation registers
ATTENREG1	.DS 1	; FD41
ATTENREG2	.DS 1	; FD42
ATTENREG3	.DS 1	; FD43
RIGHT_ATTENMASK	.EQ %11110000
LEFT_ATTENMASK	.EQ %00001111

MPAN		.DS 1	; FD44	; Stereo attenuation select register

		.OR $FD50
MSTEREO		.DS 1	; FD50	; Stereo channel disable register

; bit definitions for MPAN and MSTEREO registers
LEFT3_SELECT	.EQ %10000000
LEFT2_SELECT	.EQ %01000000
LEFT1_SELECT	.EQ %00100000
LEFT0_SELECT	.EQ %00010000
RIGHT3_SELECT	.EQ %00001000
RIGHT2_SELECT	.EQ %00000100
RIGHT1_SELECT	.EQ %00000010
RIGHT0_SELECT	.EQ %00000001


		.OR $FD80
INTRST		.DS 1	; FD80	; Interrupt Reset and Set registers
INTSET		.DS 1	; FD81

* Interrupt Reset and Set bit definitions
TIMER7_INT	.EQ %10000000
TIMER6_INT	.EQ %01000000
TIMER5_INT	.EQ %00100000
SERIAL_INT	.EQ %00010000
TIMER3_INT	.EQ %00001000
TIMER2_INT	.EQ %00000100
TIMER1_INT	.EQ %00000010
TIMER0_INT	.EQ %00000001
VERTICAL_INT	.EQ TIMER2_INT
HORIZONTAL_INT	.EQ TIMER0_INT

		.OR $FD86
AUDIN		.DS 1	; FD86	; Audio in
SYSCTL1		.DS 1	; FD87
* SYSCTL1 bit definitions
POWERON		.EQ %00000010
CART_ADDR_STROBE .EQ %00000001

MIKEYHREV	.DS 1	; FD88	; Mikey hardware rev
MIKEYSREV	.DS 1	; FD89	; Mikey software rev
IODIR		.DS 1	; FD8A
IODAT		.DS 1	; FD8B
* Here's the IODIR and IODAT bit definitions
;READ_ENABLE	.EQ %00010000
AUDIN_BIT	.EQ %00010000	; note that there is also the address AUDIN
RESTLESS	.EQ %00001000
NOEXP		.EQ %00000100	; If set, redeye is not connected
CART_ADDR_DATA	.EQ %00000010
CART_POWER_OFF	.EQ %00000010	; same bit for CART_ADDR_DATA
EXTERNAL_POWER	.EQ %00000001

SERCTL		.DS 1	; FD8C	; Serial control
* Here's the SERCTL bit definitions when writing
TXINTEN		.EQ %10000000
RXINTEN		.EQ %01000000
;unused		.EQ %00100000	; Leave unused bit 0 for future compatability
PAREN		.EQ %00010000
RESETERR	.EQ %00001000
TXOPEN		.EQ %00000100
TXBRK		.EQ %00000010
PAREVEN		.EQ %00000001
* Here's the SERCTL bit definitions when reading
TXRDY		.EQ %10000000
RXRDY		.EQ %01000000
TXEMPTY		.EQ %00100000
PARERR		.EQ %00010000
OVERRUN		.EQ %00001000
FRAMERR		.EQ %00000100
RXBRK		.EQ %00000010
PARBIT		.EQ %00000001

SERDAT		.DS 1	; FD8D	; Serial data



		.OR $FD90
SDONEACK	.DS 1	; FD90	; Suzy done ack
CPUSLEEP	.DS 1	; FD91	; zzz
DISPCTL		.DS 1	; FD92	; Display control
* Here are the DISPCTL bit definitions
DISP_COLOR	.EQ %00001000	; must be set to 1
DISP_FOURBIT	.EQ %00000100	; must be set to 1
DISP_FLIP	.EQ %00000010
DMA_ENABLE	.EQ %00000001	; must be set to 1

PBKUP		.DS 1	; FD93	; Display's magic 'P' count
DISPADRL	.DS 1	; FD94	; Start of display
DISPADRH	.DS 1	; FD95

		.OR $FD9C
MTEST0		.DS 1	; FD9C	; System test vectors, see spec for bits
MTEST1		.DS 1	; FD9D
MTEST2		.DS 1	; FD9E

* The Color registers
		.OR $FDA0
GREEN0		.DS 1	; FDA0
GREEN1		.DS 1	; FDA1
GREEN2		.DS 1	; FDA2
GREEN3		.DS 1	; FDA3
GREEN4		.DS 1	; FDA4
GREEN5		.DS 1	; FDA5
GREEN6		.DS 1	; FDA6
GREEN7		.DS 1	; FDA7
GREEN8		.DS 1	; FDA8
GREEN9		.DS 1	; FDA9
GREENA		.DS 1	; FDAA
GREENB		.DS 1	; FDAB
GREENC		.DS 1	; FDAC
GREEND		.DS 1	; FDAD
GREENE		.DS 1	; FDAE
GREENF		.DS 1	; FDAF

BLUERED0	.DS 1	; FDB0
BLUERED1	.DS 1	; FDB1
BLUERED2	.DS 1	; FDB2
BLUERED3	.DS 1	; FDB3
BLUERED4	.DS 1	; FDB4
BLUERED5	.DS 1	; FDB5
BLUERED6	.DS 1	; FDB6
BLUERED7	.DS 1	; FDB7
BLUERED8	.DS 1	; FDB8
BLUERED9	.DS 1	; FDB9
BLUEREDA	.DS 1	; FDBA
BLUEREDB	.DS 1	; FDBB
BLUEREDC	.DS 1	; FDBC
BLUEREDD	.DS 1	; FDBD
BLUEREDE	.DS 1	; FDBE
BLUEREDF	.DS 1	; FDBF


* The Map Control register
		.OR $FFF9
MAPCTL		.DS 1	; FFF9
* These are the MAPCTL flag definitions
TURBO_DISABLE	.EQ %10000000
VECTOR_SPACE	.EQ %00001000	; 1 maps RAM into specified space
ROM_SPACE	.EQ %00000100
MIKEY_SPACE	.EQ %00000010
SUZY_SPACE	.EQ %00000001

* 65C02 hardware interrupt and reset vectors
CPU_NMI		.DS 2	; FFFA
CPU_RESET	.DS 2	; FFFC
CPU_IRQ			; FFFE


