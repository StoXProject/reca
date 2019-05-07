#########################################################
# WIN32 MKL variant with multithreaded DLL runtime      #
#########################################################

CFLAGS    = /nologo /O2 /W3 /D "WIN32" /MD

LDFLAGS   = /nologo /MD /F64000000

LIBBLAS   = mkl_c.lib libguide40.lib
LIBLAPACK = 

LIBMETIS  = external\\lib\\win32_MD\\libmetis.lib
LIBF77    = external\\lib\\win32_MD\\vcf2c.lib









