#########################################################
# WIN32 with debug multithreaded static runtime         #
#########################################################

#CFLAGS    = /nologo /Od /W3 /D "WIN32" /MTd /ZI /Fd"obj\\win32_MTd\\libtaucs.pdb"
CFLAGS    = /nologo /O2 /W3 /D "WIN32" /MTd

LDFLAGS   = /nologo /MTd /F64000000

#LIBBLAS   = external\\lib\\win32\\blas_win32.lib
#LIBLAPACK = external\\lib\\win32\\lapack_win32.lib

LIBBLAS   = external\\lib\\win32\\libf77blas.lib external\\lib\\win32\\libcblas.lib external\\lib\\win32\\libatlas.lib
LIBLAPACK = external\\lib\\win32\\liblapack.lib

LIBMETIS  = external\\lib\\win32_MTd\\libmetis.lib
LIBF77    = external\\lib\\win32_MTd\\vcf2c.lib









