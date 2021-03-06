# make and run all the example programs for
# lex & yacc, Second Edition
CC = gcc
LEX = flex
YACC = bison
MATH = -lm
CURSES = -lcurses

PROGRAMS1 = ch1-01.pgm ch1-02.pgm ch1-03.pgm ch1-04.pgm ch1-05.pgm ch1-06.pgm
PROGRAMS2 = ch2-01.pgm ch2-02.pgm ch2-03.pgm ch2-04.pgm ch2-05.pgm ch2-06.pgm \
            ch2-07.pgm ch2-08.pgm ch2-09.pgm
PROGRAMS3 = ch3-01.pgm ch3-02.pgm ch3-03.pgm ch3-04.pgm ch3-05.pgm
PROGRAMS4 = screen
PROGRAMS5 = sql1 sql2

all: ${PROGRAMS1} ${PROGRAMS2} ${PROGRAMS3} ${PROGRAMS4} ${PROGRAMS5}

ch1: ${PROGRAMS1}
ch2: ${PROGRAMS2}
ch3: ${PROGRAMS3}
ch4: ${PROGRAMS4}
ch5: ${PROGRAMS5}

CLEAN1 = ch1-01.pgm ch1-01.c \
         ch1-02.pgm ch1-02.c \
         ch1-03.pgm ch1-03.c \
         ch1-04.pgm ch1-04.c \
         ch1-05.pgm ch1-05.o ch1-05.c ch1-05.tab.c ch1-05.tab.h ch1-05.tab.o \
         ch1-06.pgm ch1-06.o ch1-06.c ch1-06.tab.c ch1-06.tab.h ch1-06.tab.o

CLEAN2 = ch2-01.pgm ch2-01.c \
         ch2-02.pgm ch2-02.c \
         ch2-03.pgm ch2-03.c \
         ch2-04.pgm ch2-04.c \
         ch2-05.pgm ch2-05.c \
         ch2-06.pgm ch2-06.c \
         ch2-07.pgm ch2-07.c \
         ch2-08.pgm ch2-08.c \
         ch2-09.pgm ch2-09.c

CLEAN3 = ch3-01.pgm ch3-01.c ch3-01.tab.c ch3-01.tab.h \
         ch3-02.pgm ch3-02.c ch3-02.tab.c ch3-02.tab.h \
         ch3-03.pgm ch3-03.c ch3-03.tab.c ch3-03.tab.h \
         ch3-04.pgm ch3-04.c ch3-04.tab.c ch3-04.tab.h \
         ch3-05.pgm ch3-05.c ch3-05.tab.c ch3-05.tab.h

CLEAN4 =  mgl mglyac.tab.c mglyac.tab.h mgllex.c screen.out.c screen

CLEAN5 =  sql1 sql1.output sql1.tab.c sql1.tab.h scn1.c \
          sql2 sql2.output sql2.tab.c sql2.tab.h scn2.c

clean:
	rm -f ${CLEAN1} ${CLEAN2} ${CLEAN3} ${CLEAN4} ${CLEAN5}

# Chapter 1

ch1-05.pgm: ch1-05.o ch1-05.tab.o
	${CC} -o $@ $^
	@echo "---- end $@ ----"

ch1-05.c: ch1-05.l ch1-05.tab.h ch1-05.h
	${LEX} -o $@ ch1-05.l

ch1-05.tab.h ch1-05.tab.c: ch1-05.y ch1-05.h
	${YACC} -d ch1-05.y

ch1-06.pgm: ch1-06.o ch1-06.tab.o
	${CC} -o $@ $^
	@echo "---- end $@ ----"

ch1-06.c: ch1-06.l ch1-06.tab.h ch1-06.h
	${LEX} -o $@ ch1-06.l

ch1-06.tab.h ch1-06.tab.c: ch1-06.y ch1-06.h
	${YACC} -d ch1-06.y

# Chapter 2
# all use single lex source files

# Chapter 3

ch3-01.pgm: ch3-01.l ch3-01.y
	${YACC} -d ch3-01.y
	${LEX} -o ch3-01.c ch3-01.l
	${CC} -o $@ ch3-01.tab.c ch3-01.c
	@echo "---- end $@ ----"

ch3-02.pgm: ch3-02.l ch3-02.y
	${YACC} -d ch3-02.y
	${LEX} -o ch3-02.c ch3-02.l
	${CC} -o $@ ch3-02.tab.c ch3-02.c
	@echo "---- end $@ ----"

ch3-03.pgm: ch3-03.l ch3-03.y
	${YACC} -d ch3-03.y
	${LEX} -o ch3-03.c ch3-03.l
	${CC} -o $@ ch3-03.tab.c ch3-03.c
	@echo "---- end $@ ----"

ch3-04.pgm: ch3-04.l ch3-04.y ch3hdr.h
	${YACC} -d ch3-04.y
	${LEX} -o ch3-04.c ch3-04.l
	${CC} -o $@ ch3-04.tab.c ch3-04.c
	@echo "---- end $@ ----"

ch3-05.pgm: ch3-05.l ch3-05.y ch3hdr2.h
	${YACC} -d ch3-05.y
	${LEX} -o ch3-05.c ch3-05.l
	${CC} -o $@ ch3-05.tab.c ch3-05.c ${MATH}
	@echo "---- end $@ ----"

# chapter 4

screen: mgl mmain.c mgl-in
	./mgl mgl-in
	${CC} -o $@ screen.out.c mmain.c ${CURSES}
	@echo "---- end $@ ----"

mgl: mglyac.y mgllex.l subr.c mgl-code mglhdr.h
	${YACC} -d mglyac.y
	${LEX} -o mgllex.c mgllex.l
	${CC} -o $@ mglyac.tab.c mgllex.c subr.c
	@echo "---- end $@ ----"

# chapter 5

sql1: sql1.y scn1.l sql1hdr.h
	${YACC} -vd sql1.y
	${LEX} -o scn1.c scn1.l
	${CC} -o $@ sql1.tab.c scn1.c
	@echo "---- end $@ ----"

sql2: sql2.y scn2.l sqltext.c sql2hdr.h
	${YACC} -vd sql2.y
	${LEX} -o scn2.c scn2.l
	${CC} -o $@ sql2.tab.c scn2.c sqltext.c
	@echo "---- end $@ ----"


.SUFFIXES:	.pgm .l .y

.l.pgm:
	${LEX} -o $*.c $<
	${CC} -o $@ $*.c
	@echo "---- end $@ ----"

.c.o:
	${CC} -c -o $*.o $*.c

