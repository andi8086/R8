    .SETCPU  "6502"
    .SEGMENT "OSCODE"

    .EXPORT FDIV10

    F0 = $90
    F1 = $94
    F2 = $98
FDIV10:             ; multiply with 0.1
                    ; argument is in F0
        LDY #3
        LDA F0+1    ; get argument mantissa
        BPL FDPOS   ; number is positive
        SEC
NEGNU:
        LDA F0,Y
        EOR #$FF    ; negate 
        ADC #0
        STA F1,Y
        DEY         ; as long as y > 0
        BNE NEGNU   ; neg next mant. byte
        JMP MULT01
FDPOS:
        LDA F0,Y
        STA F1,Y
        DEY
        BNE FDPOS
MULT01:
        LDY #3
        LDA F1,Y
        STA F2,Y
        DEY
        BNE MULT01+2  ; copy F1 to F2
        LDY #6
;************************** LOOP ****
MULTI:
        JSR SHIFTM2
        JSR MULTM2

        JSR SHIFTM2
        JSR SHIFTM2

        JSR SHIFTM2        
        JSR MULTM2

        DEY
        BNE MULTI     ; LOOP 6 TIMES
        
        SEC
        LDA F0
        SBC #4      ; subtract 4 from exponent
        STA F2      ; store exponent
        
        LDA F2+1
        
        AND #$80    ; carry from multi?
        BEQ MULOK   ; no, no correction

        CLC
        LDX #1
        PHP
ROR5:               ; shift all 24bit 
        PLP
        ROR F2,X
        INX
        PHP
        CPX #4
        BNE ROR5
        PLP
        INC F2      ; increase exponent
MULOK:  
        LDA F0+1
        BPL NUMPOS2     
        LDY #3
        SEC
NEGNUM2:
        LDA F2,Y
        EOR #$FF    ; negate 
        ADC #0
        STA F2,Y
        DEY         ; as long as y > 0 
        BNE NEGNUM2 ; neg next mant. byte
NUMPOS2:     
        RTS
        
SHIFTM2:
        CLC
        LDX #1
        PHP
ROR1:
        PLP
        ROR F1,X
        INX
        PHP 
        CPX #4
        BNE ROR1      ; SHIFT RIGHT
        PLP
        RTS
MULTM2:
        CLC
        LDX #3
MULT02:
        LDA F2,X
        ADC F1,X
        STA F2,X
        DEX        
        BNE MULT02    ; ADD
        RTS
