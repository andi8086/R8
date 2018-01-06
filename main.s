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
                    JSR rga_reset
 
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

    ;----------------------------------------------
    ; KERNAL INT MATHS: erg16 += x16 * y8
    ;
    ; (KM_ERG,KM_ERGHI) += (KM_X,KM_XHI) * KM_Y
    ; by "white flame", modified by me (last 7 lines)
    ;----------------------------------------------
kernal_multiply:
                    LDA #$00
                    TAY
                    BEQ km_enterLoop
km_doAdd:
                    CLC
                    ADC KM_X
                    TAX
                    TYA
                    ADC KM_XHI
                    TAY
                    TXA
km_loop:
                    ASL KM_X
                    ROL KM_XHI
km_enterLoop:  ; accumulating multiply entry point (enter with .A=lo, .Y=hi)
                    LSR KM_Y
                    BCS km_doAdd
                    BNE km_loop
                    CLC
                    ADC KM_ERG
                    STA KM_ERG
                    TYA
                    ADC KM_ERGHI
                    STA KM_ERGHI
                    RTS

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
                    LDA RGA_BGCOLOR
rga_clrscr_nextpage:
                    LDX RGA_CURBANK
                    STX SYSCTRL_A       ; set video bank

                    LDX #$9F            ; stop if high address is below A0
                    LDY #1
                    STY ZP_TMP
                    LDY #$BF
                    STY RGA_VIDPOINTER+1
                    LDY #$00            ; Use (ZP),Y adressing mode
                    STY RGA_VIDPOINTER
rga_clrscr_sync:
                    DEC ZP_TMP
                    BNE rga_clrscr_loop ; 6 times, we skip the sync wait, i.e.
                                        ; we call it all 16896 clocks approx
                    PHA
                    LDA #6
                    STA ZP_TMP
                    PLA
                    JSR rga_waitsync    ; wait for video unlocked
rga_clrscr_loop:
                    STA (RGA_VIDPOINTER), Y ; store pixel               ; 6 clocks
                    DEY                                                 ; 2 clocks
                                        ; 256 pixels written?
                    BNE rga_clrscr_loop ; no, continue                  ; 3 clocks
                                                                    ; --------------
                                                                    ;  x 256 = 2816 clocks
                    DEC RGA_VIDPOINTER+1; yes, decrease high address
                    CPX RGA_VIDPOINTER+1; below $A000?

                    BNE rga_clrscr_sync ; no, continue
                    DEC RGA_CURBANK     ; yes, decrease bank
                    BPL rga_clrscr_nextpage ; and continue if bank >= 0
                    RTS
    
    ;----------------------------------------------
    ; KERNAL RGA calculate ram offset
    ;
    ; Input: (RGA_VIDEOCOL) = column, (RGA_VIDEOROW) = row
    ; Output: (RGA_VIDPOINTER) = offset in bank (starting at $A000)
    ;         (RGA_CURBANK) = bank
    ;----------------------------------------------
rga_calc_ramoffset:
                    LDA RGA_VIDEOROW
                    STA KM_Y
                    LDA #$90
                    STA KM_X
                    LDA #$6
                    STA KM_XHI ; one character line has $690 bytes (210*8)
                    LDA #0
                    STA KM_ERG
                    STA KM_ERGHI
                    JSR kernal_multiply
                    LDA RGA_VIDEOCOL
                    STA KM_X
                    LDA #0
                    STA KM_XHI
                    STA RGA_CURBANK
                    LDA #6
                    STA KM_Y
                    JSR kernal_multiply ; erg = row * 1680 + col * 6
                    LDA KM_ERG
                    STA RGA_VIDPOINTER
                    LDA KM_ERGHI
rga_co_checkbank:
                    CMP #$20
                    BCS rga_co_incbank
                    ADC #$A0
                    STA RGA_VIDPOINTER+1
                    LDA RGA_CURBANK
                    STA SYSCTRL_A
                    RTS
rga_co_incbank:
                    SBC #$20
                    INC RGA_CURBANK
                    BNE rga_co_checkbank ; always true

    ;----------------------------------------------
    ; KERNAL RGA render char at current vidpointer
    ;
    ; Input: (RGA_VIDPOINTER) = offset in bank
    ;        (RGA_CURBANK) = bank
    ;        (RGA_FGCOLOR) = foreground color
    ;        (RGA_BGCOLOR) = background color
    ;        A = character code
    ;----------------------------------------------

