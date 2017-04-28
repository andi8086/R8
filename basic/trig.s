.segment "BASCODE"

SIN_COS_TAN_ATN:
; ----------------------------------------------------------------------------
; "COS" FUNCTION
; ----------------------------------------------------------------------------
COS:
        lda     #<CON_PI_HALF
        ldy     #>CON_PI_HALF
        jsr     FADD

; ----------------------------------------------------------------------------
; "SIN" FUNCTION
; ----------------------------------------------------------------------------
SIN:
        jsr     COPY_FAC_TO_ARG_ROUNDED
        lda     #<CON_PI_DOUB
        ldy     #>CON_PI_DOUB
        ldx     ARGSIGN
        jsr     DIV
        jsr     COPY_FAC_TO_ARG_ROUNDED
        jsr     INT
        lda     #$00
        sta     STRNG1
        jsr     FSUBT
; ----------------------------------------------------------------------------
; (FAC) = ANGLE AS A FRACTION OF A FULL CIRCLE
;
; NOW FOLD THE RANGE INTO A QUARTER CIRCLE
;
; <<< THERE ARE MUCH SIMPLER WAYS TO DO THIS >>>
; ----------------------------------------------------------------------------
        lda     #<QUARTER
        ldy     #>QUARTER
        jsr     FSUB
        lda     FACSIGN
        pha
        bpl     SIN1
        jsr     FADDH
        lda     FACSIGN
        bmi     L3F5B
        lda     CPRMASK
        eor     #$FF
        sta     CPRMASK
; ----------------------------------------------------------------------------
; IF FALL THRU, RANGE IS 0...1/2
; IF BRANCH HERE, RANGE IS 0...1/4
; ----------------------------------------------------------------------------
SIN1:
        jsr     NEGOP
; ----------------------------------------------------------------------------
; IF FALL THRU, RANGE IS -1/2...0
; IF BRANCH HERE, RANGE IS -1/4...0
; ----------------------------------------------------------------------------
L3F5B:
        lda     #<QUARTER
        ldy     #>QUARTER
        jsr     FADD
        pla
        bpl     L3F68
        jsr     NEGOP
L3F68:
        lda     #<POLY_SIN
        ldy     #>POLY_SIN
        jmp     POLYNOMIAL_ODD

; ----------------------------------------------------------------------------
; "TAN" FUNCTION
;
; COMPUTE TAN(X) = SIN(X) / COS(X)
; ----------------------------------------------------------------------------
TAN:
        jsr     STORE_FAC_IN_TEMP1_ROUNDED
        lda     #$00
        sta     CPRMASK
        jsr     SIN
        ldx     #TEMP3
        ldy     #$00
        jsr     GOMOVMF
        lda     #TEMP1+(5-BYTES_FP)
        ldy     #$00
        jsr     LOAD_FAC_FROM_YA
        lda     #$00
        sta     FACSIGN
        lda     CPRMASK
        jsr     TAN1
        lda     #TEMP3
        ldy     #$00
        jmp     FDIV
TAN1:
        pha
        jmp     SIN1

; ----------------------------------------------------------------------------
CON_PI_HALF:
        .byte   $81,$49,$0F,$DB
CON_PI_DOUB:
        .byte   $83,$49,$0F,$DB
QUARTER:
        .byte   $7F,$00,$00,$00
POLY_SIN:
        .byte   $04,$86,$1E,$D7,$FB,$87,$99,$26
        .byte   $65,$87,$23,$34,$58,$86,$A5,$5D
        .byte   $E1,$83,$49,$0F,$DB
; ASCII encoded easter egg
MICROSOFT:
        .byte   $A6,$D3,$C1,$C8,$D4,$C8,$D5,$C4
        .byte   $CE,$CA

; ----------------------------------------------------------------------------
; "ATN" FUNCTION
; ----------------------------------------------------------------------------
ATN:
        lda     FACSIGN
        pha
        bpl     L3FDB
        jsr     NEGOP
L3FDB:
        lda     FAC
        pha
        cmp     #$81
        bcc     L3FE9
        lda     #<CON_ONE
        ldy     #>CON_ONE
        jsr     FDIV
; ----------------------------------------------------------------------------
; 0 <= X <= 1
; 0 <= ATN(X) <= PI/8
; ----------------------------------------------------------------------------
L3FE9:
        lda     #<POLY_ATN
        ldy     #>POLY_ATN
        jsr     POLYNOMIAL_ODD
        pla
        cmp     #$81
        bcc     L3FFC
        lda     #<CON_PI_HALF
        ldy     #>CON_PI_HALF
        jsr     FSUB
L3FFC:
        pla
        bpl     L4002
        jmp     NEGOP
L4002:
        rts

; ----------------------------------------------------------------------------
POLY_ATN:
        .byte   $08
		.byte	$78,$3A,$C5,$37
		.byte	$7B,$83,$A2,$5C
		.byte	$7C,$2E,$DD,$4D
		.byte	$7D,$99,$B0,$1E
		.byte	$7D,$59,$ED,$24
		.byte	$7E,$91,$72,$00
		.byte	$7E,$4C,$B9,$73
		.byte	$7F,$AA,$AA,$53
		.byte	$81,$00,$00,$00

.if .def(CONFIG_11A) && (!.def(CONFIG_2))
		.byte	$00 ; XXX
.endif
