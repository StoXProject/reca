DEBUG_CFLAGS =
ECA_CFLAGS = $(DEBUG_CFLAGS) -g -O3 $(INCLUDE)

LIB    = -lpthread -lm
LFLAGS = -static-libgcc \
	$(LIBTAUCS) $(LIBMETIS) $(LIBBLAS) \
	$(or $(wildcard $(shell gcc -print-file-name=libgfortran.a))  ,-lgfortran) \
	$(or $(wildcard $(shell gcc -print-file-name=libquadmath.a))  ,-lquadmath)
BIN    = .
CC     = gcc
LD     = $(CC)
FC     = gfortran

# F2C lib for OSX
F2C =

# OS detection (Windows is considered Linux since we use Mingw)
OSTYPE = linux
ifeq ($(OS),Windows_NT)
	OSTYPE = linux
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
		OSTYPE = linux
	endif
	ifeq ($(UNAME_S),Darwin)
		OSTYPE = darwin_intel
		F2C = ../../$(LIBF2C)
	endif
endif

# Whether to build universal openblas
OPENBLASFLAG =
ifeq ($(CI), true)
        OPENBLASFLAG = "DYNAMIC_ARCH=1"
endif

# Required static libs
LIBF2CDIR = libs/f2c
LIBF2C = $(LIBF2CDIR)/libf2c.a

LIBTAUCSDIR = libs/taucs
LIBTAUCS = $(LIBTAUCSDIR)/lib/$(OSTYPE)/libtaucs.a

LIBMETISDIR = libs/metis
LIBMETIS = $(LIBMETISDIR)/libmetis.a

LIBBLASDIR = libs/openblas
LIBBLAS = $(LIBBLASDIR)/libblas.a

TEST   = test.o 

OBJ1   = caa_main_model1.o 

OBJ2   = caa_main_model2.o 

OBJ3   = caa_main_predict.o 

OBJ  =  caa_predict.o \
	caa_estimate.o \
	caa_cell_constr.o \
        caa_chol.o \
        caa_evaluate.o \
	caa_init.o \
	caa_input.o \
	caa_lqp.o \
        caa_mcmc.o \
	caa_read_binary.o \
	caa_read_write.o \
        caa_routines.o \
        caa_sample_g_a.o \
        caa_sample_gauss.o \
        caa_sample_multi.o \
        caa_summaries.o \
        caa_util.o \
        caa_utl.o \
        blockupdate.o \
        com.o \
        d_brent.o \
        d_erfcc.o \
        d_erff.o \
        d_f1dim.o \
        d_gammln.o \
        d_gammp.o \
        d_gauher.o \
        d_gcf.o \
        d_gser.o \
        distributions.o \
	d_ksone.o \
        d_linmin.o \
        d_mnbrak.o \
        d_nrutil.o \
        d_powell.o \
	d_probks.o \
	d_sort.o \
        error-handler.o \
        gdens.o \
        globals.o \
        graph.o \
        hash.o \
        hidden-approx.o \
        lapack-interface.o \
        linpack.o \
        optimize.o \
        problem-setup.o \
        random.o \
        ranlib.o \
        rw.o \
        smtp-band.o \
        smtp-profile.o \
        smtp-taucs.o \
        sparse-interface.o \
        tabulate-Qfunc.o \
        timer.o \
        utl_malloc.o \
        wa.o \
	acm582.o \
        dcdflib.o \
        GMRFLib-fortran.o 

#.c.o : $(CC) -c $(ECA_CFLAGS) $<

.PHONY : all caa clean cleanall

all: caa install
	
caa: caa_main_model1 caa_main_model2 caa_main_predict

caa_main_model1:        $(OBJ1) $(OBJ) $(LIBTAUCS)
	$(LD) $(OBJ1) $(OBJ) -o $(BIN)/caa_main_model1 $(LFLAGS) $(LIB)

caa_main_model2:        $(OBJ2) $(OBJ) $(LIBTAUCS)
	$(LD) $(OBJ2) $(OBJ) -o $(BIN)/caa_main_model2 $(LFLAGS) $(LIB)

caa_main_predict:       $(OBJ3) $(OBJ) $(LIBTAUCS)
	$(LD) $(OBJ3) $(OBJ) -o $(BIN)/caa_main_predict $(LFLAGS) $(LIB)
#	$(LD) $(ECA_CFLAGS)   $(OBJ) -o $(BIN)/predict $(LFLAGS) $(LIB)

$(LIBBLAS):
	>&2 echo "Building OpenBLAS"
	$(MAKE) -C $(LIBBLASDIR) $(OPENBLASFLAG) FC=$(FC) NO_LAPACKE=1 NO_SHARED=1 libs netlib
	cp -f $(LIBBLASDIR)/libopenblas*p*.a $(LIBBLASDIR)/libblas.a

