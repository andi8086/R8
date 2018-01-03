; ***********************************  REICHEL R8   *************************************
; *               V I D E O     C O N T R O L L E R    F I R M W A R E                  *
; *                                      v 1.0                                          *
; *                          (c) 2016 Andreas J. Reichel                                *
; *                                                                                     *
; *  Target Device: Atmega 1248(P)                                                      *
; *                                                                                     *
; *  Used I/O Pins:                                                                     *
; *       D5 - HSYNC to AD725 Video Encoder                                             *
; *       B0 - CLOCK to RAMDAC Address Counter                                          *
; *       A0 - Reset RAMDAC Address Counter                                             *
; *       C7 - Video Lock Signal (VLOCK)                                                *
; *       C6 - Video Blank (BLANK)                                                      *
; *                                                                                     *
; *  Description:                                                                       *
; *       Generates a PAL Timing (Fake Progressive 2 x 312 Lines)                       *
; *       with a resolution of 210x156 pixels in 256 colors.                            *
; *       B0 is used to increment the address count on the 74HCT4040 counters           *
; *       and A0 is used to reset the counters on each frame start.                     *
; *       If C6 is logical 1, the output of the Video SRAM is decoupled from the        *
; *       Resistor DAC, preven ting any read operations from the SRAM by the CPU        *
; *       from being seen on screen.                                                    *
; *       C7 locks the Address-Bus if logical 1, by decoupling the system Address       *
; *       Bus from the video SRAM. This gives address control to the 74HCT4040          *
; *       counters. When VLOCK is enabled, the CPU can only read data from the          *
; *       address given by the current counter value.                                   *
; *                                                                                     *
; * BUGFIX 2016/09/18 - replace Atmega 1284P with 168-20PU                              *
; *       The Atmega 1284P could not be overclocked to 22 MHz, so the chip had to       *
; *       be replaced with a more 'tollerant' one                                       *
; *                                                                                     *
; *       Signals were changed:                                                         *
; *             old          new                                                        *
; *             D5 - HSYNC - B1 (OC1A)                                                  *
; *             B0 - PXCLOCK - D0                                                       *
; *             A0 - RESRAMD - C5                                                       *
; *             C7 - VLOCK   - C1                                                       *
; *             C6 - BLANK   - C0                                                       *
; ***************************************************************************************

.include "m168def.inc"

.org 0x00

; Interrupt vector table

reset:          jmp main                     
int0:           jmp defaultInt 
int1:           jmp defaultInt
pcint0:         jmp defaultInt
pcint1:         jmp defaultInt
pcint2:         jmp defaultInt
intwdt:         jmp defaultInt
intTIMER2_COMPA:jmp defaultInt
intTIMER2_COMPB:jmp defaultInt
intTIMER2_OVF:  jmp defaultInt
intTIMER1_CAPT: jmp defaultInt 
intTIMER1_COMPA:jmp defaultInt
intTIMER1_COMPB:jmp defaultInt
intTIMER1_OVF:  jmp vidIntHandler 
intTIMER0_COMPA:jmp defaultInt
intTIMER0_COMPB:jmp defaultInt
intTIMER0_OVF:  jmp defaultInt
intSPI:         jmp defaultInt
intUSART0_RX:   jmp defaultInt
intUSART0_UDRE: jmp defaultInt
intUSART0_TX:   jmp defaultInt
intADC:         jmp defaultInt
intEE_READY:    jmp defaultInt
intANACOMP:     jmp defaultInt
intTWI:         jmp defaultInt
intSPM_READY:   jmp defaultInt

; Video timing constants
.equ _CPU_CYCLES_PER_MUSEC, 22 

.equ _PAL_TIME_SCANLINE, 64     ; µs
; .equ _PAL_TIME_HSYNC, 4.7       
; .equ _PAL_TIME_VSYNC, 58.85

.equ _PAL_CYCLES_SCAN_LINE_FULL, 1407
.equ _PAL_CYCLES_SCAN_LINE_HALF, 704 
.equ _PAL_CYCLES_VERT_SYNC_LONG, 660
.equ _PAL_CYCLES_VERT_SYNC_SHORT, 48
.equ _PAL_CYCLES_HORIZ_SYNC, 103

; Frame structure constants
.equ _LINES_VSYNC_LONG1, 2
.equ _LINES_VSYNC_SHORT1, 2
.equ _LINES_FIELD1, 305
.equ _LINES_VSYNC_SHORT2, 3
.equ _LINES_VSYNC_LONG2, 3
.equ _LINES_VSYNC_SHORT3, 2
.equ _LINES_FIELD2, 305
.equ _LINES_VSYNC_SHORT4, 3

; Control Signals
.equ _VDATA_DDR_, DDRC
.equ _VDATA_PORT_, PORTC
.equ _VDATA_RESET_, 32
.equ _VDATA_LOCK_, 2
.equ _VDATA_BLANK_, 1

defaultInt:
    reti

vidIntHandler:
    ; r30:r31 points to active scanline handler
    icall 
    reti

