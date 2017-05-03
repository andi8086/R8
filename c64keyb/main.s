.include "m16def.inc"

; fuses: FF 99 E1   ; change to D9 to disable JTAG and use Port C


; ENDOFILL BOARD :D
;                            VCC
;                            GND
;                        GND
;
;
;             x  x   x   x
;
;                         RESET  
;          
;          MISO  MOSI SCK VCC
;
;
;
;            Atmega16L
;        
;           PC0      PD7
;           ..       ..
;           PC7      PD0


.org 0x00

Hreset:       jmp reset
HINT0addr:  jmp defIntHandler
HINT1addr:  jmp defIntHandler
HOC2addr:  jmp defIntHandler
HOVF2addr:  jmp defIntHandler
HICP1addr:  jmp defIntHandler
HOC1Aaddr:  jmp defIntHandler
HOC1Baddr:  jmp defIntHandler
HOVF1addr:  jmp defIntHandler
HOVF0addr:  jmp defIntHandler
HSPIaddr:  jmp defIntHandler
HURXCaddr:  jmp defIntHandler
HUDREaddr:  jmp defIntHandler
HUTXCaddr:  jmp defIntHandler
HADCCaddr:  jmp defIntHandler
HERDYaddr:  jmp defIntHandler
HACIaddr:  jmp defIntHandler
HTWIaddr:  jmp defIntHandler
HINT2addr:  jmp defIntHandler
HOC0addr:  jmp defIntHandler
HSPMRaddr:  jmp defIntHandler

reset:
    ldi r16, lo8(RAMEND)
    out SPL, r16
    ldi r16, hi8(RAMEND)
    out SPH, r16

    ldi r16, 0xFF
    out DDRD, r16   ; PORTD is col output
    out DDRA, r16   ; PORTA is key value output
    ldi r16, 0xFF
    out PORTC, r16  ; activate pull-ups
    ldi r16, 0x00
    out DDRC, r16   ; PORTC is row input
    ldi r16, 0x00   ; 
    out PORTA, r16


keyboard_scan_loop:
    ldi r21, 0      ; no shift key
    ldi r18, 0x7F   ; r17 always contains one zero on the active col
    ldi r19, 7
drive_cols:
        out PORTD, r18  ; set col active
        in r16, PINC   ; read row into r16
        ldi r17, 0
scan_bit:
            inc r17
            cpi r17, 9
            breq nokey
            sec
            ror r16
        brcs scan_bit   ; if the zero was not shifted into the carry,
                        ; we are not done
            cpi r19, 3
            brne not_left_shift
            cpi r17, 2
            brne not_left_shift
            ori r21, 1 ; left shift is pressed, set bit 1
            jmp scan_bit ; continue scanning if left shift is pressed
not_left_shift:
            cpi r19, 4
            brne not_control
            cpi r17, 1
            brne not_control
            ori r21, 2  ; control is pressed, set bit 2
            jmp scan_bit
not_control:
            cpi r19, 2
            brne not_right_shift
            cpi r17, 7
            brne not_right_shift
            ori r21, 1 ; right shift is pressed, set bit 1
            jmp scan_bit
not_right_shift:
        dec r17
        lsl r17
        lsl r17
        lsl r17
        or r19,r17     ; build scancode = (col<<3 | row)
        ldi ZH, hi8(scantable)
        ldi ZL, lo8(scantable)
        add ZL, r19
        brcc indexok
        inc ZH
indexok:sbrc r21,0     ; if bit 0 in r21 is not set skip next instr
        adiw Z, 63     ; goto shift table
        sbrc r21,0
        adiw Z, 1 
        
        lpm r0, Z
        mov r20, r0
        sbrc r21,1     ; if bit 1 in r21 is not set skip next instr
        ori r20, 0x80  ; set MSB if control key pressed
        out PORTA, r20  ; output current key value
nokey:
    dec r19
    sec
    ror r18
    brcs drive_cols
    jmp keyboard_scan_loop

loop:
    nop
    jmp loop


defIntHandler:

    reti

scantable:
; scan code 0x0B is left shift or caps lock and is mapped to zero
; scan code 0x32 is shift right and is treated identical to 0x0B
; scan code 0x04 is CONTROL

; shift switches to the lower table
; control sets bit 7

.byte 0x51,0x01,0x20,0x03,0x00,0x1B,0x31,0x32,0x45,0x53,0x5A,0x00,0x41,0x33,0x57,0x34
.byte 0x54,0x46,0x43,0x58,0x44,0x52,0x35,0x36,0x55,0x48,0x42,0x56,0x47,0x59,0x37,0x38
.byte 0x4F,0x4B,0x4D,0x4E,0x4A,0x49,0x39,0x30,0x40,0x3A,0x2E,0x2C,0x4C,0x50,0x2B,0x2D
.byte 0x1D,0x3D,0x00,0x2F,0x3B,0x2A,0x26,0x0B,0x15,0x13,0x11,0x04,0x05,0x0D,0x08,0x17

.byte 0x71,0x02,0x10,0x09,0x00,0x7F,0x21,0x22,0x65,0x73,0x7A,0x00,0x61,0x23,0x64,0x24
.byte 0x74,0x66,0x63,0x78,0x64,0x72,0x25,0x26,0x75,0x68,0x62,0x76,0x67,0x79,0x27,0x28
.byte 0x29,0x6B,0x6D,0x6E,0x6A,0x69,0x29,0x7C,0x7B,0x5B,0x3E,0x3C,0x6C,0x70,0x5E,0x5F
.byte 0x1E,0x5C,0x00,0x3F,0x5D,0x7D,0x7E,0x0C,0x16,0x14,0x12,0x06,0x07,0x0A,0x0E,0x18
 
