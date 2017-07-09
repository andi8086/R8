.segment "EXTRA" 
.export serial_getc_echo
.export serial_putc

    
    IO_BASE           = $8000
    ACIA1_BASE        = IO_BASE + $40
    ACIA1_DAT         = ACIA1_BASE + 0
    ACIA1_STAT        = ACIA1_BASE + 1
    ACIA1_CMD         = ACIA1_BASE + 2
    ACIA1_CTL         = ACIA1_BASE + 3

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

