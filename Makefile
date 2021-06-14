CC = clang
CFLAGS = 

.SUFFIXES : .o .c
.c.o : 
	$(CC) $(CFLAGS) -c $<

test : test.o func.o vars.o
	$(CC) -o test test.o func.o vars.o

test2 : test.o libTest.a
	$(CC) -o test2 test.o libTest.a

libTest.a : func.o vars.o
	ar rc libTest.a func.o vars.o

clean : 
	rm -f test test2 *.a *.o a.out
