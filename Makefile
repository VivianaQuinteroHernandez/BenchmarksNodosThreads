GCC = gcc-11
FLAGS = -ansi -pedantic -Wall 
CFLAGS = -lm -lpthread -fopenmp -std=c99
THEPROGS = Algoritmo_3 Algoritmo_1 Algoritmo_2

PROGS:   Algoritmo_3 Algoritmo_1 Algoritmo_2

all: Algoritmo_1 Algoritmo_2 Algoritmo_3

Algoritmo_1:
	$(GCC) $(FLAGS) modulo.c -c -D_POSIX_C_SOURCE=199309L $(CFLAGS)
	$(GCC) $(FLAGS) $@.c -c $(CFLAGS)
	$(GCC) $(FLAGS) modulo.o $@.o -o $@ $(CFLAGS)

Algoritmo_2:
	$(GCC) $(FLAGS) modulo.c -c -D_POSIX_C_SOURCE=199309L $(CFLAGS)
	$(GCC) $(FLAGS) $@.c -c $(CFLAGS)
	$(GCC) $(FLAGS) modulo.o $@.o -o $@ $(CFLAGS)

Algoritmo_3:
	$(GCC) $(FLAGS) modulo.c -c $(CFLAGS)
	$(GCC) $(FLAGS) $@.c -c $(CFLAGS)
	$(GCC) $(FLAGS) $@.c modulo.o -o $@ $(CFLAGS)

clean:
	$(RM) $(PROGS) *.o
	
