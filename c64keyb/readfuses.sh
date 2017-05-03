#!/bin/bash

avrdude -P /dev/ttyUSB1 -p Atmega16 -c stk500v2 -U lfuse:r:-:m -U hfuse:r:-:m -U efuse:r:-:m -F

# avrdude -U lfuse:w:0xff:m 
