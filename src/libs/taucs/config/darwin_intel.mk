#########################################################
# Darwin (MacOSX) for Intel processors                  #
#########################################################
OBJEXT=.o
LIBEXT=.a
EXEEXT=
F2CEXT=.c
PATHSEP=/
DEFFLG=-D

CFLAGS    = -O2 -Wall $(OPT_FLAGS) -Wno-implicit-function-declaration
COUTFLG   = -o ./

FC        = $(CC)
FFLAGS    = $(CFLAGS)
FOUTFLG   = $(COUTFLG)

LD        = $(CC)
LDFLAGS   = $(CFLAGS)
LOUTFLG   = $(COUTFLG)

AR        = ar -cr
AOUTFLG   =

RANLIB    = ranlib
RM        = rm -rf

LIBBLAS   = -lblas
LIBLAPACK = -llapack
LIBMETIS  = -lmetis

LIBF77 = -lf2c
# crypto is for ftime, which is used by the timing routines
LIBC   = -lm

#########################################################







