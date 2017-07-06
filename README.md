## Picocom configuration ##

Start picocom with:

```
picocom --send-cmd "sx -Xb" -b 19200 -d 8 --emap lfcr /dev/ttyUSB0
```

## XMODEM File transfer ##


```
REICHEL R8
6502 CPU @ 2 MHz
32K RAM         
MONITOR (c)1976 Steve Wozniak
ADAPTED 2017 Andreas J. Reichel
\                              
F900R
F900: 20XMOD
CCCC
*** file: /home/andreas/Projects/6502/testprogs/test1.bin
$ sx -Xb /home/andreas/Projects/6502/testprogs/test1.bin 
Sending /home/andreas/Projects/6502/testprogs/test1.bin, 0 blocks: Give your local XMODEM receive command now.
Xmodem sectors/kbytes sent:   0/ 0kRetry 0: NAK on sector
Bytes Sent:    128   BPS:75                              

Transfer complete

*** exit status: 0 ***
OK
\
1000.1020
1000: A9 0E 85 20 A9 10 85 21
1008: 20 2F C0 4C 00 F8 48 69
1010: 2C 20 49 20 61 6D 20 74
1018: 68 65 20 66 69 72 73 74
1020: 20                     
1000    
1000: A9
Hi, I am the first program transfered via serial :)
\                                                  
```