$(LIBMETIS):
	>&2 echo "Building METIS"
	CC="$(CC)" $(MAKE) -C $(LIBMETISDIR)/Lib

$(F2C):
	>&2 echo "Building F2C"
	$(MAKE) -C $(LIBF2CDIR)

$(LIBTAUCS): $(LIBBLAS) $(LIBMETIS) $(F2C)
	>&2 echo "Building TAUCS"
	CC="$(CC)" $(MAKE) -C $(LIBTAUCSDIR) -f configurator/makefile.unix
	cd $(LIBTAUCSDIR); OSTYPE=$(OSTYPE) configurator/configurator
	CC=gfortran $(MAKE) -C $(LIBTAUCSDIR) LIBLAPACK="" LIBBLAS="../../$(LIBBLAS) -lpthread" LIBMETIS=../../$(LIBMETIS) LIBF77="$(F2C)"

caa_main_model1.o: caa.h caa_read_binary.h caa_estimate.h caa_main_model1.c
caa_main_model2.o: caa.h caa_read_binary.h caa_estimate.h caa_main_model2.c
caa_main_predict.o: caa.h caa_read_binary.h caa_predict.h caa_main_predict.c
caa_read_write.o: caa.h caa_read_write.h caa_read_write.c
caa_read_binary.o: caa.h caa_read_binary.h caa_read_binary.c
caa_routines.o: caa.h caa_routines.h caa_routines.c
caa_sample_gauss.o: caa.h caa_sample_gauss.h caa_sample_gauss.c
caa_sample_multi.o: caa.h caa_sample_multi.h caa_sample_multi.c
caa_sample_g_a.o: caa.h caa_sample_g_a.h caa_sample_g_a.c
caa_simulate.o: caa.h caa_simulate.h caa_simulate.c
caa_evaluate.o: caa.h caa_evaluate.h numrec.h caa_evaluate.c
caa_chol.o: caa.h caa_chol.h caa_chol.c
caa_lqp.o: caa.h caa_lqp.h caa_lqp.c
caa_util.o: caa.h caa_util.c
caa_utl.o: caa.h caa_utl.c
caa_init.o: caa.h caa_init.c
caa_input.o: caa.h caa_input.c
caa_predict.o: caa.h caa_predict.c
caa_summaries.o: caa.h caa_summaries.c
d_erff.o: d_erff.c
d_erfcc.o: d_erfcc.c
d_gammp.o: d_gammp.c
d_gser.o: d_gser.c
d_gcf.o: d_gcf.c
d_gammln.o: d_gammln.c
d_ksone.o: d_ksone.c
d_gauher.o: d_gauher.c
ranlib.o: ranlib.c
com.o: com.c
linpack.o: linpack.c
utl_malloc.o: utl_malloc.c
blockupdate.o: blockupdate.c
distributions.o: distributions.c
error-handler.o: error-handler.c
gdens.o: gdens.c
globals.o: globals.c
graph.o: graph.c
hidden-approx.o: hidden-approx.c
lapack-interface.o: lapack-interface.c
optimize.o: optimize.c
tabulate-Qfunc.o: tabulate-Qfunc.c
problem-setup.o: problem-setup.c
random.o: random.c
rw.o:rw.c
hash.o: hash.c
smtp-band.o:smtp-band.c
smtp-profile.o:smtp-profile.c
smtp-taucs.o:smtp-taucs.c
sparse-interface.o:sparse-interface.c
timer.o:timer.c
wa.o: wa.c
acm582.o: acm582.f
GMRFLib-fortran.o: GMRFLib-fortran.f
dcdflib.o: dcdflib.f
d_nrutil.o: d_nrutil.c
d_powell.o: d_powell.c
d_linmin.o: d_linmin.c
d_mnbrak.o: d_mnbrak.c
d_f1dim.o: d_f1dim.c
d_brent.o: d_brent.c


install: $(caa)
	mkdir -p ../inst/bin
	install $(BIN)/caa_main_model1 $(BIN)/caa_main_model2 $(BIN)/caa_main_predict ../inst/bin/

clean:
	rm -f *.o
	rm -f caa_main_model1 caa_main_model2 caa_main_predict

cleanall: clean
	$(MAKE) -C $(LIBTAUCSDIR) clean
	$(MAKE) -C $(LIBTAUCSDIR) distclean
	$(MAKE) -C $(LIBMETISDIR) realclean
	$(MAKE) -C $(LIBBLASDIR) clean
	$(MAKE) -C $(LIBF2CDIR) clean
