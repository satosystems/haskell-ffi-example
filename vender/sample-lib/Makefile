CC = gcc
CFLAG = -fPIC

.PHONY: build
build: sample.o

.PHONY: all
all: libsample.so

.PHONY: clean
clean:
	@rm -f *.so *.o test

libsample.so: sample.o
	$(CC) -shared -o $@ $<

sample.o: sample.c sample.h
	$(CC) $(CFLAG) $< -c

test: test.c all
	$(CC) $< -o $@ -lsample -L.
	./test

