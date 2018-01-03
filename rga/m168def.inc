;***** THIS IS A MACHINE GENERATED FILE - DO NOT EDIT ********************
;***** Created: 2005-01-11 10:30 ******* Source: ATmega168.xml ***********
;*************************************************************************
;* A P P L I C A T I O N   N O T E   F O R   T H E   A V R   F A M I L Y
;* 
;* Number            : AVR000
;* File Name         : "m168def.inc"
;* Title             : Register/Bit Definitions for the ATmega168
;* Date              : 2005-01-11
;* Version           : 2.14
;* Support E-mail    : avr@atmel.com
;* Target MCU        : ATmega168
;* 
;* DESCRIPTION
;* When including this file in the assembly program file, all I/O register 
;* names and I/O register bit names appearing in the data book can be used.
;* In addition, the six registers forming the three data pointers X, Y and 
;* Z have been assigned names XL - ZH. Highest RAM address for Internal 
;* SRAM is also defined 
;* 
;* The Register names are represented by their hexadecimal address.
;* 
;* The Register Bit names are represented by their bit number (0-7).
;* 
;* Please observe the difference in using the bit names with instructions
;* such as "sbr"/"cbr" (set/clear bit in register) and "sbrs"/"sbrc"
;* (skip if bit in register set/cleared). The following example illustrates
;* this:
;* 
;* in    r16,PORTB             ;read PORTB latch
;* sbr   r16,(1<<PB6)+(1<<PB5) ;set PB6 and PB5 (use masks, not bit#)
;* out   PORTB,r16             ;output to PORTB
;* 
;* in    r16,TIFR              ;read the Timer Interrupt Flag Register
;* sbrc  r16,TOV0              ;test the overflow flag (use bit#)
;* rjmp  TOV0_is_set           ;jump if set
;* ...                         ;otherwise do something else
;*************************************************************************


; ***** SPECIFY DEVICE ***************************************************
;.device ATmega168
.equ	SIGNATURE_000	, 0x1e
.equ	SIGNATURE_001	, 0x94
.equ	SIGNATURE_002	, 0x06



; ***** I/O REGISTER DEFINITIONS *****************************************
; NOTE:
; Definitions marked "MEMORY MAPPED"are extended I/O ports
; and cannot be used with IN/OUT instructions
.equ	UDR0	, 0xc6	; MEMORY MAPPED
.equ	UBRR0H	, 0xc5	; MEMORY MAPPED
.equ	UBRR0L	, 0xc4	; MEMORY MAPPED
.equ	UCSR0C	, 0xc2	; MEMORY MAPPED
.equ	UCSR0B	, 0xc1	; MEMORY MAPPED
.equ	UCSR0A	, 0xc0	; MEMORY MAPPED
.equ	TWAMR	, 0xbd	; MEMORY MAPPED
.equ	TWCR	, 0xbc	; MEMORY MAPPED
.equ	TWDR	, 0xbb	; MEMORY MAPPED
.equ	TWAR	, 0xba	; MEMORY MAPPED
.equ	TWSR	, 0xb9	; MEMORY MAPPED
.equ	TWBR	, 0xb8	; MEMORY MAPPED
.equ	ASSR	, 0xb6	; MEMORY MAPPED
.equ	OCR2B	, 0xb4	; MEMORY MAPPED
.equ	OCR2A	, 0xb3	; MEMORY MAPPED
.equ	TCNT2	, 0xb2	; MEMORY MAPPED
.equ	TCCR2B	, 0xb1	; MEMORY MAPPED
.equ	TCCR2A	, 0xb0	; MEMORY MAPPED
.equ	OCR1BH	, 0x8b	; MEMORY MAPPED
.equ	OCR1BL	, 0x8a	; MEMORY MAPPED
.equ	OCR1AH	, 0x89	; MEMORY MAPPED
.equ	OCR1AL	, 0x88	; MEMORY MAPPED
.equ	ICR1H	, 0x87	; MEMORY MAPPED
.equ	ICR1L	, 0x86	; MEMORY MAPPED
.equ	TCNT1H	, 0x85	; MEMORY MAPPED
.equ	TCNT1L	, 0x84	; MEMORY MAPPED
.equ	TCCR1C	, 0x82	; MEMORY MAPPED
.equ	TCCR1B	, 0x81	; MEMORY MAPPED
.equ	TCCR1A	, 0x80	; MEMORY MAPPED
.equ	DIDR1	, 0x7f	; MEMORY MAPPED
.equ	DIDR0	, 0x7e	; MEMORY MAPPED
.equ	ADMUX	, 0x7c	; MEMORY MAPPED
.equ	ADCSRB	, 0x7b	; MEMORY MAPPED
.equ	ADCSRA	, 0x7a	; MEMORY MAPPED
.equ	ADCH	, 0x79	; MEMORY MAPPED
.equ	ADCL	, 0x78	; MEMORY MAPPED
.equ	TIMSK2	, 0x70	; MEMORY MAPPED
.equ	TIMSK1	, 0x6f	; MEMORY MAPPED
.equ	TIMSK0	, 0x6e	; MEMORY MAPPED
.equ	PCMSK2	, 0x6d	; MEMORY MAPPED
.equ	PCMSK1	, 0x6c	; MEMORY MAPPED
.equ	PCMSK0	, 0x6b	; MEMORY MAPPED
.equ	EICRA	, 0x69	; MEMORY MAPPED
.equ	PCICR	, 0x68	; MEMORY MAPPED
.equ	OSCCAL	, 0x66	; MEMORY MAPPED
.equ	PRR	, 0x64	; MEMORY MAPPED
.equ	CLKPR	, 0x61	; MEMORY MAPPED
.equ	WDTCSR	, 0x60	; MEMORY MAPPED
.equ	SREG	, 0x3f
.equ	SPH	, 0x3e
.equ	SPL	, 0x3d
.equ	SPMCSR	, 0x37
.equ	MCUCR	, 0x35
.equ	MCUSR	, 0x34
.equ	SMCR	, 0x33
.equ	ACSR	, 0x30
.equ	SPDR	, 0x2e
.equ	SPSR	, 0x2d
.equ	SPCR	, 0x2c
.equ	GPIOR2	, 0x2b
.equ	GPIOR1	, 0x2a
.equ	OCR0B	, 0x28
.equ	OCR0A	, 0x27
.equ	TCNT0	, 0x26
.equ	TCCR0B	, 0x25
.equ	TCCR0A	, 0x24
.equ	GTCCR	, 0x23
.equ	EEARH	, 0x22
.equ	EEARL	, 0x21
.equ	EEDR	, 0x20
.equ	EECR	, 0x1f
.equ	GPIOR0	, 0x1e
.equ	EIMSK	, 0x1d
.equ	EIFR	, 0x1c
.equ	PCIFR	, 0x1b
.equ	TIFR2	, 0x17
.equ	TIFR1	, 0x16
.equ	TIFR0	, 0x15
.equ	PORTD	, 0x0b
.equ	DDRD	, 0x0a
.equ	PIND	, 0x09
.equ	PORTC	, 0x08
.equ	DDRC	, 0x07
.equ	PINC	, 0x06
.equ	PORTB	, 0x05
.equ	DDRB	, 0x04
.equ	PINB	, 0x03


; ***** BIT DEFINITIONS **************************************************

; ***** USART0 ***********************
; UDR0 - USART I/O Data Register
.equ	UDR0_0	, 0b00000001	; USART I/O Data Register bit 0
.equ	UDR0_1	, 0b00000010	; USART I/O Data Register bit 1
.equ	UDR0_2	, 0b00000100	; USART I/O Data Register bit 2
.equ	UDR0_3	, 0b00001000	; USART I/O Data Register bit 3
.equ	UDR0_4	, 0b00010000	; USART I/O Data Register bit 4
.equ	UDR0_5	, 0b00100000	; USART I/O Data Register bit 5
.equ	UDR0_6	, 0b01000000	; USART I/O Data Register bit 6
.equ	UDR0_7	, 0b10000000	; USART I/O Data Register bit 7

; UCSR0A - USART Control and Status Register A
.equ	MPCM0	, 0b00000001	; Multi-processor Communication Mode
.equ	U2X0	, 0b00000010	; Double the USART transmission speed
.equ	UPE0	, 0b00000100	; Parity Error
.equ	DOR0	, 0b00001000	; Data overRun
.equ	FE0	, 0b00010000	; Framing Error
.equ	UDRE0	, 0b00100000	; USART Data Register Empty
.equ	TXC0	, 0b01000000	; USART Transmitt Complete
.equ	RXC0	, 0b10000000	; USART Receive Complete

; UCSR0B - USART Control and Status Register B
.equ	TXB80	, 0b00000001	; Transmit Data Bit 8
.equ	RXB80	, 0b00000010	; Receive Data Bit 8
.equ	UCSZ02	, 0b00000100	; Character Size
.equ	TXEN0	, 0b00001000	; Transmitter Enable
.equ	RXEN0	, 0b00010000	; Receiver Enable
.equ	UDRIE0	, 0b00100000	; USART Data register Empty Interrupt Enable
.equ	TXCIE0	, 0b01000000	; TX Complete Interrupt Enable
.equ	RXCIE0	, 0b10000000	; RX Complete Interrupt Enable

; UCSR0C - USART Control and Status Register C
.equ	UCPOL0	, 0b00000001	; Clock Polarity
.equ	UCSZ00	, 0b00000010	; Character Size
.equ	UCPHA0	, UCSZ00	; For compatibility
.equ	UCSZ01	, 0b00000100	; Character Size
.equ	UDORD0	, UCSZ01	; For compatibility
.equ	USBS0	, 0b00001000	; Stop Bit Select
.equ	UPM00	, 0b00010000	; Parity Mode Bit 0
.equ	UPM01	, 0b00100000	; Parity Mode Bit 1
.equ	UMSEL00	, 0b01000000	; USART Mode Select
.equ	UMSEL0	, UMSEL00	; For compatibility
.equ	UMSEL01	, 0b10000000	; USART Mode Select
.equ	UMSEL1	, UMSEL01	; For compatibility


; ***** TWI **************************
; TWAMR - TWI (Slave) Address Mask Register
.equ	TWAM0	, 0b00000010	; 
.equ	TWAMR0	, TWAM0	; For compatibility
.equ	TWAM1	, 0b00000100	; 
.equ	TWAMR1	, TWAM1	; For compatibility
.equ	TWAM2	, 0b00001000	; 
.equ	TWAMR2	, TWAM2	; For compatibility
.equ	TWAM3	, 0b00010000	; 
.equ	TWAMR3	, TWAM3	; For compatibility
.equ	TWAM4	, 0b00100000	; 
.equ	TWAMR4	, TWAM4	; For compatibility
.equ	TWAM5	, 0b01000000	; 
.equ	TWAMR5	, TWAM5	; For compatibility
.equ	TWAM6	, 0b10000000	; 
.equ	TWAMR6	, TWAM6	; For compatibility

; TWBR - TWI Bit Rate register
.equ	TWBR0	, 0b00000001	; 
.equ	TWBR1	, 0b00000010	; 
.equ	TWBR2	, 0b00000100	; 
.equ	TWBR3	, 0b00001000	; 
.equ	TWBR4	, 0b00010000	; 
.equ	TWBR5	, 0b00100000	; 
.equ	TWBR6	, 0b01000000	; 
.equ	TWBR7	, 0b10000000	; 

; TWCR - TWI Control Register
.equ	TWIE	, 0b00000001	; TWI Interrupt Enable
.equ	TWEN	, 0b00000100	; TWI Enable Bit
.equ	TWWC	, 0b00001000	; TWI Write Collition Flag
.equ	TWSTO	, 0b00010000	; TWI Stop Condition Bit
.equ	TWSTA	, 0b00100000	; TWI Start Condition Bit
.equ	TWEA	, 0b01000000	; TWI Enable Acknowledge Bit
.equ	TWINT	, 0b10000000	; TWI Interrupt Flag

; TWSR - TWI Status Register
.equ	TWPS0	, 0b00000001	; TWI Prescaler
.equ	TWPS1	, 0b00000010	; TWI Prescaler
.equ	TWS3	, 0b00001000	; TWI Status
.equ	TWS4	, 0b00010000	; TWI Status
.equ	TWS5	, 0b00100000	; TWI Status
.equ	TWS6	, 0b01000000	; TWI Status
.equ	TWS7	, 0b10000000	; TWI Status

; TWDR - TWI Data register
.equ	TWD0	, 0b00000001	; TWI Data Register Bit 0
.equ	TWD1	, 0b00000010	; TWI Data Register Bit 1
.equ	TWD2	, 0b00000100	; TWI Data Register Bit 2
.equ	TWD3	, 0b00001000	; TWI Data Register Bit 3
.equ	TWD4	, 0b00010000	; TWI Data Register Bit 4
.equ	TWD5	, 0b00100000	; TWI Data Register Bit 5
.equ	TWD6	, 0b01000000	; TWI Data Register Bit 6
.equ	TWD7	, 0b10000000	; TWI Data Register Bit 7

; TWAR - TWI (Slave) Address register
.equ	TWGCE	, 0b00000001	; TWI General Call Recognition Enable Bit
.equ	TWA0	, 0b00000010	; TWI (Slave) Address register Bit 0
.equ	TWA1	, 0b00000100	; TWI (Slave) Address register Bit 1
.equ	TWA2	, 0b00001000	; TWI (Slave) Address register Bit 2
.equ	TWA3	, 0b00010000	; TWI (Slave) Address register Bit 3
.equ	TWA4	, 0b00100000	; TWI (Slave) Address register Bit 4
.equ	TWA5	, 0b01000000	; TWI (Slave) Address register Bit 5
.equ	TWA6	, 0b10000000	; TWI (Slave) Address register Bit 6


; ***** TIMER_COUNTER_1 **************
; TIMSK1 - Timer/Counter Interrupt Mask Register
.equ	TOIE1	, 0b00000001	; Timer/Counter1 Overflow Interrupt Enable
.equ	OCIE1A	, 0b00000010	; Timer/Counter1 Output CompareA Match Interrupt Enable
.equ	OCIE1B	, 0b00000100	; Timer/Counter1 Output CompareB Match Interrupt Enable
.equ	ICIE1	, 0b00100000	; Timer/Counter1 Input Capture Interrupt Enable

; TIFR1 - Timer/Counter Interrupt Flag register
.equ	TOV1	, 0b00000001	; Timer/Counter1 Overflow Flag
.equ	OCF1A	, 0b00000010	; Output Compare Flag 1A
.equ	OCF1B	, 0b00000100	; Output Compare Flag 1B
.equ	ICF1	, 0b00100000	; Input Capture Flag 1

; TCCR1A - Timer/Counter1 Control Register A
.equ	WGM10	, 0b00000001	; Waveform Generation Mode
.equ	WGM11	, 0b00000010	; Waveform Generation Mode
.equ	COM1B0	, 0b00010000	; Compare Output Mode 1B, bit 0
.equ	COM1B1	, 0b00100000	; Compare Output Mode 1B, bit 1
.equ	COM1A0	, 0b01000000	; Comparet Ouput Mode 1A, bit 0
.equ	COM1A1	, 0b10000000	; Compare Output Mode 1A, bit 1

; TCCR1B - Timer/Counter1 Control Register B
.equ	CS10	, 0b00000001	; Prescaler source of Timer/Counter 1
.equ	CS11	, 0b00000010	; Prescaler source of Timer/Counter 1
.equ	CS12	, 0b00000100	; Prescaler source of Timer/Counter 1
.equ	WGM12	, 0b00001000	; Waveform Generation Mode
.equ	WGM13	, 0b00010000	; Waveform Generation Mode
.equ	ICES1	, 0b01000000	; Input Capture 1 Edge Select
.equ	ICNC1	, 0b10000000	; Input Capture 1 Noise Canceler

; TCCR1C - Timer/Counter1 Control Register C
.equ	FOC1B	, 0b01000000	; 
.equ	FOC1A	, 0b10000000	; 

; GTCCR - General Timer/Counter Control Register
.equ	PSRSYNC	, 0b00000001	; Prescaler Reset Timer/Counter1 and Timer/Counter0
.equ	TSM	, 0b10000000	; Timer/Counter Synchronization Mode


; ***** TIMER_COUNTER_2 **************
; TIMSK2 - Timer/Counter Interrupt Mask register
.equ	TOIE2	, 0b00000001	; Timer/Counter2 Overflow Interrupt Enable
.equ	TOIE2A	, TOIE2	; For compatibility
.equ	OCIE2A	, 0b00000010	; Timer/Counter2 Output Compare Match A Interrupt Enable
.equ	OCIE2B	, 0b00000100	; Timer/Counter2 Output Compare Match B Interrupt Enable

; TIFR2 - Timer/Counter Interrupt Flag Register
.equ	TOV2	, 0b00000001	; Timer/Counter2 Overflow Flag
.equ	OCF2A	, 0b00000010	; Output Compare Flag 2A
.equ	OCF2B	, 0b00000100	; Output Compare Flag 2B

; TCCR2A - Timer/Counter2 Control Register A
.equ	WGM20	, 0b00000001	; Waveform Genration Mode
.equ	WGM21	, 0b00000010	; Waveform Genration Mode
.equ	COM2B0	, 0b00010000	; Compare Output Mode bit 0
.equ	COM2B1	, 0b00100000	; Compare Output Mode bit 1
.equ	COM2A0	, 0b01000000	; Compare Output Mode bit 1
.equ	COM2A1	, 0b10000000	; Compare Output Mode bit 1

; TCCR2B - Timer/Counter2 Control Register B
.equ	CS20	, 0b00000001	; Clock Select bit 0
.equ	CS21	, 0b00000010	; Clock Select bit 1
.equ	CS22	, 0b00000100	; Clock Select bit 2
.equ	WGM22	, 0b00001000	; Waveform Generation Mode
.equ	FOC2B	, 0b01000000	; Force Output Compare B
.equ	FOC2A	, 0b10000000	; Force Output Compare A

; TCNT2 - Timer/Counter2
.equ	TCNT2_0	, 0b00000001	; Timer/Counter 2 bit 0
.equ	TCNT2_1	, 0b00000010	; Timer/Counter 2 bit 1
.equ	TCNT2_2	, 0b00000100	; Timer/Counter 2 bit 2
.equ	TCNT2_3	, 0b00001000	; Timer/Counter 2 bit 3
.equ	TCNT2_4	, 0b00010000	; Timer/Counter 2 bit 4
.equ	TCNT2_5	, 0b00100000	; Timer/Counter 2 bit 5
.equ	TCNT2_6	, 0b01000000	; Timer/Counter 2 bit 6
.equ	TCNT2_7	, 0b10000000	; Timer/Counter 2 bit 7

; OCR2A - Timer/Counter2 Output Compare Register A
.equ	OCR2_0	, 0b00000001	; Timer/Counter2 Output Compare Register Bit 0
.equ	OCR2_1	, 0b00000010	; Timer/Counter2 Output Compare Register Bit 1
.equ	OCR2_2	, 0b00000100	; Timer/Counter2 Output Compare Register Bit 2
.equ	OCR2_3	, 0b00001000	; Timer/Counter2 Output Compare Register Bit 3
.equ	OCR2_4	, 0b00010000	; Timer/Counter2 Output Compare Register Bit 4
.equ	OCR2_5	, 0b00100000	; Timer/Counter2 Output Compare Register Bit 5
.equ	OCR2_6	, 0b01000000	; Timer/Counter2 Output Compare Register Bit 6
.equ	OCR2_7	, 0b10000000	; Timer/Counter2 Output Compare Register Bit 7

; OCR2B - Timer/Counter2 Output Compare Register B
;.equ	OCR2_0	, 0b00000001	; Timer/Counter2 Output Compare Register Bit 0
;.equ	OCR2_1	, 0b00000010	; Timer/Counter2 Output Compare Register Bit 1
;.equ	OCR2_2	, 0b00000100	; Timer/Counter2 Output Compare Register Bit 2
;.equ	OCR2_3	, 0b00001000	; Timer/Counter2 Output Compare Register Bit 3
;.equ	OCR2_4	, 0b00010000	; Timer/Counter2 Output Compare Register Bit 4
;.equ	OCR2_5	, 0b00100000	; Timer/Counter2 Output Compare Register Bit 5
;.equ	OCR2_6	, 0b01000000	; Timer/Counter2 Output Compare Register Bit 6
;.equ	OCR2_7	, 0b10000000	; Timer/Counter2 Output Compare Register Bit 7

; ASSR - Asynchronous Status Register
.equ	TCR2BUB	, 0b00000001	; Timer/Counter Control Register2 Update Busy
.equ	TCR2AUB	, 0b00000010	; Timer/Counter Control Register2 Update Busy
.equ	OCR2BUB	, 0b00000100	; Output Compare Register 2 Update Busy
.equ	OCR2AUB	, 0b00001000	; Output Compare Register2 Update Busy
.equ	TCN2UB	, 0b00010000	; Timer/Counter2 Update Busy
.equ	AS2	, 0b00100000	; Asynchronous Timer/Counter2
.equ	EXCLK	, 0b01000000	; Enable External Clock Input

; GTCCR - General Timer Counter Control register
.equ	PSRASY	, 0b00000010	; Prescaler Reset Timer/Counter2
.equ	PSR2	, PSRASY	; For compatibility
;.equ	TSM	, 0b10000000	; Timer/Counter Synchronization Mode


; ***** AD_CONVERTER *****************
; ADMUX - The ADC multiplexer Selection Register
.equ	MUX0	, 0b00000001	; Analog Channel and Gain Selection Bits
.equ	MUX1	, 0b00000010	; Analog Channel and Gain Selection Bits
.equ	MUX2	, 0b00000100	; Analog Channel and Gain Selection Bits
.equ	MUX3	, 0b00001000	; Analog Channel and Gain Selection Bits
.equ	ADLAR	, 0b00100000	; Left Adjust Result
.equ	REFS0	, 0b01000000	; Reference Selection Bit 0
.equ	REFS1	, 0b10000000	; Reference Selection Bit 1

; ADCSRA - The ADC Control and Status register A
.equ	ADPS0	, 0b00000001	; ADC  Prescaler Select Bits
.equ	ADPS1	, 0b00000010	; ADC  Prescaler Select Bits
.equ	ADPS2	, 0b00000100	; ADC  Prescaler Select Bits
.equ	ADIE	, 0b00001000	; ADC Interrupt Enable
.equ	ADIF	, 0b00010000	; ADC Interrupt Flag
.equ	ADATE	, 0b00100000	; ADC  Auto Trigger Enable
.equ	ADSC	, 0b01000000	; ADC Start Conversion
.equ	ADEN	, 0b10000000	; ADC Enable

; ADCSRB - The ADC Control and Status register B
.equ	ADTS0	, 0b00000001	; ADC Auto Trigger Source bit 0
.equ	ADTS1	, 0b00000010	; ADC Auto Trigger Source bit 1
.equ	ADTS2	, 0b00000100	; ADC Auto Trigger Source bit 2
.equ	ACME	, 0b01000000	; 

; ADCH - ADC Data Register High Byte
.equ	ADCH0	, 0b00000001	; ADC Data Register High Byte Bit 0
.equ	ADCH1	, 0b00000010	; ADC Data Register High Byte Bit 1
.equ	ADCH2	, 0b00000100	; ADC Data Register High Byte Bit 2
.equ	ADCH3	, 0b00001000	; ADC Data Register High Byte Bit 3
.equ	ADCH4	, 0b00010000	; ADC Data Register High Byte Bit 4
.equ	ADCH5	, 0b00100000	; ADC Data Register High Byte Bit 5
.equ	ADCH6	, 0b01000000	; ADC Data Register High Byte Bit 6
.equ	ADCH7	, 0b10000000	; ADC Data Register High Byte Bit 7

; ADCL - ADC Data Register Low Byte
.equ	ADCL0	, 0b00000001	; ADC Data Register Low Byte Bit 0
.equ	ADCL1	, 0b00000010	; ADC Data Register Low Byte Bit 1
.equ	ADCL2	, 0b00000100	; ADC Data Register Low Byte Bit 2
.equ	ADCL3	, 0b00001000	; ADC Data Register Low Byte Bit 3
.equ	ADCL4	, 0b00010000	; ADC Data Register Low Byte Bit 4
.equ	ADCL5	, 0b00100000	; ADC Data Register Low Byte Bit 5
.equ	ADCL6	, 0b01000000	; ADC Data Register Low Byte Bit 6
.equ	ADCL7	, 0b10000000	; ADC Data Register Low Byte Bit 7

; DIDR0 - Digital Input Disable Register
.equ	ADC0D	, 0b00000001	; 
.equ	ADC1D	, 0b00000010	; 
.equ	ADC2D	, 0b00000100	; 
.equ	ADC3D	, 0b00001000	; 
.equ	ADC4D	, 0b00010000	; 
.equ	ADC5D	, 0b00100000	; 


; ***** ANALOG_COMPARATOR ************
; ACSR - Analog Comparator Control And Status Register
.equ	ACIS0	, 0b00000001	; Analog Comparator Interrupt Mode Select bit 0
.equ	ACIS1	, 0b00000010	; Analog Comparator Interrupt Mode Select bit 1
.equ	ACIC	, 0b00000100	; 
.equ	ACIE	, 0b00001000	; Analog Comparator Interrupt Enable
.equ	ACI	, 0b00010000	; Analog Comparator Interrupt Flag
.equ	ACO	, 0b00100000	; Analog Compare Output
.equ	ACBG	, 0b01000000	; Analog Comparator Bandgap Select
.equ	ACD	, 0b10000000	; Analog Comparator Disable

; DIDR1 - Digital Input Disable Register 1
.equ	AIN0D	, 0b00000001	; AIN0 Digital Input Disable
.equ	AIN1D	, 0b00000010	; AIN1 Digital Input Disable


; ***** PORTB ************************
; PORTB - Port B Data Register
.equ	PORTB0	, 0b00000001	; Port B Data Register bit 0
.equ	PB0	, 0b00000001	; For compatibility
.equ	PORTB1	, 0b00000010	; Port B Data Register bit 1
.equ	PB1	, 0b00000010	; For compatibility
.equ	PORTB2	, 0b00000100	; Port B Data Register bit 2
.equ	PB2	, 0b00000100	; For compatibility
.equ	PORTB3	, 0b00001000	; Port B Data Register bit 3
.equ	PB3	, 0b00001000	; For compatibility
.equ	PORTB4	, 0b00010000	; Port B Data Register bit 4
.equ	PB4	, 0b00010000	; For compatibility
.equ	PORTB5	, 0b00100000	; Port B Data Register bit 5
.equ	PB5	, 0b00100000	; For compatibility
.equ	PORTB6	, 0b01000000	; Port B Data Register bit 6
.equ	PB6	, 0b01000000	; For compatibility
.equ	PORTB7	, 0b10000000	; Port B Data Register bit 7
.equ	PB7	, 0b10000000	; For compatibility

; DDRB - Port B Data Direction Register
.equ	DDB0	, 0b00000001	; Port B Data Direction Register bit 0
.equ	DDB1	, 0b00000010	; Port B Data Direction Register bit 1
.equ	DDB2	, 0b00000100	; Port B Data Direction Register bit 2
.equ	DDB3	, 0b00001000	; Port B Data Direction Register bit 3
.equ	DDB4	, 0b00010000	; Port B Data Direction Register bit 4
.equ	DDB5	, 0b00100000	; Port B Data Direction Register bit 5
.equ	DDB6	, 0b01000000	; Port B Data Direction Register bit 6
.equ	DDB7	, 0b10000000	; Port B Data Direction Register bit 7

; PINB - Port B Input Pins
.equ	PINB0	, 0b00000001	; Port B Input Pins bit 0
.equ	PINB1	, 0b00000010	; Port B Input Pins bit 1
.equ	PINB2	, 0b00000100	; Port B Input Pins bit 2
.equ	PINB3	, 0b00001000	; Port B Input Pins bit 3
.equ	PINB4	, 0b00010000	; Port B Input Pins bit 4
.equ	PINB5	, 0b00100000	; Port B Input Pins bit 5
.equ	PINB6	, 0b01000000	; Port B Input Pins bit 6
.equ	PINB7	, 0b10000000	; Port B Input Pins bit 7


; ***** PORTC ************************
; PORTC - Port C Data Register
.equ	PORTC0	, 0b00000001	; Port C Data Register bit 0
.equ	PC0	, 0b00000001	; For compatibility
.equ	PORTC1	, 0b00000010	; Port C Data Register bit 1
.equ	PC1	, 0b00000010	; For compatibility
.equ	PORTC2	, 0b00000100	; Port C Data Register bit 2
.equ	PC2	, 0b00000100	; For compatibility
.equ	PORTC3	, 0b00001000	; Port C Data Register bit 3
.equ	PC3	, 0b00001000	; For compatibility
.equ	PORTC4	, 0b00010000	; Port C Data Register bit 4
.equ	PC4	, 0b00010000	; For compatibility
.equ	PORTC5	, 0b00100000	; Port C Data Register bit 5
.equ	PC5	, 0b00100000	; For compatibility
.equ	PORTC6	, 0b01000000	; Port C Data Register bit 6
.equ	PC6	, 0b01000000	; For compatibility

; DDRC - Port C Data Direction Register
.equ	DDC0	, 0b00000001	; Port C Data Direction Register bit 0
.equ	DDC1	, 0b00000010	; Port C Data Direction Register bit 1
.equ	DDC2	, 0b00000100	; Port C Data Direction Register bit 2
.equ	DDC3	, 0b00001000	; Port C Data Direction Register bit 3
.equ	DDC4	, 0b00010000	; Port C Data Direction Register bit 4
.equ	DDC5	, 0b00100000	; Port C Data Direction Register bit 5
.equ	DDC6	, 0b01000000	; Port C Data Direction Register bit 6

; PINC - Port C Input Pins
.equ	PINC0	, 0b00000001	; Port C Input Pins bit 0
.equ	PINC1	, 0b00000010	; Port C Input Pins bit 1
.equ	PINC2	, 0b00000100	; Port C Input Pins bit 2
.equ	PINC3	, 0b00001000	; Port C Input Pins bit 3
.equ	PINC4	, 0b00010000	; Port C Input Pins bit 4
.equ	PINC5	, 0b00100000	; Port C Input Pins bit 5
.equ	PINC6	, 0b01000000	; Port C Input Pins bit 6


; ***** PORTD ************************
; PORTD - Port D Data Register
.equ	PORTD0	, 0b00000001	; Port D Data Register bit 0
.equ	PD0	, 0b00000001	; For compatibility
.equ	PORTD1	, 0b00000010	; Port D Data Register bit 1
.equ	PD1	, 0b00000010	; For compatibility
.equ	PORTD2	, 0b00000100	; Port D Data Register bit 2
.equ	PD2	, 0b00000100	; For compatibility
.equ	PORTD3	, 0b00001000	; Port D Data Register bit 3
.equ	PD3	, 0b00001000	; For compatibility
.equ	PORTD4	, 0b00010000	; Port D Data Register bit 4
.equ	PD4	, 0b00010000	; For compatibility
.equ	PORTD5	, 0b00100000	; Port D Data Register bit 5
.equ	PD5	, 0b00100000	; For compatibility
.equ	PORTD6	, 0b01000000	; Port D Data Register bit 6
.equ	PD6	, 0b01000000	; For compatibility
.equ	PORTD7	, 0b10000000	; Port D Data Register bit 7
.equ	PD7	, 0b10000000	; For compatibility

; DDRD - Port D Data Direction Register
.equ	DDD0	, 0b00000001	; Port D Data Direction Register bit 0
.equ	DDD1	, 0b00000010	; Port D Data Direction Register bit 1
.equ	DDD2	, 0b00000100	; Port D Data Direction Register bit 2
.equ	DDD3	, 0b00001000	; Port D Data Direction Register bit 3
.equ	DDD4	, 0b00010000	; Port D Data Direction Register bit 4
.equ	DDD5	, 0b00100000	; Port D Data Direction Register bit 5
.equ	DDD6	, 0b01000000	; Port D Data Direction Register bit 6
.equ	DDD7	, 0b10000000	; Port D Data Direction Register bit 7

; PIND - Port D Input Pins
.equ	PIND0	, 0b00000001	; Port D Input Pins bit 0
.equ	PIND1	, 0b00000010	; Port D Input Pins bit 1
.equ	PIND2	, 0b00000100	; Port D Input Pins bit 2
.equ	PIND3	, 0b00001000	; Port D Input Pins bit 3
.equ	PIND4	, 0b00010000	; Port D Input Pins bit 4
.equ	PIND5	, 0b00100000	; Port D Input Pins bit 5
.equ	PIND6	, 0b01000000	; Port D Input Pins bit 6
.equ	PIND7	, 0b10000000	; Port D Input Pins bit 7


; ***** TIMER_COUNTER_0 **************
; TIMSK0 - Timer/Counter0 Interrupt Mask Register
.equ	TOIE0	, 0b00000001	; Timer/Counter0 Overflow Interrupt Enable
.equ	OCIE0A	, 0b00000010	; Timer/Counter0 Output Compare Match A Interrupt Enable
.equ	OCIE0B	, 0b00000100	; Timer/Counter0 Output Compare Match B Interrupt Enable

; TIFR0 - Timer/Counter0 Interrupt Flag register
.equ	TOV0	, 0b00000001	; Timer/Counter0 Overflow Flag
.equ	OCF0A	, 0b00000010	; Timer/Counter0 Output Compare Flag 0A
.equ	OCF0B	, 0b00000100	; Timer/Counter0 Output Compare Flag 0B

; TCCR0A - Timer/Counter  Control Register A
.equ	WGM00	, 0b00000001	; Waveform Generation Mode
.equ	WGM01	, 0b00000010	; Waveform Generation Mode
.equ	COM0B0	, 0b00010000	; Compare Output Mode, Fast PWm
.equ	COM0B1	, 0b00100000	; Compare Output Mode, Fast PWm
.equ	COM0A0	, 0b01000000	; Compare Output Mode, Phase Correct PWM Mode
.equ	COM0A1	, 0b10000000	; Compare Output Mode, Phase Correct PWM Mode

; TCCR0B - Timer/Counter Control Register B
.equ	CS00	, 0b00000001	; Clock Select
.equ	CS01	, 0b00000010	; Clock Select
.equ	CS02	, 0b00000100	; Clock Select
.equ	WGM02	, 0b00001000	; 
.equ	FOC0B	, 0b01000000	; Force Output Compare B
.equ	FOC0A	, 0b10000000	; Force Output Compare A

; TCNT0 - Timer/Counter0
.equ	TCNT0_0	, 0b00000001	; 
.equ	TCNT0_1	, 0b00000010	; 
.equ	TCNT0_2	, 0b00000100	; 
.equ	TCNT0_3	, 0b00001000	; 
.equ	TCNT0_4	, 0b00010000	; 
.equ	TCNT0_5	, 0b00100000	; 
.equ	TCNT0_6	, 0b01000000	; 
.equ	TCNT0_7	, 0b10000000	; 

; OCR0A - Timer/Counter0 Output Compare Register
.equ	OCROA_0	, 0b00000001	; 
.equ	OCROA_1	, 0b00000010	; 
.equ	OCROA_2	, 0b00000100	; 
.equ	OCROA_3	, 0b00001000	; 
.equ	OCROA_4	, 0b00010000	; 
.equ	OCROA_5	, 0b00100000	; 
.equ	OCROA_6	, 0b01000000	; 
.equ	OCROA_7	, 0b10000000	; 

; OCR0B - Timer/Counter0 Output Compare Register
.equ	OCR0B_0	, 0b00000001	; 
.equ	OCR0B_1	, 0b00000010	; 
.equ	OCR0B_2	, 0b00000100	; 
.equ	OCR0B_3	, 0b00001000	; 
.equ	OCR0B_4	, 0b00010000	; 
.equ	OCR0B_5	, 0b00100000	; 
.equ	OCR0B_6	, 0b01000000	; 
.equ	OCR0B_7	, 0b10000000	; 

; GTCCR - General Timer/Counter Control Register
;.equ	PSRSYNC	, 0b00000001	; Prescaler Reset Timer/Counter1 and Timer/Counter0
.equ	PSR10	, PSRSYNC	; For compatibility
;.equ	TSM	, 0b10000000	; Timer/Counter Synchronization Mode


; ***** EXTERNAL_INTERRUPT ***********
; EICRA - External Interrupt Control Register
.equ	ISC00	, 0b00000001	; External Interrupt Sense Control 0 Bit 0
.equ	ISC01	, 0b00000010	; External Interrupt Sense Control 0 Bit 1
.equ	ISC10	, 0b00000100	; External Interrupt Sense Control 1 Bit 0
.equ	ISC11	, 0b00001000	; External Interrupt Sense Control 1 Bit 1

; EIMSK - External Interrupt Mask Register
.equ	INT0	, 0b00000001	; External Interrupt Request 0 Enable
.equ	INT1	, 0b00000010	; External Interrupt Request 1 Enable

; EIFR - External Interrupt Flag Register
.equ	INTF0	, 0b00000001	; External Interrupt Flag 0
.equ	INTF1	, 0b00000010	; External Interrupt Flag 1

; PCMSK2 - Pin Change Mask Register 2
.equ	PCINT16	, 0b00000001	; Pin Change Enable Mask 16
.equ	PCINT17	, 0b00000010	; Pin Change Enable Mask 17
.equ	PCINT18	, 0b00000100	; Pin Change Enable Mask 18
.equ	PCINT19	, 0b00001000	; Pin Change Enable Mask 19
.equ	PCINT20	, 0b00010000	; Pin Change Enable Mask 20
.equ	PCINT21	, 0b00100000	; Pin Change Enable Mask 21
.equ	PCINT22	, 0b01000000	; Pin Change Enable Mask 22
.equ	PCINT23	, 0b10000000	; Pin Change Enable Mask 23

; PCMSK1 - Pin Change Mask Register 1
.equ	PCINT8	, 0b00000001	; Pin Change Enable Mask 8
.equ	PCINT9	, 0b00000010	; Pin Change Enable Mask 9
.equ	PCINT10	, 0b00000100	; Pin Change Enable Mask 10
.equ	PCINT11	, 0b00001000	; Pin Change Enable Mask 11
.equ	PCINT12	, 0b00010000	; Pin Change Enable Mask 12
.equ	PCINT13	, 0b00100000	; Pin Change Enable Mask 13
.equ	PCINT14	, 0b01000000	; Pin Change Enable Mask 14

; PCMSK0 - Pin Change Mask Register 0
.equ	PCINT0	, 0b00000001	; Pin Change Enable Mask 0
.equ	PCINT1	, 0b00000010	; Pin Change Enable Mask 1
.equ	PCINT2	, 0b00000100	; Pin Change Enable Mask 2
.equ	PCINT3	, 0b00001000	; Pin Change Enable Mask 3
.equ	PCINT4	, 0b00010000	; Pin Change Enable Mask 4
.equ	PCINT5	, 0b00100000	; Pin Change Enable Mask 5
.equ	PCINT6	, 0b01000000	; Pin Change Enable Mask 6
.equ	PCINT7	, 0b10000000	; Pin Change Enable Mask 7

; PCIFR - Pin Change Interrupt Flag Register
.equ	PCIF0	, 0b00000001	; Pin Change Interrupt Flag 0
.equ	PCIF1	, 0b00000010	; Pin Change Interrupt Flag 1
.equ	PCIF2	, 0b00000100	; Pin Change Interrupt Flag 2


; ***** SPI **************************
; SPDR - SPI Data Register
.equ	SPDR0	, 0b00000001	; SPI Data Register bit 0
.equ	SPDR1	, 0b00000010	; SPI Data Register bit 1
.equ	SPDR2	, 0b00000100	; SPI Data Register bit 2
.equ	SPDR3	, 0b00001000	; SPI Data Register bit 3
.equ	SPDR4	, 0b00010000	; SPI Data Register bit 4
.equ	SPDR5	, 0b00100000	; SPI Data Register bit 5
.equ	SPDR6	, 0b01000000	; SPI Data Register bit 6
.equ	SPDR7	, 0b10000000	; SPI Data Register bit 7

; SPSR - SPI Status Register
.equ	SPI2X	, 0b00000001	; Double SPI Speed Bit
.equ	WCOL	, 0b01000000	; Write Collision Flag
.equ	SPIF	, 0b10000000	; SPI Interrupt Flag

; SPCR - SPI Control Register
.equ	SPR0	, 0b00000001	; SPI Clock Rate Select 0
.equ	SPR1	, 0b00000010	; SPI Clock Rate Select 1
.equ	CPHA	, 0b00000100	; Clock Phase
.equ	CPOL	, 0b00001000	; Clock polarity
.equ	MSTR	, 0b00010000	; Master/Slave Select
.equ	DORD	, 0b00100000	; Data Order
.equ	SPE	, 0b01000000	; SPI Enable
.equ	SPIE	, 0b10000000	; SPI Interrupt Enable


; ***** CPU **************************
; SREG - Status Register
.equ	SREG_C	, 0b00000001	; Carry Flag
.equ	SREG_Z	, 0b00000010	; Zero Flag
.equ	SREG_N	, 0b00000100	; Negative Flag
.equ	SREG_V	, 0b00001000	; Two's Complement Overflow Flag
.equ	SREG_S	, 0b00010000	; Sign Bit
.equ	SREG_H	, 0b00100000	; Half Carry Flag
.equ	SREG_T	, 0b01000000	; Bit Copy Storage
.equ	SREG_I	, 0b10000000	; Global Interrupt Enable

; OSCCAL - Oscillator Calibration Value
.equ	CAL0	, 0b00000001	; Oscillator Calibration Value Bit0
.equ	CAL1	, 0b00000010	; Oscillator Calibration Value Bit1
.equ	CAL2	, 0b00000100	; Oscillator Calibration Value Bit2
.equ	CAL3	, 0b00001000	; Oscillator Calibration Value Bit3
.equ	CAL4	, 0b00010000	; Oscillator Calibration Value Bit4
.equ	CAL5	, 0b00100000	; Oscillator Calibration Value Bit5
.equ	CAL6	, 0b01000000	; Oscillator Calibration Value Bit6
.equ	CAL7	, 0b10000000	; Oscillator Calibration Value Bit7

; CLKPR - Clock Prescale Register
.equ	CLKPS0	, 0b00000001	; Clock Prescaler Select Bit 0
.equ	CLKPS1	, 0b00000010	; Clock Prescaler Select Bit 1
.equ	CLKPS2	, 0b00000100	; Clock Prescaler Select Bit 2
.equ	CLKPS3	, 0b00001000	; Clock Prescaler Select Bit 3
.equ	CLKPCE	, 0b10000000	; Clock Prescaler Change Enable

; SPMCSR - Store Program Memory Control Register
.equ	SELFPRGEN	, 0b00000001	; Self Programming Enable
.equ	PGERS	, 0b00000010	; Page Erase
.equ	PGWRT	, 0b00000100	; Page Write
.equ	BLBSET	, 0b00001000	; Boot Lock Bit Set
.equ	RWWSRE	, 0b00010000	; Read-While-Write section read enable
.equ	RWWSB	, 0b01000000	; Read-While-Write Section Busy
.equ	SPMIE	, 0b10000000	; SPM Interrupt Enable

; MCUCR - MCU Control Register
.equ	IVCE	, 0b00000001	; 
.equ	IVSEL	, 0b00000010	; 
.equ	PUD	, 0b00010000	; 

; MCUSR - MCU Status Register
.equ	PORF	, 0b00000001	; Power-on reset flag
.equ	EXTRF	, 0b00000010	; External Reset Flag
.equ	EXTREF	, EXTRF	; For compatibility
.equ	BORF	, 0b00000100	; Brown-out Reset Flag
.equ	WDRF	, 0b00001000	; Watchdog Reset Flag

; SMCR - 
.equ	SE	, 0b00000001	; 
.equ	SM0	, 0b00000010	; 
.equ	SM1	, 0b00000100	; 
.equ	SM2	, 0b00001000	; 

; GPIOR2 - General Purpose I/O Register 2
.equ	GPIOR20	, 0b00000001	; 
.equ	GPIOR21	, 0b00000010	; 
.equ	GPIOR22	, 0b00000100	; 
.equ	GPIOR23	, 0b00001000	; 
.equ	GPIOR24	, 0b00010000	; 
.equ	GPIOR25	, 0b00100000	; 
.equ	GPIOR26	, 0b01000000	; 
.equ	GPIOR27	, 0b10000000	; 

; GPIOR1 - General Purpose I/O Register 1
.equ	GPIOR10	, 0b00000001	; 
.equ	GPIOR11	, 0b00000010	; 
.equ	GPIOR12	, 0b00000100	; 
.equ	GPIOR13	, 0b00001000	; 
.equ	GPIOR14	, 0b00010000	; 
.equ	GPIOR15	, 0b00100000	; 
.equ	GPIOR16	, 0b01000000	; 
.equ	GPIOR17	, 0b10000000	; 

; GPIOR0 - General Purpose I/O Register 0
.equ	GPIOR00	, 0b00000001	; 
.equ	GPIOR01	, 0b00000010	; 
.equ	GPIOR02	, 0b00000100	; 
.equ	GPIOR03	, 0b00001000	; 
.equ	GPIOR04	, 0b00010000	; 
.equ	GPIOR05	, 0b00100000	; 
.equ	GPIOR06	, 0b01000000	; 
.equ	GPIOR07	, 0b10000000	; 

; PRR - Power Reduction Register
.equ	PRADC	, 0b00000001	; Power Reduction ADC
.equ	PRUSART0	, 0b00000010	; Power Reduction USART
.equ	PRSPI	, 0b00000100	; Power Reduction Serial Peripheral Interface
.equ	PRTIM1	, 0b00001000	; Power Reduction Timer/Counter1
.equ	PRTIM0	, 0b00100000	; Power Reduction Timer/Counter0
.equ	PRTIM2	, 0b01000000	; Power Reduction Timer/Counter2
.equ	PRTWI	, 0b10000000	; Power Reduction TWI

; PCICR - 
.equ	PCIE0	, 0b00000001	; 
.equ	PCIE1	, 0b00000010	; 
.equ	PCIE2	, 0b00000100	; 


; ***** WATCHDOG *********************
; WDTCSR - Watchdog Timer Control Register
.equ	WDP0	, 0b00000001	; Watch Dog Timer Prescaler bit 0
.equ	WDP1	, 0b00000010	; Watch Dog Timer Prescaler bit 1
.equ	WDP2	, 0b00000100	; Watch Dog Timer Prescaler bit 2
.equ	WDE	, 0b00001000	; Watch Dog Enable
.equ	WDCE	, 0b00010000	; Watchdog Change Enable
.equ	WDP3	, 0b00100000	; Watchdog Timer Prescaler Bit 3
.equ	WDIE	, 0b01000000	; Watchdog Timeout Interrupt Enable
.equ	WDIF	, 0b10000000	; Watchdog Timeout Interrupt Flag


; ***** EEPROM ***********************
; EEARL - EEPROM Address Register Low Byte
.equ	EEAR0	, 0b00000001	; EEPROM Read/Write Access Bit 0
.equ	EEAR1	, 0b00000010	; EEPROM Read/Write Access Bit 1
.equ	EEAR2	, 0b00000100	; EEPROM Read/Write Access Bit 2
.equ	EEAR3	, 0b00001000	; EEPROM Read/Write Access Bit 3
.equ	EEAR4	, 0b00010000	; EEPROM Read/Write Access Bit 4
.equ	EEAR5	, 0b00100000	; EEPROM Read/Write Access Bit 5
.equ	EEAR6	, 0b01000000	; EEPROM Read/Write Access Bit 6
.equ	EEAR7	, 0b10000000	; EEPROM Read/Write Access Bit 7

; EEARH - EEPROM Address Register High Byte
.equ	EEAR8	, 0b00000001	; EEPROM Read/Write Access Bit 0

; EEDR - EEPROM Data Register
.equ	EEDR0	, 0b00000001	; EEPROM Data Register bit 0
.equ	EEDR1	, 0b00000010	; EEPROM Data Register bit 1
.equ	EEDR2	, 0b00000100	; EEPROM Data Register bit 2
.equ	EEDR3	, 0b00001000	; EEPROM Data Register bit 3
.equ	EEDR4	, 0b00010000	; EEPROM Data Register bit 4
.equ	EEDR5	, 0b00100000	; EEPROM Data Register bit 5
.equ	EEDR6	, 0b01000000	; EEPROM Data Register bit 6
.equ	EEDR7	, 0b10000000	; EEPROM Data Register bit 7

; EECR - EEPROM Control Register
.equ	EERE	, 0b00000001	; EEPROM Read Enable
.equ	EEPE	, 0b00000010	; EEPROM Write Enable
.equ	EEMPE	, 0b00000100	; EEPROM Master Write Enable
.equ	EERIE	, 0b00001000	; EEPROM Ready Interrupt Enable
.equ	EEPM0	, 0b00010000	; EEPROM Programming Mode Bit 0
.equ	EEPM1	, 0b00100000	; EEPROM Programming Mode Bit 1



; ***** LOCKSBITS ********************************************************
.equ	LB1	, 0b00000001	; Lock bit
.equ	LB2	, 0b00000010	; Lock bit
.equ	BLB01	, 0b00000100	; Boot Lock bit
.equ	BLB02	, 0b00001000	; Boot Lock bit
.equ	BLB11	, 0b00010000	; Boot lock bit
.equ	BLB12	, 0b00100000	; Boot lock bit


; ***** FUSES ************************************************************
; LOW fuse bits
.equ	CKSEL0	, 0b00000001	; Select Clock Source
.equ	CKSEL1	, 0b00000010	; Select Clock Source
.equ	CKSEL2	, 0b00000100	; Select Clock Source
.equ	CKSEL3	, 0b00001000	; Select Clock Source
.equ	SUT0	, 0b00010000	; Select start-up time
.equ	SUT1	, 0b00100000	; Select start-up time
.equ	CKOUT	, 0b01000000	; Clock output
.equ	CKDIV8	, 0b10000000	; Divide clock by 8

; HIGH fuse bits
.equ	BODLEVEL0	, 0b00000001	; Brown-out Detector trigger level
.equ	BODLEVEL1	, 0b00000010	; Brown-out Detector trigger level
.equ	BODLEVEL2	, 0b00000100	; Brown-out Detector trigger level
.equ	EESAVE	, 0b00001000	; EEPROM memory is preserved through chip erase
.equ	WDTON	, 0b00010000	; Watchdog Timer Always On
.equ	SPIEN	, 0b00100000	; Enable Serial programming and Data Downloading
.equ	DWEN	, 0b01000000	; debugWIRE Enable
.equ	RSTDISBL	, 0b10000000	; External reset disable

; EXTENDED fuse bits
.equ	BOOTRST	, 0b00000001	; Select reset vector
.equ	BOOTSZ0	, 0b00000010	; Select boot size
.equ	BOOTSZ1	, 0b00000100	; Select boot size



; ***** CPU REGISTER DEFINITIONS *****************************************
.equ	XH	, r27
.equ	XL	, r26
.equ	YH	, r29
.equ	YL	, r28
.equ	ZH	, r31
.equ	ZL	, r30



; ***** DATA MEMORY DECLARATIONS *****************************************
.equ	FLASHEND	, 0x1fff	; Note: Word address
.equ	IOEND	, 0x00ff
.equ	SRAM_START	, 0x0100
.equ	SRAM_SIZE	, 1024
.equ	RAMEND	, 0x04ff
.equ	XRAMEND	, 0x0000
.equ	E2END	, 0x01ff
.equ	EEPROMEND	, 0x01ff
.equ	EEADRBITS	, 9



; ***** BOOTLOADER DECLARATIONS ******************************************
.equ	NRWW_START_ADDR	, 0x1c00
.equ	NRWW_STOP_ADDR	, 0x1fff
.equ	RWW_START_ADDR	, 0x0
.equ	RWW_STOP_ADDR	, 0x1bff
.equ	PAGESIZE	, 64
.equ	FIRSTBOOTSTART	, 0x1f80
.equ	SECONDBOOTSTART	, 0x1f00
.equ	THIRDBOOTSTART	, 0x1e00
.equ	FOURTHBOOTSTART	, 0x1c00
.equ	SMALLBOOTSTART	, FIRSTBOOTSTART
.equ	LARGEBOOTSTART	, FOURTHBOOTSTART



; ***** INTERRUPT VECTORS ************************************************
.equ	INT0addr	, 0x0002	; External Interrupt Request 0
.equ	INT1addr	, 0x0004	; External Interrupt Request 1
.equ	PCI0addr	, 0x0006	; Pin Change Interrupt Request 0
.equ	PCI1addr	, 0x0008	; Pin Change Interrupt Request 0
.equ	PCI2addr	, 0x000a	; Pin Change Interrupt Request 1
.equ	WDTaddr	, 0x000c	; Watchdog Time-out Interrupt
.equ	OC2Aaddr	, 0x000e	; Timer/Counter2 Compare Match A
.equ	OC2Baddr	, 0x0010	; Timer/Counter2 Compare Match A
.equ	OVF2addr	, 0x0012	; Timer/Counter2 Overflow
.equ	ICP1addr	, 0x0014	; Timer/Counter1 Capture Event
.equ	OC1Aaddr	, 0x0016	; Timer/Counter1 Compare Match A
.equ	OC1Baddr	, 0x0018	; Timer/Counter1 Compare Match B
.equ	OVF1addr	, 0x001a	; Timer/Counter1 Overflow
.equ	OC0Aaddr	, 0x001c	; TimerCounter0 Compare Match A
.equ	OC0Baddr	, 0x001e	; TimerCounter0 Compare Match B
.equ	OVF0addr	, 0x0020	; Timer/Couner0 Overflow
.equ	SPIaddr	, 0x0022	; SPI Serial Transfer Complete
.equ	URXCaddr	, 0x0024	; USART Rx Complete
.equ	UDREaddr	, 0x0026	; USART, Data Register Empty
.equ	UTXCaddr	, 0x0028	; USART Tx Complete
.equ	ADCCaddr	, 0x002a	; ADC Conversion Complete
.equ	ERDYaddr	, 0x002c	; EEPROM Ready
.equ	ACIaddr	, 0x002e	; Analog Comparator
.equ	TWIaddr	, 0x0030	; Two-wire Serial Interface
.equ	SPMRaddr	, 0x0032	; Store Program Memory Read

.equ	INT_VECTORS_SIZE	, 52	; size in words


; ***** END OF FILE ******************************************************
