INCLUDE = /usr/bin/share/cc65/asminc

.PHONY: rom.bin

OBJS = 	main.o \
	chargen.o \
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
	$(eval BASIC_ENTRY := $(shell grep '^INIT\ ' rom.map | sed -r 's/ +/ /g' | cut -d' ' -f2))
	@echo
	@echo Entry point of BASIC is $(BASIC_ENTRY)
msbasic.o: msbasic.s
	$(AS) -I $(INCLUDE) -D cbmbasic2 $< -o $@ -l $@.lst

%.o: %.s
	$(AS) -I $(INCLUDE) $< -l $@.lst

clean:
	rm *.o rom.bin

.PHONY: all clean
