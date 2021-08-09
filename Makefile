#
# Copyright (C) 2003 Conrad Rehill (703) 528-3280
# All rights reserved.
#
# This software may be freely copied, modified, and redistributed
# provided that this copyright notice is preserved on all copies.
#
# There is no warranty or other guarantee of fitness of this software
# for any purpose.  It is provided solely "as is".
#
#

#----------------------------------------------------------------
# pronoc 33/53 Server Program Makefile
#----------------------------------------------------------------

SHELL=/bin/bash

EXECUTABLE= arduino
OBJ= main.o signal_handlers.o t_process_monitor.o t_keyboard_handler.o parser.o do_print.o mqtt_callback.o kbhit.o t_loop.o
INCLUDEDIR=.
CFLAGS= -I$(INCLUDEDIR) -I/usr/include/postgresql -Wall
LDFLAGS= -lpthread -lpq -lncurses -lmosquitto
CC = gcc

all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJ)
	$(CC) $(CFLAGS) $(OBJ) -o $@ $(LDFLAGS)
	chmod 775 $(EXECUTABLE)

main.o: main.c arduino.h
	$(CC) $(CFLAGS) -c $*.c

mqtt_callback.o: mqtt_callback.c arduino.h
	$(CC) $(CFLAGS) -c $*.c

do_print.o: do_print.c arduino.h
	$(CC) $(CFLAGS) -c $*.c

parser.o: parser.c arduino.h
	$(CC) $(CFLAGS) -c $*.c

signal_handlers.o: signal_handlers.c arduino.h
	$(CC) $(CFLAGS) -c $*.c

t_process_monitor.o: t_process_monitor.c arduino.h
	$(CC) $(CFLAGS) -c $*.c

t_keyboard_handler.o: t_keyboard_handler.c arduino.h
	$(CC) $(CFLAGS) -c $*.c

kbhit.o: kbhit.c
	$(CC) $(CFLAGS) -c $*.c

#t_listener.o: t_listener.c arduino.h
#	$(CC) $(CFLAGS) -c $*.c
t_loop.o: t_loop.c arduino.h
	$(CC) $(CFLAGS) -c $*.c
#t_dbtrigger.o: t_dbtrigger.c arduino.h
#	$(CC) $(CFLAGS) -c $*.c
#t_discovery.o: t_discovery.c arduino.h
#	$(CC) $(CFLAGS) -c $*.c
#sql.o: sql.c arduino.h
#	$(CC) $(CFLAGS) -c $*.c

clean:
	rm -f ./*.o
	rm -f ./$(EXECUTABLE)
	rm -f ./a.out
	rm -f ./core

install:
	cp -f ./arduino.conf /usr/local/etc
	cp -f ./arduino  /usr/local/bin
