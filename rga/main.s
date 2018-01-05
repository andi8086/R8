; ***********************************  REICHEL R8   *************************************
; *               V I D E O     C O N T R O L L E R    F I R M W A R E                  *
; *                                      v 1.0                                          *
; *                          (c) 2016 Andreas J. Reichel                                *
; *                                                                                     *
; *  Target Device: Atmega 1248(P)                                                      *
; *                                                                                     *
; *  Used I/O Pins:                                                                     *
; *       B1 - HSYNC to AD725 Video Encoder                                             *
; *       D0 - CLOCK to RAMDAC Address Counter                                          *
; *       C5 - Reset RAMDAC Address Counter                                             *
; *       C1 - Video Lock Signal (VLOCK)                                                *
; *       C0 - Video Blank (BLANK)                                                      *
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
; *             D5 - HSYNC   - B1 (OC1A)                                                *
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
.equ _CPU_CYCLES_PER_MUSEC,   22

.equ _PAL_TIME_SCANLINE,      64  ; µs
; .equ _PAL_TIME_HSYNC,        4.7
; .equ _PAL_TIME_VSYNC,       58.85

.equ _PAL_CYCLES_SCAN_LINE, 1407
.equ _PAL_CYCLES_VERT_SYNC, 1200  ; (_PAL_TIME_VSYNC * _CPU_CYCLES_PER_MUSEC - 1)
.equ _PAL_CYCLES_HORIZ_SYNC, 103  ; (_PAL_TIME_HSYNC * _CPU_CYCLES_PER_MUSEC - 1) ; 4.72 µs


; Frame structure constants
.equ _LINE_STOP_VSYNC_L1,      6
.equ _LINE_BLANK1_END,        52
.equ _LINE_SCREEN_END,       208
.equ _LINE_SCREEN_END2,       50
.equ _LINE_FRAME_END,        311

; Control Signals
.equ _VDATA_DDR_,           DDRC
.equ _VDATA_PORT_,         PORTC
.equ _VDATA_RESET_,           32
.equ _VDATA_LOCK_,             2
.equ _VDATA_BLANK_,            1

defaultInt:
    reti

vidIntHandler:
    icall                                  ; r30:r31 points to active scanline handler
    reti

; *********************************** VIDEO HANDLER *************************************
; VSYNC HALF LINES, LONG SYNC, 0-7
; ***************************************************************************************
vproc_l1:
    inc r24                                ; this function starts with r24 = 0..7
    cpi r24, _LINE_STOP_VSYNC_L1
    breq vs_set_vproc_b
    ret
vs_set_vproc_b:
    ldi r16, hi8(_PAL_CYCLES_HORIZ_SYNC)
    sts OCR1AH, r16
    ldi r16, lo8(_PAL_CYCLES_HORIZ_SYNC)
    sts OCR1AL, r16
                                           ; switch interrupt handler
    ldi ZL, pm_lo8(bproc)
    ldi ZH, pm_hi8(bproc)
    ret

; *********************************** VIDEO HANDLER *************************************
; HSYNC BLANK LINES 5 -- 23 [0 -- 18]
; ***************************************************************************************
bproc:
    inc r24
    cpi r24, _LINE_BLANK1_END
    breq vs_set_dproc
    ret
vs_set_dproc:
    ldi ZL, pm_lo8(dproc)
    ldi ZH, pm_hi8(dproc)

    ldi r18, _VDATA_BLANK_ | _VDATA_LOCK_ | _VDATA_RESET_ 
    out _VDATA_PORT_, r18                  ; reset RAMDAC Address counter
    nop
    nop 
    ldi r18, _VDATA_BLANK_ | _VDATA_LOCK_
    out _VDATA_PORT_, r18
    ldi r22, 0
    ret

; *********************************** VIDEO HANDLER *************************************
; VISIBLE LINES 24 -- 179 (156 lines in resolution) [19 -- 174]
; ***************************************************************************************
dproc:
    inc r24
    cpi r24, _LINE_SCREEN_END
    breq vs_set_b2proc
    ldi r18, 0
    ldi r19, 1
    ldi r17, 78 