; *********************************** VIDEO HANDLER *************************************
; LINES 1 - 3: 5x LONG SYNC
; ***************************************************************************************
vproc_l1:
    inc r24     ; this function starts with r24 = 0..4
    cpi r24, _LINES_VSYNC_LONG1
    breq vs_set_vproc_s1
    ret
vs_set_vproc_s1:
    clr r24
    ldi r16, hi8(_PAL_CYCLES_VERT_SYNC_SHORT)
    sts OCR1AH, r16
    ldi r16, lo8(_PAL_CYCLES_VERT_SYNC_SHORT)
    sts OCR1AL, r16
    ; switch interrupt handler
    ldi ZL, pm_lo8(vproc_s1)
    ldi ZH, pm_hi8(vproc_s1)
    ret

; *********************************** VIDEO HANDLER *************************************
; LINES 3.5 - 5.5: 5x SHORT SYNC
; ***************************************************************************************
vproc_s1:
    inc r24
    cpi r24, _LINES_VSYNC_SHORT1
    breq vs_set_vproc_f1
    ret
vs_set_vproc_f1:
    clr r24
    ldi ZL, pm_lo8(vproc_f1)
    ldi ZH, pm_hi8(vproc_f1)
    
    ldi r16, hi8(_PAL_CYCLES_HORIZ_SYNC)
    sts OCR1AH, r16
    ldi r16, lo8(_PAL_CYCLES_HORIZ_SYNC)
    sts OCR1AL, r16

    ldi r18, _VDATA_BLANK_ | _VDATA_LOCK_ | _VDATA_RESET_ 
    out _VDATA_PORT_, r18      ; reset RAMDAC Address counter
    nop
    nop 
    ldi r18, _VDATA_BLANK_ | _VDATA_LOCK_
    out _VDATA_PORT_, r18
    ret

; *********************************** VIDEO HANDLER *************************************
; VISIBLE LINES 6 -- 310, 305 lines (2 times 152)
; ***************************************************************************************
vproc_f1:
    inc r24
    cpi r24, 142
    breq vs_set_vproc_s2

    ldi r18, 0
    ldi r19, 1
    ldi r17, 80 
dproc_delayfirstpixel:
    dec r17
    brne dproc_delayfirstpixel
    ldi r20, _VDATA_LOCK_      ; VLOCK, not BLANK
    out _VDATA_PORT_, r20      ; activate VLOCK, deactivate BLANK

    ldi r17, 210       ; there are 210 pixels in each line, count from 210 to 1
dproc_nextpixel:    
    out PORTD, r18      ; counter clock pin down
    dec r17
    out PORTD, r19      ; counter clock pin up
    brne dproc_nextpixel       ; if we are on last pixel, do not loop back

    ldi r20, _VDATA_LOCK_ | _VDATA_BLANK_
    out _VDATA_PORT_, r20
    
    ldi ZL, pm_lo8(empty_line_proc_f1)
    ldi ZH, pm_hi8(empty_line_proc_f1)
; insert one empty line
    ret
vs_set_vproc_s2:
    clr r24
    ldi r16, hi8(_PAL_CYCLES_VERT_SYNC_SHORT)
    sts OCR1AH, r16
    ldi r16, lo8(_PAL_CYCLES_VERT_SYNC_SHORT)
    sts OCR1AL, r16
    ; switch interrupt handler
    ldi ZL, pm_lo8(vproc_s2)
    ldi ZH, pm_hi8(vproc_s2)
    ldi r20, _VDATA_BLANK_ | _VDATA_RESET_    ; not VLOCK, BLANK
    out _VDATA_PORT_, r20      ; deactivate VLOCK, activate BLANK
    ret


empty_line_proc_f1:
; return to field1 display line
    ldi ZL, pm_lo8(vproc_f1)
    ldi ZH, pm_hi8(vproc_f1)
    ret


; *********************************** VIDEO HANDLER *************************************
; LINES 311 - 313: 5x SHORT SYNC
; ***************************************************************************************
vproc_s2:
    inc r24
    cpi r24, _LINES_VSYNC_SHORT2
    breq vs_set_vproc_l2
    ret
vs_set_vproc_l2:
    clr r24
    ldi r16, hi8(_PAL_CYCLES_VERT_SYNC_LONG)
    sts OCR1AH, r16
    ldi r16, lo8(_PAL_CYCLES_VERT_SYNC_LONG)
    sts OCR1AL, r16
    ; switch interrupt handler
    ldi ZL, pm_lo8(vproc_l2)
    ldi ZH, pm_hi8(vproc_l2)
    ret

; *********************************** VIDEO HANDLER *************************************
; LINES 313.5 - 315.5: 5x LONG SYNC
; ***************************************************************************************
vproc_l2:
    inc r24
    cpi r24, _LINES_VSYNC_LONG2
    breq vs_set_vproc_s3
    ret
