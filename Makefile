EMACS_ROOT ?= ../..
EMACS ?= emacs

CC      = gcc
LD      = gcc
CPPFLAGS = -I$(EMACS_ROOT)/src
CFLAGS = -std=gnu99 -ggdb3 -O2 -Wall -fPIC $(CPPFLAGS)

.PHONY : clean test

all: fib-core.so

fib-core.so: fib-core.o
	$(LD) -L . -shared $(LDFLAGS) -o $@ $^

fib-core.o: fib-core.c
	$(CC) $(CFLAGS) -c -o $@ $^

clean:
	-rm -f fib-core.o fib-core.so

test:
	$(EMACS) -Q -batch -L . -l test/test.el -f ert-run-tests-batch-and-exit
