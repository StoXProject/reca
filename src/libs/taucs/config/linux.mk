#########################################################
# Linux gcc 2.9.x or 3.x                                #
#########################################################
OBJEXT=.o
LIBEXT=.a
EXEEXT=
F2CEXT=.f
PATHSEP=/
DEFFLG=-D
OPT_FLAGS =
FC        = gfortran
FFLAGS    = -O2 -g -fno-second-underscore -Wall $(OPT_FLAGS)
FOUTFLG   = -o ./

COUTFLG   = -o ./
#CFLAGS    = -O0 -g -D_POSIX_C_SOURCE=199506L -Wall -pedantic -ansi -fPIC -fexceptions -D_GNU_SOURCE $(OPT_FLAGS)
#CFLAGS    = -g -O2 -Wall -pedantic -ansi $(OPT_FLAGS)
# for some reason, -std=c99 -pedantic crashes
# with the error message "imaginary constants are a GCC extension"
# (seems to be a gcc bug, gcc 3.3.1)
#CFLAGS    = -O2 -Wall -std=c89 -pedantic $(OPT_FLAGS)
CFLAGS    = -O2 -Wall $(OPT_FLAGS)

LD        = $(CC)
LDFLAGS   = 
LOUTFLG   = $(COUTFLG)

AR        = ar cr
AOUTFLG   =

RANLIB    = ranlib
RM        = rm -rf

# These are for a Pentium4 version of ATLAS (not bundled with taucs)
#LIBBLAS   = -L /home/stoledo/Public/Linux_P4SSE2/lib -lblas \
#            -L /usr/lib/gcc-lib/i386-redhat-linux/2.96 
#LIBLAPACK = -L /home/stoledo/Public/Linux_P4SSE2/lib -llapack

LIBBLAS   = -L external/lib/linux -lblas
LIBLAPACK = -L external/lib/linux -llapack

LIBMETIS  = -L external/lib/linux -lmetis

LIBF77 = 
LIBC   = -lm -lgfortran -lquadmath ${MINGW_EXTRA}

#########################################################