dproc_delayfirstpixel:
    dec r17
    brne dproc_delayfirstpixel
    ldi r20, _VDATA_LOCK_                  ; VLOCK, not BLANK
    ldi r17, 210                           ; there are 210 pixels in each line, 
                                           ; count from 210 to 1
    out _VDATA_PORT_, r20                  ; activate VLOCK, deactivate BLANK
dproc_nextpixel:
    out PORTD, r18                         ; counter clock pin down
    dec r17
    out PORTD, r19                         ; counter clock pin up
    brne dproc_nextpixel                   ; if we are on last pixel, do not loop back
    nop

    ldi r20, _VDATA_BLANK_
    out _VDATA_PORT_, r20                  ; set BLANK
    ret
vs_set_b2proc:
    clr r24                                ; clear counter for blank
    ldi ZL, pm_lo8(b2proc)
    ldi ZH, pm_hi8(b2proc)

    ldi r20, _VDATA_BLANK_ | _VDATA_RESET_ ; set BLANK and Address RESET
    out _VDATA_PORT_, r20                  ; allow CPU access
    ret

; *********************************** VIDEO HANDLER *************************************
;  HSYNC BLANK LINES 175 -- 309 [0 -- 134]
; ***************************************************************************************
b2proc:
    inc r24
    cpi r24, (_LINE_FRAME_END - _LINE_SCREEN_END)
    breq vs_set_vproc_s2
    ret    
vs_set_vproc_s2:
    ldi r16, hi8(_PAL_CYCLES_VERT_SYNC)
    sts OCR1AH, r16
    ldi r16, lo8(_PAL_CYCLES_VERT_SYNC)
    sts OCR1AL, r16
    clr r24
    ldi ZL, pm_lo8(vproc_l1)
    ldi ZH, pm_hi8(vproc_l1)
    ret

; *********************************** SETUP CODE ** *************************************
;  MAIN
; ***************************************************************************************
main:
    ldi r16, lo8(RAMEND)                 ; setup stack pointer
    out SPL, r16
    ldi r16, hi8(RAMEND)
    out SPH, r16

    ldi ZL, pm_lo8(vproc_l1)             ; first active handler is for vertical sync 
    ldi ZH, pm_hi8(vproc_l1)

    clr r24                              ; r24 always saves current scanline
    clr r25                              ; scratch register for scanline calculation

    ldi r16, 0x01                        ; Initialize control pins
    out DDRD, r16                        ; D.0 => AD725.HSYNC
    ldi r16, 0x3F
    out _VDATA_DDR_, r16                 ; C.1, C.0 => VLOCK, BLANK
    ldi r16, 0x02
    out DDRB, r16                        ; B.1 => AD725.HSYNC

    ldi r16, 0
    out PORTD, r16
    out PORTB, r16

    ldi r16, _VDATA_BLANK_               ; activate BLANK, allow CPU access
    out _VDATA_PORT_, r16 

                                         ; initialize video timings
    ldi r16, COM1A1 | COM1A0 | WGM11     ; for Fast PWM, clear OC1A at BOTTOM
                                         ; set OC1A at Compare Match
    sts TCCR1A, r16

    ldi r16, WGM13 | WGM12 | CS10        ; Waveform Generation Mode 14 (Top = ICRn, Update 
                                         ; OCR1A at bottom, Fast PWM
                                         ; no prescaling, use clock as IO clock
    sts TCCR1B, r16

    ldi r16, hi8(_PAL_CYCLES_SCAN_LINE)
    sts ICR1H, r16
    ldi r16, lo8(_PAL_CYCLES_SCAN_LINE)
    sts ICR1L, r16

    ldi r16, hi8(_PAL_CYCLES_VERT_SYNC)
    sts OCR1AH, r16
    ldi r16, lo8(_PAL_CYCLES_VERT_SYNC)
    sts OCR1AL, r16

    ldi r16, TOIE1                       ; timer1 overflow interrupt enable
    sts TIMSK1, r16

    sei                                  ; enable interrupts and start video generation

l1:
    nop
    nop
    rjmp l1