vs_set_vproc_s3:
    clr r24
    ldi r16, hi8(_PAL_CYCLES_VERT_SYNC_SHORT)
    sts OCR1AH, r16
    ldi r16, lo8(_PAL_CYCLES_VERT_SYNC_SHORT)
    sts OCR1AL, r16
    ; switch interrupt handler
    ldi ZL, pm_lo8(vproc_s3)
    ldi ZH, pm_hi8(vproc_s3)
    ret

; *********************************** VIDEO HANDLER *************************************
; LINES 314 - 316: 4x SHORT SYNC
; ***************************************************************************************
vproc_s3:
    inc r24
    cpi r24, _LINES_VSYNC_SHORT3
    breq vs_set_vproc_f2
    ret
vs_set_vproc_f2:
    clr r24
    ldi r16, hi8(_PAL_CYCLES_HORIZ_SYNC)
    sts OCR1AH, r16
    ldi r16, lo8(_PAL_CYCLES_HORIZ_SYNC)
    sts OCR1AL, r16
    ; switch interrupt handler
    ldi ZL, pm_lo8(vproc_f2)
    ldi ZH, pm_hi8(vproc_f2)
    ret


; *********************************** VIDEO HANDLER *************************************
;  LINES 318 -- 622: 305 lines field 2
; ***************************************************************************************
vproc_f2:
    inc r24
    cpi r24, 255
    breq vs_set_vproc_f2b
    ret
vs_set_vproc_f2b:
    clr r24
    ; switch interrupt handler
    ldi ZL, pm_lo8(vproc_f2b)
    ldi ZH, pm_hi8(vproc_f2b)
    ret

vproc_f2b:
    inc r24
    cpi r24, 150
    breq vs_set_vproc_s4
    ret
vs_set_vproc_s4:
    clr r24
    ldi r16, hi8(_PAL_CYCLES_VERT_SYNC_SHORT)
    sts OCR1AH, r16
    ldi r16, lo8(_PAL_CYCLES_VERT_SYNC_SHORT)
    sts OCR1AL, r16
    ; switch interrupt handler
    ldi ZL, pm_lo8(vproc_s4)
    ldi ZH, pm_hi8(vproc_s4)
    ret

; *********************************** VIDEO HANDLER *************************************
;  LINES 623 -- 625.5: 6x SHORT SYNC
; ***************************************************************************************
vproc_s4:
    inc r24
    cpi r24, _LINES_VSYNC_SHORT4
    breq vs_set_vproc_l1
    ret    
vs_set_vproc_l1:
    ldi r16, hi8(_PAL_CYCLES_VERT_SYNC_LONG)
    sts OCR1AH, r16
    ldi r16, lo8(_PAL_CYCLES_VERT_SYNC_LONG)
    sts OCR1AL, r16
    clr r24
    ldi ZL, pm_lo8(vproc_l1)
    ldi ZH, pm_hi8(vproc_l1)    
    ret

main:
    ; setup stack pointer
    ldi r16, lo8(RAMEND)
    out SPL, r16
    ldi r16, hi8(RAMEND)
    out SPH, r16

    ; first active handler is for vertical sync 
    ldi ZL, pm_lo8(vproc_l1)
    ldi ZH, pm_hi8(vproc_l1)

    ; r24 always saves current scanline
    clr r24
    clr r25 ; scratch register for scanline calculation

    ; initialize video sync pin
    ldi r16, 0xFF
    out DDRD, r16   ; D.5 => AD725.HSYNC
    out _VDATA_DDR_, r16   ; C.7, C.6 => VLOCK, BLANK
    out DDRB, r16   ; B.0 => Address-Counter.CLK

    ldi r16, 0
    out PORTD, r16
    out PORTB, r16

    ldi r16, _VDATA_BLANK_    ; deactivate VLOCK, activate BLANK
    out _VDATA_PORT_, r16 

    ; initialize video timings
    ldi r16, COM1A1 | COM1A0 | WGM11     ; for Fast PWM, clear OC1A at BOTTOM
                                                        ; set OC1A at Compare Match
    sts TCCR1A, r16
    
    ldi r16, WGM13 | WGM12 | CS10        ; Waveform Generation Mode 14 (Top = ICRn, Update 
                                                        ; OCR1A at bottom, Fast PWM
                                                        ; no prescaling, use clock as IO clock
    sts TCCR1B, r16

    ldi r16, hi8(_PAL_CYCLES_SCAN_LINE_FULL)
    sts ICR1H, r16
    ldi r16, lo8(_PAL_CYCLES_SCAN_LINE_FULL)
    sts ICR1L, r16
    
    ldi r16, hi8(_PAL_CYCLES_VERT_SYNC_LONG)
    sts OCR1AH, r16
    ldi r16, lo8(_PAL_CYCLES_VERT_SYNC_LONG)
    sts OCR1AL, r16

    ldi r16, TOIE1   ; timer1 overflow interrupt enable
    sts TIMSK1, r16

    ldi r20, _VDATA_LOCK_ | _VDATA_BLANK_
    out _VDATA_PORT_, r20
    ; enable interrupts
    sei

l1:
    nop
    nop    
    rjmp l1
