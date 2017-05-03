#!/bin/bash

avrdude -P /dev/ttyUSB1 -p Atmega16 -c stk500v2 -U lfuse:w:0xe1:m -U hfuse:w:0xd9:m -U efuse:w:0xff:m -F

# avrdude -U lfuse:w:0xff:m 
