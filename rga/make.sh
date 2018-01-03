#!/bin/bash
rm -f main.o
avr-as -mmcu=Atmega168 -o main.o main.s
avr-ld -mavr5 -o main.elf main.o
avr-objcopy -j .text -j .data -O ihex main.elf main.hex
#simulavr -d Atmega168 -F 22000000 -c vcd:tracefile:trace.vcd -f main.elf
