INCLUDE = /usr/bin/share/cc65/asminc

OBJS = 	main.o \
		math2.o \
		math.o \
		xmodem.o \
		wozmon.o \
        msbasic.o 

AS = ca65

LD = ld65

all: rom.bin

rom.bin: $(OBJS)
	$(LD) $^ -C rom.cfg -o $@ -m rom.map

msbasic.o: msbasic.s
	$(AS) -I $(INCLUDE) -D cbmbasic2 $< -o $@

%.o: %.s
	$(AS) -I $(INCLUDE) $<

clean:
	rm *.o rom.bin

.PHONY: all clean
