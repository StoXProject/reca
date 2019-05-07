#########################################################
# WIN32 with multithreaded static runtime               #
#########################################################

CFLAGS    = /nologo /O2 /W3 /D "WIN32" /MT

LDFLAGS   = /nologo /MT /F64000000

#LIBBLAS   = external\\lib\\win32\\blas_win32.lib
#LIBLAPACK = external\\lib\\win32\\lapack_win32.lib

LIBBLAS   = external\\lib\\win32\\libf77blas.lib external\\lib\\win32\\libcblas.lib external\\lib\\win32\\libatlas.lib
LIBLAPACK = external\\lib\\win32\\liblapack.lib

LIBMETIS  = external\\lib\\win32_MT\\libmetis.lib
LIBF77    = external\\lib\\win32_MT\\vcf2c.lib









