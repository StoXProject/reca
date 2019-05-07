#########################################################
# WIN32 with multithreaded DLL runtime                  #
#########################################################

CFLAGS    = /nologo /O2 /W3 /D "WIN32" /MD

LDFLAGS   = /nologo /MD /F64000000

#LIBBLAS   = external\\lib\\win32\\blas_win32.lib
#LIBLAPACK = external\\lib\\win32\\lapack_win32.lib

LIBBLAS   = external\\lib\\win32\\libf77blas.lib external\\lib\\win32\\libcblas.lib external\\lib\\win32\\libatlas.lib
LIBLAPACK = external\\lib\\win32\\liblapack.lib

LIBMETIS  = external\\lib\\win32_MD\\libmetis.lib
LIBF77    = external\\lib\\win32_MD\\vcf2c.lib









