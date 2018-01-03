#!/bin/bash

avrdude -P /dev/ttyUSB0 -p Atmega168 -c stk500v2 -U lfuse:w:0xde:m -U hfuse:w:0x99:m -U efuse:w:0xff:m -F

# avrdude -U lfuse:w:0xff:m 
