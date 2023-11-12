# Ovo je primjer komentara
# U novom redu imamo primjer kreiranja varijabli

CC = gcc
CFLAGS = -c -Wall

# target: all sada ima dependencies

all: test

test: main.o fnc.o
	$(CC) main.o fnc.o -o test
	ls -l test

main.o:	main.c
	$(CC) $(CFLAGS) main.c
	
fnc.o: fnc.c
	$(CC) $(CFLAGS) fnc.c

clean:
	rm *.o test
