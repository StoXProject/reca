#########################################################
# WIN32 (common part)                                   #
#########################################################
OBJEXT=.obj
LIBEXT=.lib
EXEEXT=.exe
F2CEXT=.c
# make sure there is NO space after the backslash
PATHSEP=\\
DEFFLG=/D

CC        = cl
CFLAGS    = /nologo /O2 /W3 /D "WIN32" /MT
COUTFLG   =/Fo

FC        = $(CC)
FFLAGS    = $(CFLAGS)
FOUTFLG   = $(COUTFLG)

LD        = $(CC)
LDFLAGS   = /nologo /MT /F64000000
LOUTFLG   = /Fe

RM        = del /Q
AR        = lib /nologo
AOUTFLG   = /out:

RANLIB    = echo

#LIBBLAS   = mkl_c.lib libguide40.lib
#LIBLAPACK = 

#LIBBLAS   = external\\lib\\win32\\blas_win32.lib
#LIBLAPACK = external\\lib\\win32\\lapack_win32.lib

#LIBBLAS   = external\\lib\\win32\\libf77blas.lib external\\lib\\win32\\libcblas.lib external\\lib\\win32\\libatlas.lib
#LIBLAPACK = external\\lib\\win32\\liblapack.lib

#LIBMETIS  = external\\lib\\win32\\libmetis.lib
LIBF77    = -lf2c
LIBC      =









