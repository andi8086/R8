INCLUDE = /usr/bin/share/cc65/asminc

OBJS = 	msbasic.o \
        serial.o

AS = ca65

LD = ld65

all: basic.bin

basic.bin: $(OBJS)
	$(LD) $^ -C basic.cfg -o $@ -m basic.map
	$(eval BASIC_ENTRY := $(shell grep '^INIT\ ' basic.map | sed -r 's/ +/ /g' | cut -d' ' -f2))
	@echo
	@echo Entry point of BASIC is $(BASIC_ENTRY)
	printf "\x00\x58" | cat - basic.bin > basic.rom    

msbasic.o: msbasic.s
	$(AS) -I $(INCLUDE) -D cbmbasic2 $< -o $@

%.o: %.s
	$(AS) -I $(INCLUDE) $<

clean:
	rm *.o basic.bin

.PHONY: all clean
