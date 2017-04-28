    .SETCPU "6502"
    .SEGMENT "INITCODE"

    .import XModem
    .export ZPG_STRPOINTER
    .export serial_putc
    .export _serial_puts
    .export serial_getc
    .export serial_getc_echo
    .import wozmon_start

    .import cbmbasic2_start

    ZPG_STRPOINTER    = $20
    
    IO_BASE           = $8000
    ACIA1_BASE        = IO_BASE + $40
    ACIA1_DAT         = ACIA1_BASE + 0
    ACIA1_STAT        = ACIA1_BASE + 1
    ACIA1_CMD         = ACIA1_BASE + 2
    ACIA1_CTL         = ACIA1_BASE + 3

__init:             SEI             ; disable interrupts
                    CLD
                    LDX #$A8    ; strange errors with S starting at FF...
                    TXS             ; initialize stack pointer
                    JSR _init_6551
                    
                    LDA #< startmsg
                    STA ZPG_STRPOINTER
                    LDA #> startmsg
                    STA ZPG_STRPOINTER+1
                    JSR _serial_puts
                   
                    LDA #< wozmonmsg
                    STA ZPG_STRPOINTER
                    LDA #> wozmonmsg
                    STA ZPG_STRPOINTER+1
                    JSR _serial_puts
endlessloop:
                    
                    JSR wozmon_start

                    ; Execution should never reach this point
                    JMP endlessloop           ; endless loop
  
       
_init_6551:
    ;----------------------------------------------
    ; Initialize ACIA chip 1
    ;----------------------------------------------
    
                    LDA #$1F        ; 1 stop bit, 8 data bits, 19200 bps
                    STA ACIA1_CTL
   
                    LDA #$0B        ; no parity, no echo, no TX ints, 
                    ; RTS low, no RX ints, DTR low
                    STA ACIA1_CMD    
                    RTS

_serial_puts:
    ;----------------------------------------------
    ; send a 0-terminated ASCII string via 6551 ACIA
    ;   Pointer to String is stored in $0020:$0021
    ;   maximum length is 255 characters
    ;----------------------------------------------
                    LDY #0
_serial_puts_next:  LDA (ZPG_STRPOINTER),Y
                    BEQ _serial_puts_end
                    JSR serial_putc
                    INY
                    BNE _serial_puts_next
_serial_puts_end:   RTS                     
                     
serial_putc:
    ;----------------------------------------------
    ; send a character via 6551 ACIA
    ;----------------------------------------------
                    PHA
                    LDA #$10
_tx_full:           BIT ACIA1_STAT
                    BEQ _tx_full
                    PLA
                    STA ACIA1_DAT
                    RTS

serial_getc:        LDA #$08
_serial_getc1:      BIT ACIA1_STAT
                    BEQ _serial_getc1
                    LDA ACIA1_DAT
                    RTS

serial_getc_echo:   JSR serial_getc
                    JSR serial_putc
                    RTS

.SEGMENT "OSCODE"

.export kernal_load_file

    ;----------------------------------------------
    ; KERNAL FILE I/O: LOAD FILE
    ;
    ; file name in (A) (A = ZP offset of str pointer)
    ; X = length of filename
    ;----------------------------------------------
kernal_load_file:   ; do not scramble zeropage!
                    ; this function is also called from BASIC



                    RTS

__nmi:
    NOP
    RTI

__irq:
    NOP
    RTI

startmsg:
.byte $0A,$0D,"REICHEL R8",$0A,$0D,"6502 CPU @ 2 MHz",$0A,$0D,"32K RAM",$0A,$0D,$00
wozmonmsg:
.byte "MONITOR (c)1976 Steve Wozniak", $0A, $0D, "ADAPTED 2017 Andreas J. Reichel", $0A, $0D, $00



    .SEGMENT "STAMP"
    .byte "REICHEL R8"
    .SEGMENT "RESETVECTORS"
    .word __nmi
    .word __init
    .word __irq
