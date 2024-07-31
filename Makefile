#
# ccsrch 1.1.0 (C) 2024 Julian Fondren <julian.fondren@newfold.com>
#              (C) 2012-2016 Adam Caudill <adam@adamcaudill.com>
#              (C) 2007 Mike Beekey <zaphod2718@yahoo.com>
# All rights reserved
#
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
#
#
# Makefile for ccsrch
#

CC      = gcc
INCL    =
OBJS    = ccsrch.o
LIBSDIR	= -L./
LIBS	= 
PROGS	= ccsrch

.PHONY: all linux solaris windows

#this hack is to support OSX
UNAME := $(shell uname)
ifeq ($(UNAME), Darwin)
  CFLAGS	=-O2 -Wall -Wextra
  LDFLAGS	=
else
  CFLAGS	=-O2 -Wall -Wextra
  LDFLAGS	=
endif

strict: CFLAGS += -pedantic -Wall -Werror

all:	${PROGS}

windows:
	zig cc --target=x86_64-windows -o ccsrch.exe ${CFLAGS} ccsrch.c
linux:
	zig cc --target=x86_64-linux-musl -o ccsrch-linux ${CFLAGS} ccsrch.c
solaris: # unable to find or provide libc for target 'x86_64-solaris.5.11...5.11-musl'
	zig cc --target=x86_64-solaris-musl -o ccsrch-solaris ${CFLAGS} ccsrch.c

ccsrch:	${OBJS}
	${CC} ${CFLAGS} ${INCL} ${LDFLAGS} ${OBJS} ${LIBSDIR} ${LIBS} -o ${PROGS}

strict:	${PROGS}

clean:
	rm -f core *.core ${PROGS} ${OBJS}

.c.o:
	${CC} ${CFLAGS} ${INCL} -c $<

install:
	cp ccsrch /usr/local/bin/
	chmod 4755 /usr/local/bin/ccsrch

