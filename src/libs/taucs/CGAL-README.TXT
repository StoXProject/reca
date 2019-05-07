                          taucs_full/CGAL-README.TXT
                  -----------------------------------------

TAUCS 2.2 official release is available from http://www.tau.ac.il/~stoledo/taucs

This taucs_full.tgz archive contains a version modified by CGAL team
to fix (minor) bugs and simplify the installation process.
It contains the third-party libraries used by TAUCS (ATLAS, Metis, f2c, ...)
precompiled for all platforms supported by CGAL 3.3 (including BLAS and LAPACK).

If your platform is missing, you will have to compile them.
taucs_exteral_src.tgz, available from the Download section of http://www.cgal.org,
contains the necessary source files.


Install instructions (Unix and Cygwin):
--------------------------------------

The version modified by CGAL team can be installed on Unix machines by:
  ./configure [prefix=PREFIX]
  make
  make install

See TAUCS documentation taucs.pdf to install the official release or customize TAUCS.

TAUCS comes with the ATLAS library precompiled on some platforms.
If ATLAS is slow or crashes on your machine, please recompile it. Source code
can be downloaded from the official site http://math-atlas.sourceforge.net
and is part of taucs_exteral_src.tgz (available from the Download section 
of http://www.cgal.org).


Install instructions (Windows):
-------------------------------

On Windows, CGAL 3.3 installer installs TAUCS precompiled for Visual C++ 7.1 and 8.0,
including the third-party libraries used by TAUCS (ATLAS, Metis, f2c, ...), 
thus most Windows users do not need to compile TAUCS.

If for any reason you have to recompile TAUCS for the /MD runtime (in an MS-DOS Prompt Shell):
    vsvars32.bat
    configure variant=_MD
    nmake
Replace _MD by _ML or _MT for the /ML or /MT runtimes.

CAUTION: TAUCS tends to crash when compiled with the debug runtimes /MDd, /MLd or /MTd!!!

build_taucs_win32_for_CGAL.bat is a utility for CGAL developers: it compiles 
all variants of TAUCS library for Windows/VisualC++, and copies the headers and library
to include/ and lib/ folders with names appropriate for CGAL 3.3.

ATLAS provides Blas and a subset of Lapack. It is precompiled for a Pentium 4 
processor with SSE2 instructions. If ATLAS is slow or crashes on your machine, 
please recompile it. Source code can be downloaded from the official site
http://math-atlas.sourceforge.net and is part of taucs_exteral_src.tgz 
(available from the Download section of http://www.cgal.org).

You may use TAUCS with other Blas libraries like Intel's MKL, AMD Core Math
Library or Goto Blas.
See TAUCS documentation taucs.pdf to create a "variant" makefile to compile TAUCS
with the appropriate Blas library and runtime.
config\win32_mkl_MD.mk is an example compiling TAUCS with the /MD runtime
and Intel's MKL library.
Example (in an MS-DOS Prompt Shell):
    vsvars32.bat
    configure variant=_mkl_MD
    nmake


Changes in CGAL 3.3
-------------------

* Added _MT, _ML, _MDd, _MLd and _MTd variants for Visual C++.
CAUTION: TAUCS tends to crash when compiled with the debug runtimes /MDd, /MLd or /MTd!!!

* Added build_taucs_win32_for_CGAL.bat.

* Fixed bug in taucs_available_memory_size() on Linux 2.6.
  Implemented taucs_system_memory_size() for Cygwin.

* Added darwin_intel platform for Intel Macs.

* Removed -Werror (all warnings are errors) compilation option to support gcc 4.

* Added libg2c.so in external/lib/linux/ and external/lib/solaris/ to support gcc 4.x.
TODO: do the same for irix.

* ATLAS' liblapack.a replaced by an hybrid ATLAS/Reference LAPACK implementation library
(in external/lib/linux/, external/lib/win32_MD/, external/lib/cygwin/ and external/lib/solaris/).

* linux_intel.mk updated for Intel C++ 9.

* testscript restores now TAUCS library and header files at the end of the test.


Changes in CGAL 3.2 (compared to TAUCS 2.2 at http://www.tau.ac.il/~stoledo/taucs)
----------------------------------------------------------------------------------

* Fixed bug in taucs_system_memory_size() on Linux 2.6.

* Fixed bugs in configure in $OSTYPE computation.

* Changed taucs_config.c to add an "install" target to the makefile.

* Changed in all .mk makefiles, "COUTFLG   = -o " by "COUTFLG   = -o ./"
because by editor removes trailing slashes. Same thing for FOUTFLG.

* Added "LIBMETIS = -Lexternal/lib/solaris -lmetis" to the cc section of solaris.mk.

* Precompiled Metis on Darwin

* Added support for cygwin/gcc:
- cygwin.mk
- external/lib/cygwin libraries

* Changed the INTEL MKL library(ies) from "C:\Program Files\Intel\MKL60\ia32\lib\mkl_s.lib"
to "mkl_c.lib libguide40.lib" in win32.mk

* Added win32_MD variant to compile TAUCS with Visual C++ and the
multithreaded DLL runtime (option /MD):
- win32_MD.mk
- external/lib/win32_MD libraries

* Added win32_mkl_MD.mk to compile TAUCS with Visual C++, INTEL's MKL and the
multithreaded DLL runtime (option /MD).

* Removed external libraries for Windows and the multithreaded runtime (option /MT)
in order to save space.


Laurent Saboret
Laurent.Saboret@sophia.inria.fr
May 2007
