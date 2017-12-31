    .SETCPU "6502"
    .SEGMENT "INITCODE"

    .import XModem
    .export ZPG_STRPOINTER
    .export serial_putc
    .export _serial_puts
    .export serial_puts
    .export serial_getc
    .export serial_getc_echo
    .export kernal_clall
    .export rga_clrscr

    .import wozmon_start

    .import cbmbasic2_start

    .include "zp.inc"
    .include "system.inc"


__init:             SEI             ; disable interrupts
                    CLD
                    LDX #$FF    ; strange errors with S starting at FF...
                    TXS             ; initialize stack pointer
                    JSR _init_SYSCTRL
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

_init_SYSCTRL:
    ;----------------------------------------------
    ; Initialize system control ports
    ;----------------------------------------------
                    LDA #$7F
                    STA SYSCTRL_DDRA
                    RTS

serial_puts:
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

printn:
                    LDA #0
                    TAY
printn2:
                    LDA (ZPG_STRPOINTER),Y
                    JSR serial_putc
                    INY
                    DEX
                    BNE printn2
                    RTS
    ;----------------------------------------------
    ; KERNAL FILE I/O: LOAD FILE
    ;
    ; file name in (A) (A = ZP offset of str pointer)
    ; X = length of filename
    ;----------------------------------------------
kernal_load_file:   ; do not scramble zeropage!
                    ; this function is also called from BASIC
                    LDA #0
                    TAY
                    CPX #2   ; file name only one char?
                    BNE lf_cont
                    LDA #'$'
                    CMP (ZPG_STRPOINTER),Y   ; is it a $?
                    BNE lf_cont
                    JMP kernal_disk_index    ; load disk index
lf_cont:
                    LDA ZPG_STRPOINTER
                    PHA
                    LDA ZPG_STRPOINTER+1
                    PHA
                    LDA #<loadmsg
                    STA ZPG_STRPOINTER
                    LDA #>loadmsg
                    STA ZPG_STRPOINTER+1
                    JSR _serial_puts
                    PLA
                    STA ZPG_STRPOINTER+1
                    PLA
                    STA ZPG_STRPOINTER
                    JSR printn
                    SEC  ; set carry flag to signal load error
                    RTS

kernal_disk_index:
                    LDA #<loadidxmsg
                    STA ZPG_STRPOINTER
                    LDA #>loadidxmsg
                    STA ZPG_STRPOINTER+1
                    JSR _serial_puts
                    CLC ; simulate success
                    RTS

kernal_clall:

                    RTS

    ;----------------------------------------------
    ; KERNAL RGA Synchronize with video controller
    ;
    ; Wait until video is locked and then wait
    ; until video is unlocked
    ;----------------------------------------------
rga_waitsync:
                    BIT SYSCTRL_A
                    BPL rga_waitsync
rga_waitnolock:     BIT SYSCTRL_A
                    BMI rga_waitnolock
		    RTS

    ;----------------------------------------------
    ; KERNAL RGA clear screen
    ;
    ; Fill screen with BKCOLOR
    ;----------------------------------------------
rga_clrscr:
                    LDX #3              ; start with video bank 3
                    STX RGA_CURBANK
                    LDA RGA_BKCOLOR
rga_clrscr_nextpage:
                    LDX RGA_CURBANK
                    STX SYSCTRL_A       ; set video bank

                    LDX #$9F            ; stop if high address is below A0

                    LDY #$00
                    STY RGA_VIDPOINTER
                    LDY #$BF
                    STY RGA_VIDPOINTER+1
                    LDY #$FF            ; Use (ZP),Y adressing mode

rga_clrscr_sync:
                    JSR rga_waitsync    ; wait for video unlocked

rga_clrscr_loop:
                    STA (RGA_VIDPOINTER), Y ; store pixel
                    DEY
                    CPY #$FF            ; 256 pixels written?
                    BNE rga_clrscr_loop ; no, continue
                    DEC RGA_VIDPOINTER+1; yes, decrease high address
                    CPX RGA_VIDPOINTER+1; below $A000?
                    BNE rga_clrscr_sync ; no, continue
                    DEC RGA_CURBANK     ; yes, decrease bank
                    BPL rga_clrscr_nextpage ; and continue if bank >= 0
                    RTS
    
__nmi:
    NOP
    RTI

__irq:  ; IRQ or BRK happened
                    PLA
                    BIT $10     ; test B bit
                    PHA
                    BNE __irq_brk

                    RTI
__irq_brk:
        ; A BRK was executed
                    ;ASR         ; shift 
                    RTI

startmsg:
.byte $0A,$0D,"REICHEL R8",$0A,$0D,"6502 CPU @ 2 MHz",$0A,$0D,"32K RAM",$0A,$0D,$00
wozmonmsg:
.byte "MONITOR (c)1976 Steve Wozniak", $0A, $0D, "ADAPTED 2017 Andreas J. Reichel", $0A, $0D, $00
loadmsg:
.byte "Load File ",00
loadidxmsg:
.byte "Load Index",00

    .SEGMENT "STAMP"
    .byte "REICHEL R8"
    .SEGMENT "RESETVECTORS"
    .word __nmi
    .word __init
    .word __irq
