.segment "BASCODE"

; .import kernal_load_file
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
        lda     INDEX
        sta     $20
        lda     INDEX+1
        sta     $21             ; store string pointer for kernal
;        jsr     kernal_load_file
        bcc     NOLOADERR
        ldx     #ERR_NODATA
        jsr     ERROR
NOLOADERR:
        jsr     CHRGOT

LOADEND:
        rts
