#!/bin/bash

if [ "$1" == "" ]; then
    echo "Error, specify a .hex file."
    exit -1
fi

avrdude -p ATmega16 -F -e -c stk500v2 -P /dev/ttyUSB1 -Uflash:w:"$1":i


