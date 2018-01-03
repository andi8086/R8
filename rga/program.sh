#!/bin/bash

if [ "$1" == "" ]; then
    echo "Error, specify a .hex file."
    exit -1
fi

avrdude -p ATmega168 -F -e -c stk500v2 -P /dev/ttyUSB0 -Uflash:w:"$1":i