rga_renderchar:
                    CLD
                    STA KM_X
                    LDX #$0
                    STX KM_XHI ; KM_X = ASCII extended to 16 bits
                    STX KM_ERG ; low byte of result to 0
                    LDX #$CA   ; store character ROM page into high byte
                    STX KM_ERGHI
                    CLC
                    ASL KM_X    ; multiply KM_X by 2
                    ROL KM_XHI
                    LDA KM_X
                    STA KM_ERG  ; and add it to KM_ERG. Use STA since ERG_LO is 0
                    LDA KM_XHI
                                ; carry should be clear here
                    ADC KM_ERGHI
                    STA KM_ERGHI
                    ASL KM_X    ; multiply KM_X by 2 again
                    ROL KM_XHI
                                ; carry should be clear here
                    LDA KM_X
                    ADC KM_ERG  ; add KM_X to KM_ERG
                    STA KM_ERG
                    LDA KM_XHI
                    ADC KM_ERGHI
                    STA KM_ERGHI
                                ; (KM_ERG) = $CA00 + A * 6;
                    LDA #$80
                    STA ZP_TMP  ; init bitmask
                    LDA #0      ; Initialize Y-Counter
loopy:
                      PHA       ; save Y-Counter
                      LDY #0    ; init index into bitmask, which is the pixel-column
loopx:
                        LDA (KM_ERG),Y  ; load character pattern
                        BIT ZP_TMP      ; test pattern against bitmask
                        PHP         ; save result flags
                        LDA RGA_FGCOLOR
                        PLP         ; restore result flags
                        BNE drawfg  ; skip if bit was set
                        LDA RGA_BGCOLOR ; draw background instead
drawfg:
                        LDX #0
                        STA (RGA_VIDPOINTER,X) ; store to VRAM
                        LDX #$BF
                        INC RGA_VIDPOINTER   ; increase VRAM offset
                        BNE incvoffs1 ; if overflow, increase high byte
                        INC RGA_VIDPOINTER+1
incvoffs1:
                        CPX RGA_VIDPOINTER+1 ; check for bank overrun
                        BCS stay_in_bank ; if X >= (VOFFS+1), no bank overrun and
                                         ; carry set. Else carry clear.
                        LDA RGA_VIDPOINTER+1
                        SBC #$21   ; A = A - M - (C - 1). Since carry is cleared
                                   ; this subtracts $20
                        STA RGA_VIDPOINTER+1
                        INC RGA_CURBANK
                        LDA RGA_CURBANK
                        STA $8001
stay_in_bank:
                        INY
                        CPY #6
                        BMI loopx ; loop if Y < 6
                      LSR ZP_TMP  ; C should be clear afterwards
                      LDA RGA_VIDPOINTER
                      ADC #204
                      STA RGA_VIDPOINTER
                      LDA RGA_VIDPOINTER+1
                      ADC #0
                      CMP #$C0  ;if A >= $C0, C flag is set
                      BCC stay_in_bank2
                        ; carry is set here. This works the other way arround than
                        ; the compare above. Here the limit is the operand, above
                        ; the value is the operand.
                      SBC #$20
                      INC RGA_CURBANK
                      LDY RGA_CURBANK
                      STY $8001
stay_in_bank2:
                      STA RGA_VIDPOINTER+1 ; store modified high byte for addition
                             ; and correction
                      PLA ; restore Y-Counter
                      TAY
                      INY ; increase Y-Counter and transfer to A
                      TYA
                      CPY #8 ; Continue if Y-Counter < 8
                      BMI loopy

                    RTS
    
    ;----------------------------------------------
    ; KERNAL RGA reset
    ; Set Background color to 0, Foreground color
    ; to FF, Current Column and Row to 0
    ;
    ; Input: None
    ;----------------------------------------------
