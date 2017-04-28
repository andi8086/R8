.segment "BASCODE"

; ----------------------------------------------------------------------------
; "LOAD" STATEMENT
; ----------------------------------------------------------------------------
LOAD:
        jeq     SYNERR4
LOAD2:
        beq     LOADEND
        jsr     FRMEVL
        bit     VALTYP
        jpl     SYNERR4
; ----------------------------------------------------------------------------
; LOAD STRING AT (FACMO,FACLO)
; ----------------------------------------------------------------------------
LSTRPRT:
        jsr     FREFAC          ; A contains length of string
        tax                     ; INDEX points to string
        ldy     #$00            ; 
        inx                     ; now X can be decreased until zero,
                                ; and with increasing Y,
                                ; (INDEX),Y is the letter of the string
       ; jsr KERNAL_LOAD_FILE 
        jsr     CHRGOT
LOADEND:
        rts

;LL2A22:
;        dex
;        beq     LOADEND 
;        lda     (INDEX),y
;        jsr     LOUTDO
;        iny
;        cmp     #$0D
;        beq     LOADEND
;        jmp     LL2A22

; ----------------------------------------------------------------------------
; LOAD CHAR FROM (A)
; ----------------------------------------------------------------------------
;LOUTDO:
;        bit     Z14
;        bmi     LL2A56
;.ifdef CONFIG_MONCOUT_DESTROYS_Y
;        sty     DIMFLG
;.endif
;        jsr     MONCOUT
;.ifdef CONFIG_MONCOUT_DESTROYS_Y
;        ldy     DIMFLG
;.endif
;LL2A56:
;        and     #$FF
;        rts
