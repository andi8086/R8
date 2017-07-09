.feature force_range
.debuginfo +

.setcpu "6502"
.macpack longbranch

.import chr_get_echo
.import chr_out

CBM2 := 1
; configuration
CONFIG_2A := 1

CONFIG_CBM_ALL := 1

CONFIG_DATAFLG := 1
CONFIG_EASTER_EGG := 1
CONFIG_FILE := 1; support PRINT#, INPUT#, GET#, CMD
;CONFIG_NO_CR := 0; terminal doesn't need explicit CRs on line ends
CONFIG_NO_LINE_EDITING := 1; support for "@", "_", BEL etc.
CONFIG_NO_READ_Y_IS_ZERO_HACK := 1
CONFIG_PEEK_SAVE_LINNUM := 1
CONFIG_SCRTCH_ORDER := 2

; zero page
ZP_START1 = $40
ZP_START2 = $4D
ZP_START3 = $43
ZP_START4 = $53

; extra/override ZP variables
CURDVC			:= $000E
TISTR			:= $008D
Z96				:= $0096
POSX			:= $00C6
TXPSV			:= LASTOP
USR				:= GORESTART ; XXX

; inputbuffer
INPUTBUFFER     := $0200

; constants
SPACE_FOR_GOSUB := $3E
STACK_TOP		:= $FA
WIDTH			:= 40
WIDTH2			:= 30

RAMSTART2		:= $0400

; magic memory locations
;ENTROPY = $E844
ENTROPY = $8070 ; AJR - yet nothing there in IO space


.import serial_getc  ; AJR
.import serial_putc  ; AJR
.import serial_getc_echo ; AJR
; monitor functions
;OPEN	:= $FFC0
;CLOSE	:= $FFC3
;CHKIN	:= $FFC6
;CHKOUT	:= $FFC9
;CLRCH	:= $FFCC
;CHRIN	:= $FFCF
CHRIN   := serial_getc_echo
;CHROUT	:= $FFD2
CHROUT  := serial_putc
;LOAD	:= $FFD5
SAVE	:= $FFD8
VERIFY	:= $FFDB
SYS		:= $FFDE
ISCNTC	:= $FFE1
GETIN	:= $FFE4
;CLALL	:= $FFE7 ; XXXXXXXXXXXXXX
; LE7F3	:= $E7F3; for CBM1
MONCOUT	:= CHROUT
;MONRDKEY := GETIN
MONRDKEY := CHRIN

CONFIG_2 := 1
CONFIG_11A := 1
CONFIG_11 := 1
CONFIG_10A := 1

;CONFIG_SMALL := 0

BYTES_FP		:= 5
CONFIG_SMALL_ERROR := 1

.ifndef BYTES_PER_ELEMENT
BYTES_PER_ELEMENT := BYTES_FP
.endif
BYTES_PER_VARIABLE := BYTES_FP+2
MANTISSA_BYTES	:= BYTES_FP-1
BYTES_PER_FRAME := 2*BYTES_FP+8
FOR_STACK1		:= 2*BYTES_FP+5
FOR_STACK2		:= BYTES_FP+4

.ifndef MAX_EXPON
MAX_EXPON = 10
.endif

STACK           := $0100
.ifndef STACK2
STACK2          := STACK
.endif

CONFIG_NO_INPUTBUFFER_ZP := 1
CONFIG_INPUTBUFFER_0200 := 1
INPUTBUFFERX = INPUTBUFFER & $FF00

CR=13
LF=10

.ifndef CRLF_1
CRLF_1 := CR
CRLF_2 := LF
.endif

.include "basic/macros.s"
.include "basic/zeropage.s"
.include "basic/header.s"
.include "basic/token.s"
.include "basic/error.s"
.include "basic/message.s"
.include "basic/memory.s"
.include "basic/program.s"
.include "basic/flow1.s"
.include "basic/loadsave.s"
.include "basic/flow2.s"
.include "basic/misc1.s"
.include "basic/print.s"
.include "basic/input.s"
.include "basic/eval.s"
.include "basic/var.s"
.include "basic/array.s"
.include "basic/misc2.s"
.include "basic/string.s"
.include "basic/misc3.s"
.include "basic/poke.s"
.include "basic/float.s"
.include "basic/chrget.s"
.include "basic/rnd.s"
.include "basic/trig.s"
.include "basic/init.s"
.include "basic/extra.s"
.include "basic/r8load.s"
.include "basic/r8file.s"