rga_reset:
                    LDA #0
                    STA RGA_BGCOLOR
                    STA RGA_VIDEOROW
                    STA RGA_VIDEOCOL
                    LDA #$FF
                    STA RGA_FGCOLOR
                    RTS

    ;----------------------------------------------
    ; KERNAL RGA put character 
    ; Output a character with current attributes 
    ; at current row and current column.
    ; Increase column and goto next line if needed
    ; also scroll screen up if full.
    ;
    ; Input: None
    ;----------------------------------------------
rga_putc:
                    PHA
                    JSR rga_calc_ramoffset
                    PLA
                    JSR rga_renderchar
                    INC RGA_VIDEOCOL
                    LDA RGA_VIDEOCOL
                    CMP #34
                    BPL row_okay
                    LDA #0
                    STA RGA_VIDEOCOL
                    INC RGA_VIDEOROW
                    LDA RGA_VIDEOROW
                    CMP #18
                    BPL row_okay
                    DEC RGA_VIDEOROW
                    JSR rga_scrollup
row_okay:
                    RTS

    ;----------------------------------------------
    ; KERNAL RGA scroll up screen 
    ;
    ; Input: None
    ;----------------------------------------------
rga_scrollup:
                    LDA #$A6                    ; Initialize pointer to row 1
                    STA RGA_VIDPOINTER+1
                    LDA #$90
                    STA RGA_VIDPOINTER
                    LDA #0
                    STA ZP_TMP
                    STA RGA_CURBANK
                    STA ZP_BANKTMP
                    LDA #$A0
                    STA ZP_TMP+1                ; RGA_VIDPOINTER is SRC, ZP_TMP is DST
                    LDY #0
                    LDX #8
                    JSR rga_waitsync
scroll_line_up:
                    LDA RGA_CURBANK             ; 3 cycles
                    STA $8001                   ; 3 cycles
                    LDA (RGA_VIDPOINTER),Y      ; 6 cycles
                    PHA                         ; 3 cycles
                    LDA ZP_BANKTMP              ; 3 cycles
                    STA $8001                   ; 3 cycles
                    PLA                         ; 4 cycles
                    STA (ZP_TMP),Y              ; 6 cycles
                    DEY                         ; 2 cycles
                    BNE scroll_line_up          ; 3 cycles
                                                ;---- 36 cycles * 210 = 7560
                    INC RGA_VIDPOINTER+1
                    LDA RGA_VIDPOINTER+1
                    CMP #$C0
                    BMI scrollup_skip_bank1adjust
                    SBC #$20
                    STA RGA_VIDPOINTER+1
                    INC RGA_CURBANK
                    LDA RGA_CURBANK
                    CMP #4
                    BPL end_scrollup
                    SEC
scrollup_skip_bank1adjust:
                    INC ZP_TMP+1
                    LDA ZP_TMP+1
                    CMP #$C0
                    BMI scrollup_skip_bank2adjust
                    SBC #$20
                    STA ZP_TMP+1
                    INC ZP_BANKTMP
scrollup_skip_bank2adjust:
                    TXA
                    LSR
                    BCS scroll_line_up_nosync   ; skip every other time, i.e.
                    JSR rga_waitsync            ; call every 16000 cycles approx
scroll_line_up_nosync:
                    DEX
                    SEC
                    BCS scroll_line_up
end_scrollup:
                    LDA #0
                    STA RGA_CURBANK
                    RTS



kernal_test_chars:
                    LDA #255
                    LDX #18
                    STX RGA_VIDEOROW
                    JSR rga_waitsync
row_loop:
                    LDX #34
                    STX RGA_VIDEOCOL
col_loop:
                    STA $3E
                    PHA
                    JSR rga_calc_ramoffset
                    PLA
                    PHA
                    EOR $FF
                    STA $3F
                    PLA
                    PHA
                    JSR rga_renderchar
                    PLA
                    SEC
                    SBC #1
                    PHA
                    LDA RGA_VIDEOCOL
                    LSR
                    BCS tc_nosyncwait; if one of last two bits is set, skip sync wait
                    LSR
                    BCS tc_nosyncwait; i.e. all 4 characters
		    JSR rga_waitsync
tc_nosyncwait:
		    PLA
	            DEC RGA_VIDEOCOL
		    BPL col_loop
                    DEC RGA_VIDEOROW
                    BPL row_loop
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
