.segment "BASCODE"

LPRSTRING:
        jsr     LSTRPRT
LL297E:
        jsr     CHRGOT

; ----------------------------------------------------------------------------
; "LOAD" STATEMENT
; ----------------------------------------------------------------------------
LOAD:
        beq     LCRDO
LOAD2:
        beq     LL29DD
        cmp     #TOKEN_TAB
        beq     LL29F5
        cmp     #TOKEN_SPC
        clc	                ; also AppleSoft II
        beq     LL29F5
        cmp     #','
        beq     LL29DE
        cmp     #$3B
        beq     LL2A0D
        jsr     FRMEVL
        bit     VALTYP
        bmi     LPRSTRING
        jsr     FOUT
        jsr     STRLIT
        ldy     #$00
        lda     (FAC_LAST-1),y
        clc
        adc     POSX
        cmp     Z17
        bcc     LL29B1
        jsr     LCRDO
LL29B1:
        jsr     LSTRPRT
        jsr     LOUTSP
        bne     LL297E ; branch always

LL29B9:
        lda     #$00
        sta     INPUTBUFFER,x
        ldx     #<(INPUTBUFFER-1)
        ldy     #>(INPUTBUFFER-1)

LCRDO:
        lda     #CRLF_1
        jsr     LOUTDO
LCRDO2:
        lda     #CRLF_2
        jsr     LOUTDO

LOADNULLS:
        eor     #$FF
LL29DD:
        rts
LL29DE:
        lda     POSX
        cmp     Z18
        bcc     LL29EA
        jsr     CRDO
        jmp     LL2A0D
LL29EA:
        sec
LL29EB:
        sbc     #$0A
        bcs     LL29EB
        eor     #$FF
        adc     #$01
        bne     LL2A08
LL29F5:
        php
        jsr     GTBYTC
        cmp     #')'
        jne     SYNERR4
        plp
        bcc     LL2A09
        txa
        sbc     POSX
        bcc     LL2A0D
LL2A08:
        tax
LL2A09:
        inx
LL2A0A:
        dex
        bne     LL2A13
LL2A0D:
        jsr     CHRGET
        jmp     LOAD2
LL2A13:
        jsr     OUTSP
        bne     LL2A0A

; ----------------------------------------------------------------------------
; LOAD STRING AT (Y,A)
; ----------------------------------------------------------------------------
LSTROUT:
        jsr     STRLIT

; ----------------------------------------------------------------------------
; LOAD STRING AT (FACMO,FACLO)
; ----------------------------------------------------------------------------
LSTRPRT:
        jsr     FREFAC
        tax
        ldy     #$00
        inx
LL2A22:
        dex
        beq     LL29DD
        lda     (INDEX),y
        jsr     LOUTDO
        iny
        cmp     #$0D
        bne     LL2A22
        jsr     LOADNULLS
        jmp     LL2A22
; ----------------------------------------------------------------------------
LOUTSP:
        lda     #$20
        .byte   $2C
LOUTQUES:
        lda     #$3F

; ----------------------------------------------------------------------------
; LOAD CHAR FROM (A)
; ----------------------------------------------------------------------------
LOUTDO:
        bit     Z14
        bmi     LL2A56
LLCA6A:
LL2A4E:
.ifdef CONFIG_MONCOUT_DESTROYS_Y
        sty     DIMFLG
.endif
        jsr     MONCOUT
.ifdef CONFIG_MONCOUT_DESTROYS_Y
        ldy     DIMFLG
.endif
LL2A56:
        and     #$FF
LLE8F2:
        rts

LOADMSG: .byte "load called",CR,LF,0
