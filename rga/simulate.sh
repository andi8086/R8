#!/bin/bash
simulavr -d Atmega168 -F 22000000 -c vcd:tracefile:trace.vcd -f main.elf

