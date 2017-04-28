

OBJS = 	main.o \
		math2.o \
		math.o \
		xmodem.o \
		wozmon.o \
        msbasic.o 

all: rom.bin

rom.bin: $(OBJS)
	ld65 $^ -C rom.cfg -o $@ -m rom.map

msbasic.o: msbasic.s
	ca65 -D cbmbasic2 $< -o $@

%.o: %.s
	ca65 $<

clean:
	rm *.o rom.bin

.PHONY: all clean
