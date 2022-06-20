*> \brief \b CCHKEE
*
*  =========== DOCUMENTATION ===========
*
* Online html documentation available at
*            http://www.netlib.org/lapack/explore-html/
*
*  Definition:
*  ===========
*
*       PROGRAM CCHKEE
*
*
*> \par Purpose:
*  =============
*>
*> \verbatim
*>
*> CCHKEE tests the COMPLEX LAPACK subroutines for the matrix
*> eigenvalue problem.  The test paths in this version are
*>
*> NEP (Nonsymmetric Eigenvalue Problem):
*>     Test CGEHRD, CUNGHR, CHSEQR, CTREVC, CHSEIN, and CUNMHR
*>
*> SEP (Hermitian Eigenvalue Problem):
*>     Test CHETRD, CUNGTR, CSTEQR, CSTERF, CSTEIN, CSTEDC,
*>     and drivers CHEEV(X), CHBEV(X), CHPEV(X),
*>                 CHEEVD,   CHBEVD,   CHPEVD
*>
*> SVD (Singular Value Decomposition):
*>     Test CGEBRD, CUNGBR, and CBDSQR
*>     and the drivers CGESVD, CGESDD
*>
*> CEV (Nonsymmetric Eigenvalue/eigenvector Driver):
*>     Test CGEEV
*>
*> CES (Nonsymmetric Schur form Driver):
*>     Test CGEES
*>
*> CVX (Nonsymmetric Eigenvalue/eigenvector Expert Driver):
*>     Test CGEEVX
*>
*> CSX (Nonsymmetric Schur form Expert Driver):
*>     Test CGEESX
*>
*> CGG (Generalized Nonsymmetric Eigenvalue Problem):
*>     Test CGGHD3, CGGBAL, CGGBAK, CHGEQZ, and CTGEVC
*>
*> CGS (Generalized Nonsymmetric Schur form Driver):
*>     Test CGGES
*>
*> CGV (Generalized Nonsymmetric Eigenvalue/eigenvector Driver):
*>     Test CGGEV
*>
*> CGX (Generalized Nonsymmetric Schur form Expert Driver):
*>     Test CGGESX
*>
*> CXV (Generalized Nonsymmetric Eigenvalue/eigenvector Expert Driver):
*>     Test CGGEVX
*>
*> CSG (Hermitian Generalized Eigenvalue Problem):
*>     Test CHEGST, CHEGV, CHEGVD, CHEGVX, CHPGST, CHPGV, CHPGVD,
*>     CHPGVX, CHBGST, CHBGV, CHBGVD, and CHBGVX
*>
*> CHB (Hermitian Band Eigenvalue Problem):
*>     Test CHBTRD
*>
*> CBB (Band Singular Value Decomposition):
*>     Test CGBBRD
*>
*> CEC (Eigencondition estimation):
*>     Test CTRSYL, CTREXC, CTRSNA, and CTRSEN
*>
*> CBL (Balancing a general matrix)
*>     Test CGEBAL
*>
*> CBK (Back transformation on a balanced matrix)
*>     Test CGEBAK
*>
*> CGL (Balancing a matrix pair)
*>     Test CGGBAL
*>
*> CGK (Back transformation on a matrix pair)
*>     Test CGGBAK
*>
*> GLM (Generalized Linear Regression Model):
*>     Tests CGGGLM
*>
*> GQR (Generalized QR and RQ factorizations):
*>     Tests CGGQRF and CGGRQF
*>
*> GSV (Generalized Singular Value Decomposition):
*>     Tests CGGSVD, CGGSVP, CTGSJA, CLAGS2, CLAPLL, and CLAPMT
*>
*> CSD (CS decomposition):
*>     Tests CUNCSD
*>
*> LSE (Constrained Linear Least Squares):
*>     Tests CGGLSE
*>
*> Each test path has a different set of inputs, but the data sets for
*> the driver routines xEV, xES, xVX, and xSX can be concatenated in a
*> single input file.  The first line of input should contain one of the
*> 3-character path names in columns 1-3.  The number of remaining lines
*> depends on what is found on the first line.
*>
*> The number of matrix types used in testing is often controllable from
*> the input file.  The number of matrix types for each path, and the
*> test routine that describes them, is as follows:
*>
*> Path name(s)  Types    Test routine
*>
*> CHS or NEP      21     CCHKHS
*> CST or SEP      21     CCHKST (routines)
*>                 18     CDRVST (drivers)
*> CBD or SVD      16     CCHKBD (routines)
*>                  5     CDRVBD (drivers)
*> CEV             21     CDRVEV
*> CES             21     CDRVES
*> CVX             21     CDRVVX
*> CSX             21     CDRVSX
*> CGG             26     CCHKGG (routines)
*> CGS             26     CDRGES
*> CGX              5     CDRGSX
*> CGV             26     CDRGEV
*> CXV              2     CDRGVX
*> CSG             21     CDRVSG
*> CHB             15     CCHKHB
*> CBB             15     CCHKBB
*> CEC              -     CCHKEC
*> CBL              -     CCHKBL
*> CBK              -     CCHKBK
*> CGL              -     CCHKGL
*> CGK              -     CCHKGK
*> GLM              8     CCKGLM
*> GQR              8     CCKGQR
*> GSV              8     CCKGSV
*> CSD              3     CCKCSD
*> LSE              8     CCKLSE
*>
*>-----------------------------------------------------------------------
*>
*> NEP input file:
*>
*> line 2:  NN, INTEGER
*>          Number of values of N.
*>
*> line 3:  NVAL, INTEGER array, dimension (NN)
*>          The values for the matrix dimension N.
*>
*> line 4:  NPARMS, INTEGER
*>          Number of values of the parameters NB, NBMIN, NX, NS, and
*>          MAXB.
*>
*> line 5:  NBVAL, INTEGER array, dimension (NPARMS)
*>          The values for the blocksize NB.
*>
*> line 6:  NBMIN, INTEGER array, dimension (NPARMS)
*>          The values for the minimum blocksize NBMIN.
*>
*> line 7:  NXVAL, INTEGER array, dimension (NPARMS)
*>          The values for the crossover point NX.
*>
*> line 8:  INMIN, INTEGER array, dimension (NPARMS)
*>          LAHQR vs TTQRE crossover point, >= 11
*>
*> line 9:  INWIN, INTEGER array, dimension (NPARMS)
*>          recommended deflation window size
*>
*> line 10: INIBL, INTEGER array, dimension (NPARMS)
*>          nibble crossover point
*>
*> line 11:  ISHFTS, INTEGER array, dimension (NPARMS)
*>          number of simultaneous shifts)
*>
*> line 12:  IACC22, INTEGER array, dimension (NPARMS)
*>          select structured matrix multiply: 0, 1 or 2)
*>
*> line 13: THRESH
*>          Threshold value for the test ratios.  Information will be
*>          printed about each test for which the test ratio is greater
*>          than or equal to the threshold.  To have all of the test
*>          ratios printed, use THRESH = 0.0 .
*>
*> line 14: NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 14 was 2:
*>
*> line 15: INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 15-EOF:  The remaining lines occur in sets of 1 or 2 and allow
*>          the user to specify the matrix types.  Each line contains
*>          a 3-character path name in columns 1-3, and the number
*>          of matrix types must be the first nonblank item in columns
*>          4-80.  If the number of matrix types is at least 1 but is
*>          less than the maximum number of possible types, a second
*>          line will be read to get the numbers of the matrix types to
*>          be used.  For example,
*> NEP 21
*>          requests all of the matrix types for the nonsymmetric
*>          eigenvalue problem, while
*> NEP  4
*> 9 10 11 12
*>          requests only matrices of type 9, 10, 11, and 12.
*>
*>          The valid 3-character path names are 'NEP' or 'CHS' for the
*>          nonsymmetric eigenvalue routines.
*>
*>-----------------------------------------------------------------------
*>
*> SEP or CSG input file:
*>
*> line 2:  NN, INTEGER
*>          Number of values of N.
*>
*> line 3:  NVAL, INTEGER array, dimension (NN)
*>          The values for the matrix dimension N.
*>
*> line 4:  NPARMS, INTEGER
*>          Number of values of the parameters NB, NBMIN, and NX.
*>
*> line 5:  NBVAL, INTEGER array, dimension (NPARMS)
*>          The values for the blocksize NB.
*>
*> line 6:  NBMIN, INTEGER array, dimension (NPARMS)
*>          The values for the minimum blocksize NBMIN.
*>
*> line 7:  NXVAL, INTEGER array, dimension (NPARMS)
*>          The values for the crossover point NX.
*>
*> line 8:  THRESH
*>          Threshold value for the test ratios.  Information will be
*>          printed about each test for which the test ratio is greater
*>          than or equal to the threshold.
*>
*> line 9:  TSTCHK, LOGICAL
*>          Flag indicating whether or not to test the LAPACK routines.
*>
*> line 10: TSTDRV, LOGICAL
*>          Flag indicating whether or not to test the driver routines.
*>
*> line 11: TSTERR, LOGICAL
*>          Flag indicating whether or not to test the error exits for
*>          the LAPACK routines and driver routines.
*>
*> line 12: NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 12 was 2:
*>
*> line 13: INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 13-EOF:  Lines specifying matrix types, as for NEP.
*>          The valid 3-character path names are 'SEP' or 'CST' for the
*>          Hermitian eigenvalue routines and driver routines, and
*>          'CSG' for the routines for the Hermitian generalized
*>          eigenvalue problem.
*>
*>-----------------------------------------------------------------------
*>
*> SVD input file:
*>
*> line 2:  NN, INTEGER
*>          Number of values of M and N.
*>
*> line 3:  MVAL, INTEGER array, dimension (NN)
*>          The values for the matrix row dimension M.
*>
*> line 4:  NVAL, INTEGER array, dimension (NN)
*>          The values for the matrix column dimension N.
*>
*> line 5:  NPARMS, INTEGER
*>          Number of values of the parameter NB, NBMIN, NX, and NRHS.
*>
*> line 6:  NBVAL, INTEGER array, dimension (NPARMS)
*>          The values for the blocksize NB.
*>
*> line 7:  NBMIN, INTEGER array, dimension (NPARMS)
*>          The values for the minimum blocksize NBMIN.
*>
*> line 8:  NXVAL, INTEGER array, dimension (NPARMS)
*>          The values for the crossover point NX.
*>
*> line 9:  NSVAL, INTEGER array, dimension (NPARMS)
*>          The values for the number of right hand sides NRHS.
*>
*> line 10: THRESH
*>          Threshold value for the test ratios.  Information will be
*>          printed about each test for which the test ratio is greater
*>          than or equal to the threshold.
*>
*> line 11: TSTCHK, LOGICAL
*>          Flag indicating whether or not to test the LAPACK routines.
*>
*> line 12: TSTDRV, LOGICAL
*>          Flag indicating whether or not to test the driver routines.
*>
*> line 13: TSTERR, LOGICAL
*>          Flag indicating whether or not to test the error exits for
*>          the LAPACK routines and driver routines.
*>
*> line 14: NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 14 was 2:
*>
*> line 15: INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 15-EOF:  Lines specifying matrix types, as for NEP.
*>          The 3-character path names are 'SVD' or 'CBD' for both the
*>          SVD routines and the SVD driver routines.
*>
*>-----------------------------------------------------------------------
*>
*> CEV and CES data files:
*>
*> line 1:  'CEV' or 'CES' in columns 1 to 3.
*>
*> line 2:  NSIZES, INTEGER
*>          Number of sizes of matrices to use. Should be at least 0
*>          and at most 20. If NSIZES = 0, no testing is done
*>          (although the remaining  3 lines are still read).
*>
*> line 3:  NN, INTEGER array, dimension(NSIZES)
*>          Dimensions of matrices to be tested.
*>
*> line 4:  NB, NBMIN, NX, NS, NBCOL, INTEGERs
*>          These integer parameters determine how blocking is done
*>          (see ILAENV for details)
*>          NB     : block size
*>          NBMIN  : minimum block size
*>          NX     : minimum dimension for blocking
*>          NS     : number of shifts in xHSEQR
*>          NBCOL  : minimum column dimension for blocking
*>
*> line 5:  THRESH, REAL
*>          The test threshold against which computed residuals are
*>          compared. Should generally be in the range from 10. to 20.
*>          If it is 0., all test case data will be printed.
*>
*> line 6:  NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 6 was 2:
*>
*> line 7:  INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 8 and following:  Lines specifying matrix types, as for NEP.
*>          The 3-character path name is 'CEV' to test CGEEV, or
*>          'CES' to test CGEES.
*>
*>-----------------------------------------------------------------------
*>
*> The CVX data has two parts. The first part is identical to CEV,
*> and the second part consists of test matrices with precomputed
*> solutions.
*>
*> line 1:  'CVX' in columns 1-3.
*>
*> line 2:  NSIZES, INTEGER
*>          If NSIZES = 0, no testing of randomly generated examples
*>          is done, but any precomputed examples are tested.
*>
*> line 3:  NN, INTEGER array, dimension(NSIZES)
*>
*> line 4:  NB, NBMIN, NX, NS, NBCOL, INTEGERs
*>
*> line 5:  THRESH, REAL
*>
*> line 6:  NEWSD, INTEGER
*>
*> If line 6 was 2:
*>
*> line 7:  INTEGER array, dimension (4)
*>
*> lines 8 and following: The first line contains 'CVX' in columns 1-3
*>          followed by the number of matrix types, possibly with
*>          a second line to specify certain matrix types.
*>          If the number of matrix types = 0, no testing of randomly
*>          generated examples is done, but any precomputed examples
*>          are tested.
*>
*> remaining lines : Each matrix is stored on 1+N+N**2 lines, where N is
*>          its dimension. The first line contains the dimension N and
*>          ISRT (two integers). ISRT indicates whether the last N lines
*>          are sorted by increasing real part of the eigenvalue
*>          (ISRT=0) or by increasing imaginary part (ISRT=1). The next
*>          N**2 lines contain the matrix rowwise, one entry per line.
*>          The last N lines correspond to each eigenvalue. Each of
*>          these last N lines contains 4 real values: the real part of
*>          the eigenvalues, the imaginary part of the eigenvalue, the
*>          reciprocal condition number of the eigenvalues, and the
*>          reciprocal condition number of the vector eigenvector. The
*>          end of data is indicated by dimension N=0. Even if no data
*>          is to be tested, there must be at least one line containing
*>          N=0.
*>
*>-----------------------------------------------------------------------
*>
*> The CSX data is like CVX. The first part is identical to CEV, and the
*> second part consists of test matrices with precomputed solutions.
*>
*> line 1:  'CSX' in columns 1-3.
*>
*> line 2:  NSIZES, INTEGER
*>          If NSIZES = 0, no testing of randomly generated examples
*>          is done, but any precomputed examples are tested.
*>
*> line 3:  NN, INTEGER array, dimension(NSIZES)
*>
*> line 4:  NB, NBMIN, NX, NS, NBCOL, INTEGERs
*>
*> line 5:  THRESH, REAL
*>
*> line 6:  NEWSD, INTEGER
*>
*> If line 6 was 2:
*>
*> line 7:  INTEGER array, dimension (4)
*>
*> lines 8 and following: The first line contains 'CSX' in columns 1-3
*>          followed by the number of matrix types, possibly with
*>          a second line to specify certain matrix types.
*>          If the number of matrix types = 0, no testing of randomly
*>          generated examples is done, but any precomputed examples
*>          are tested.
*>
*> remaining lines : Each matrix is stored on 3+N**2 lines, where N is
*>          its dimension. The first line contains the dimension N, the
*>          dimension M of an invariant subspace, and ISRT. The second
*>          line contains M integers, identifying the eigenvalues in the
*>          invariant subspace (by their position in a list of
*>          eigenvalues ordered by increasing real part (if ISRT=0) or
*>          by increasing imaginary part (if ISRT=1)). The next N**2
*>          lines contain the matrix rowwise. The last line contains the
*>          reciprocal condition number for the average of the selected
*>          eigenvalues, and the reciprocal condition number for the
*>          corresponding right invariant subspace. The end of data in
*>          indicated by a line containing N=0, M=0, and ISRT = 0.  Even
*>          if no data is to be tested, there must be at least one line
*>          containing N=0, M=0 and ISRT=0.
*>
*>-----------------------------------------------------------------------
*>
*> CGG input file:
*>
*> line 2:  NN, INTEGER
*>          Number of values of N.
*>
*> line 3:  NVAL, INTEGER array, dimension (NN)
*>          The values for the matrix dimension N.
*>
*> line 4:  NPARMS, INTEGER
*>          Number of values of the parameters NB, NBMIN, NBCOL, NS, and
*>          MAXB.
*>
*> line 5:  NBVAL, INTEGER array, dimension (NPARMS)
*>          The values for the blocksize NB.
*>
*> line 6:  NBMIN, INTEGER array, dimension (NPARMS)
*>          The values for NBMIN, the minimum row dimension for blocks.
*>
*> line 7:  NSVAL, INTEGER array, dimension (NPARMS)
*>          The values for the number of shifts.
*>
*> line 8:  MXBVAL, INTEGER array, dimension (NPARMS)
*>          The values for MAXB, used in determining minimum blocksize.
*>
*> line 9:  IACC22, INTEGER array, dimension (NPARMS)
*>          select structured matrix multiply: 1 or 2)
*>
*> line 10: NBCOL, INTEGER array, dimension (NPARMS)
*>          The values for NBCOL, the minimum column dimension for
*>          blocks.
*>
*> line 11: THRESH
*>          Threshold value for the test ratios.  Information will be
*>          printed about each test for which the test ratio is greater
*>          than or equal to the threshold.
*>
*> line 12: TSTCHK, LOGICAL
*>          Flag indicating whether or not to test the LAPACK routines.
*>
*> line 13: TSTDRV, LOGICAL
*>          Flag indicating whether or not to test the driver routines.
*>
*> line 14: TSTERR, LOGICAL
*>          Flag indicating whether or not to test the error exits for
*>          the LAPACK routines and driver routines.
*>
*> line 15: NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 15 was 2:
*>
*> line 16: INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 17-EOF:  Lines specifying matrix types, as for NEP.
*>          The 3-character path name is 'CGG' for the generalized
*>          eigenvalue problem routines and driver routines.
*>
*>-----------------------------------------------------------------------
*>
*> CGS and CGV input files:
*>
*> line 1:  'CGS' or 'CGV' in columns 1 to 3.
*>
*> line 2:  NN, INTEGER
*>          Number of values of N.
*>
*> line 3:  NVAL, INTEGER array, dimension(NN)
*>          Dimensions of matrices to be tested.
*>
*> line 4:  NB, NBMIN, NX, NS, NBCOL, INTEGERs
*>          These integer parameters determine how blocking is done
*>          (see ILAENV for details)
*>          NB     : block size
*>          NBMIN  : minimum block size
*>          NX     : minimum dimension for blocking
*>          NS     : number of shifts in xHGEQR
*>          NBCOL  : minimum column dimension for blocking
*>
*> line 5:  THRESH, REAL
*>          The test threshold against which computed residuals are
*>          compared. Should generally be in the range from 10. to 20.
*>          If it is 0., all test case data will be printed.
*>
*> line 6:  TSTERR, LOGICAL
*>          Flag indicating whether or not to test the error exits.
*>
*> line 7:  NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 17 was 2:
*>
*> line 7:  INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 7-EOF:  Lines specifying matrix types, as for NEP.
*>          The 3-character path name is 'CGS' for the generalized
*>          eigenvalue problem routines and driver routines.
*>
*>-----------------------------------------------------------------------
*>
*> CGX input file:
*> line 1:  'CGX' in columns 1 to 3.
*>
*> line 2:  N, INTEGER
*>          Value of N.
*>
*> line 3:  NB, NBMIN, NX, NS, NBCOL, INTEGERs
*>          These integer parameters determine how blocking is done
*>          (see ILAENV for details)
*>          NB     : block size
*>          NBMIN  : minimum block size
*>          NX     : minimum dimension for blocking
*>          NS     : number of shifts in xHGEQR
*>          NBCOL  : minimum column dimension for blocking
*>
*> line 4:  THRESH, REAL
*>          The test threshold against which computed residuals are
*>          compared. Should generally be in the range from 10. to 20.
*>          Information will be printed about each test for which the
*>          test ratio is greater than or equal to the threshold.
*>
*> line 5:  TSTERR, LOGICAL
*>          Flag indicating whether or not to test the error exits for
*>          the LAPACK routines and driver routines.
*>
*> line 6:  NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 6 was 2:
*>
*> line 7: INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> If line 2 was 0:
*>
*> line 7-EOF: Precomputed examples are tested.
*>
*> remaining lines : Each example is stored on 3+2*N*N lines, where N is
*>          its dimension. The first line contains the dimension (a
*>          single integer).  The next line contains an integer k such
*>          that only the last k eigenvalues will be selected and appear
*>          in the leading diagonal blocks of $A$ and $B$. The next N*N
*>          lines contain the matrix A, one element per line. The next N*N
*>          lines contain the matrix B. The last line contains the
*>          reciprocal of the eigenvalue cluster condition number and the
*>          reciprocal of the deflating subspace (associated with the
*>          selected eigencluster) condition number.  The end of data is
*>          indicated by dimension N=0.  Even if no data is to be tested,
*>          there must be at least one line containing N=0.
*>
*>-----------------------------------------------------------------------
*>
*> CXV input files:
*> line 1:  'CXV' in columns 1 to 3.
*>
*> line 2:  N, INTEGER
*>          Value of N.
*>
*> line 3:  NB, NBMIN, NX, NS, NBCOL, INTEGERs
*>          These integer parameters determine how blocking is done
*>          (see ILAENV for details)
*>          NB     : block size
*>          NBMIN  : minimum block size
*>          NX     : minimum dimension for blocking
*>          NS     : number of shifts in xHGEQR
*>          NBCOL  : minimum column dimension for blocking
*>
*> line 4:  THRESH, REAL
*>          The test threshold against which computed residuals are
*>          compared. Should generally be in the range from 10. to 20.
*>          Information will be printed about each test for which the
*>          test ratio is greater than or equal to the threshold.
*>
*> line 5:  TSTERR, LOGICAL
*>          Flag indicating whether or not to test the error exits for
*>          the LAPACK routines and driver routines.
*>
*> line 6:  NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 6 was 2:
*>
*> line 7: INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> If line 2 was 0:
*>
*> line 7-EOF: Precomputed examples are tested.
*>
*> remaining lines : Each example is stored on 3+2*N*N lines, where N is
*>          its dimension. The first line contains the dimension (a
*>          single integer). The next N*N lines contain the matrix A, one
*>          element per line. The next N*N lines contain the matrix B.
*>          The next line contains the reciprocals of the eigenvalue
*>          condition numbers.  The last line contains the reciprocals of
*>          the eigenvector condition numbers.  The end of data is
*>          indicated by dimension N=0.  Even if no data is to be tested,
*>          there must be at least one line containing N=0.
*>
*>-----------------------------------------------------------------------
*>
*> CHB input file:
*>
*> line 2:  NN, INTEGER
*>          Number of values of N.
*>
*> line 3:  NVAL, INTEGER array, dimension (NN)
*>          The values for the matrix dimension N.
*>
*> line 4:  NK, INTEGER
*>          Number of values of K.
*>
*> line 5:  KVAL, INTEGER array, dimension (NK)
*>          The values for the matrix dimension K.
*>
*> line 6:  THRESH
*>          Threshold value for the test ratios.  Information will be
*>          printed about each test for which the test ratio is greater
*>          than or equal to the threshold.
*>
*> line 7:  NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 7 was 2:
*>
*> line 8:  INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 8-EOF:  Lines specifying matrix types, as for NEP.
*>          The 3-character path name is 'CHB'.
*>
*>-----------------------------------------------------------------------
*>
*> CBB input file:
*>
*> line 2:  NN, INTEGER
*>          Number of values of M and N.
*>
*> line 3:  MVAL, INTEGER array, dimension (NN)
*>          The values for the matrix row dimension M.
*>
*> line 4:  NVAL, INTEGER array, dimension (NN)
*>          The values for the matrix column dimension N.
*>
*> line 4:  NK, INTEGER
*>          Number of values of K.
*>
*> line 5:  KVAL, INTEGER array, dimension (NK)
*>          The values for the matrix bandwidth K.
*>
*> line 6:  NPARMS, INTEGER
*>          Number of values of the parameter NRHS
*>
*> line 7:  NSVAL, INTEGER array, dimension (NPARMS)
*>          The values for the number of right hand sides NRHS.
*>
*> line 8:  THRESH
*>          Threshold value for the test ratios.  Information will be
*>          printed about each test for which the test ratio is greater
*>          than or equal to the threshold.
*>
*> line 9:  NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 9 was 2:
*>
*> line 10: INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 10-EOF:  Lines specifying matrix types, as for SVD.
*>          The 3-character path name is 'CBB'.
*>
*>-----------------------------------------------------------------------
*>
*> CEC input file:
*>
*> line  2: THRESH, REAL
*>          Threshold value for the test ratios.  Information will be
*>          printed about each test for which the test ratio is greater
*>          than or equal to the threshold.
*>
*> lines  3-EOF:
*>
*> Input for testing the eigencondition routines consists of a set of
*> specially constructed test cases and their solutions.  The data
*> format is not intended to be modified by the user.
*>
*>-----------------------------------------------------------------------
*>
*> CBL and CBK input files:
*>
*> line 1:  'CBL' in columns 1-3 to test CGEBAL, or 'CBK' in
*>          columns 1-3 to test CGEBAK.
*>
*> The remaining lines consist of specially constructed test cases.
*>
*>-----------------------------------------------------------------------
*>
*> CGL and CGK input files:
*>
*> line 1:  'CGL' in columns 1-3 to test CGGBAL, or 'CGK' in
*>          columns 1-3 to test CGGBAK.
*>
*> The remaining lines consist of specially constructed test cases.
*>
*>-----------------------------------------------------------------------
*>
*> GLM data file:
*>
*> line 1:  'GLM' in columns 1 to 3.
*>
*> line 2:  NN, INTEGER
*>          Number of values of M, P, and N.
*>
*> line 3:  MVAL, INTEGER array, dimension(NN)
*>          Values of M (row dimension).
*>
*> line 4:  PVAL, INTEGER array, dimension(NN)
*>          Values of P (row dimension).
*>
*> line 5:  NVAL, INTEGER array, dimension(NN)
*>          Values of N (column dimension), note M <= N <= M+P.
*>
*> line 6:  THRESH, REAL
*>          Threshold value for the test ratios.  Information will be
*>          printed about each test for which the test ratio is greater
*>          than or equal to the threshold.
*>
*> line 7:  TSTERR, LOGICAL
*>          Flag indicating whether or not to test the error exits for
*>          the LAPACK routines and driver routines.
*>
*> line 8:  NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 8 was 2:
*>
*> line 9:  INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 9-EOF:  Lines specifying matrix types, as for NEP.
*>          The 3-character path name is 'GLM' for the generalized
*>          linear regression model routines.
*>
*>-----------------------------------------------------------------------
*>
*> GQR data file:
*>
*> line 1:  'GQR' in columns 1 to 3.
*>
*> line 2:  NN, INTEGER
*>          Number of values of M, P, and N.
*>
*> line 3:  MVAL, INTEGER array, dimension(NN)
*>          Values of M.
*>
*> line 4:  PVAL, INTEGER array, dimension(NN)
*>          Values of P.
*>
*> line 5:  NVAL, INTEGER array, dimension(NN)
*>          Values of N.
*>
*> line 6:  THRESH, REAL
*>          Threshold value for the test ratios.  Information will be
*>          printed about each test for which the test ratio is greater
*>          than or equal to the threshold.
*>
*> line 7:  TSTERR, LOGICAL
*>          Flag indicating whether or not to test the error exits for
*>          the LAPACK routines and driver routines.
*>
*> line 8:  NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 8 was 2:
*>
*> line 9:  INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 9-EOF:  Lines specifying matrix types, as for NEP.
*>          The 3-character path name is 'GQR' for the generalized
*>          QR and RQ routines.
*>
*>-----------------------------------------------------------------------
*>
*> GSV data file:
*>
*> line 1:  'GSV' in columns 1 to 3.
*>
*> line 2:  NN, INTEGER
*>          Number of values of M, P, and N.
*>
*> line 3:  MVAL, INTEGER array, dimension(NN)
*>          Values of M (row dimension).
*>
*> line 4:  PVAL, INTEGER array, dimension(NN)
*>          Values of P (row dimension).
*>
*> line 5:  NVAL, INTEGER array, dimension(NN)
*>          Values of N (column dimension).
*>
*> line 6:  THRESH, REAL
*>          Threshold value for the test ratios.  Information will be
*>          printed about each test for which the test ratio is greater
*>          than or equal to the threshold.
*>
*> line 7:  TSTERR, LOGICAL
*>          Flag indicating whether or not to test the error exits for
*>          the LAPACK routines and driver routines.
*>
*> line 8:  NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 8 was 2:
*>
*> line 9:  INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 9-EOF:  Lines specifying matrix types, as for NEP.
*>          The 3-character path name is 'GSV' for the generalized
*>          SVD routines.
*>
*>-----------------------------------------------------------------------
*>
*> CSD data file:
*>
*> line 1:  'CSD' in columns 1 to 3.
*>
*> line 2:  NM, INTEGER
*>          Number of values of M, P, and N.
*>
*> line 3:  MVAL, INTEGER array, dimension(NM)
*>          Values of M (row and column dimension of orthogonal matrix).
*>
*> line 4:  PVAL, INTEGER array, dimension(NM)
*>          Values of P (row dimension of top-left block).
*>
*> line 5:  NVAL, INTEGER array, dimension(NM)
*>          Values of N (column dimension of top-left block).
*>
*> line 6:  THRESH, REAL
*>          Threshold value for the test ratios.  Information will be
*>          printed about each test for which the test ratio is greater
*>          than or equal to the threshold.
*>
*> line 7:  TSTERR, LOGICAL
*>          Flag indicating whether or not to test the error exits for
*>          the LAPACK routines and driver routines.
*>
*> line 8:  NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 8 was 2:
*>
*> line 9:  INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 9-EOF:  Lines specifying matrix types, as for NEP.
*>          The 3-character path name is 'CSD' for the CSD routine.
*>
*>-----------------------------------------------------------------------
*>
*> LSE data file:
*>
*> line 1:  'LSE' in columns 1 to 3.
*>
*> line 2:  NN, INTEGER
*>          Number of values of M, P, and N.
*>
*> line 3:  MVAL, INTEGER array, dimension(NN)
*>          Values of M.
*>
*> line 4:  PVAL, INTEGER array, dimension(NN)
*>          Values of P.
*>
*> line 5:  NVAL, INTEGER array, dimension(NN)
*>          Values of N, note P <= N <= P+M.
*>
*> line 6:  THRESH, REAL
*>          Threshold value for the test ratios.  Information will be
*>          printed about each test for which the test ratio is greater
*>          than or equal to the threshold.
*>
*> line 7:  TSTERR, LOGICAL
*>          Flag indicating whether or not to test the error exits for
*>          the LAPACK routines and driver routines.
*>
*> line 8:  NEWSD, INTEGER
*>          A code indicating how to set the random number seed.
*>          = 0:  Set the seed to a default value before each run
*>          = 1:  Initialize the seed to a default value only before the
*>                first run
*>          = 2:  Like 1, but use the seed values on the next line
*>
*> If line 8 was 2:
*>
*> line 9:  INTEGER array, dimension (4)
*>          Four integer values for the random number seed.
*>
*> lines 9-EOF:  Lines specifying matrix types, as for NEP.
*>          The 3-character path name is 'GSV' for the generalized
*>          SVD routines.
*>
*>-----------------------------------------------------------------------
*>
*> NMAX is currently set to 132 and must be at least 12 for some of the
*> precomputed examples, and LWORK = NMAX*(5*NMAX+20) in the parameter
*> statements below.  For SVD, we assume NRHS may be as big as N.  The
*> parameter NEED is set to 14 to allow for 14 N-by-N matrices for CGG.
*> \endverbatim
*
*  Arguments:
*  ==========
*
*
*  Authors:
*  ========
*
*> \author Univ. of Tennessee
*> \author Univ. of California Berkeley
*> \author Univ. of Colorado Denver
*> \author NAG Ltd.
*
*> \date June 2016
*
*> \ingroup complex_eig
*
*  =====================================================================
      PROGRAM CCHKEE
*
#if defined(_OPENMP)
      use omp_lib
#endif
*
*  -- LAPACK test routine (version 3.7.0) --
*  -- LAPACK is a software package provided by Univ. of Tennessee,    --
*  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
*     June 2016
*
*  =====================================================================
*
*     .. Parameters ..
      INTEGER            NMAX
      PARAMETER          ( NMAX = 132 )
      INTEGER            NCMAX
      PARAMETER          ( NCMAX = 20 )
      INTEGER            NEED
      PARAMETER          ( NEED = 14 )
      INTEGER            LWORK
      PARAMETER          ( LWORK = NMAX*( 5*NMAX+20 ) )
      INTEGER            LIWORK
      PARAMETER          ( LIWORK = NMAX*( NMAX+20 ) )
      INTEGER            MAXIN
      PARAMETER          ( MAXIN = 20 )
      INTEGER            MAXT
      PARAMETER          ( MAXT = 30 )
      INTEGER            NIN, NOUT
      PARAMETER          ( NIN = 5, NOUT = 6 )
*     ..
*     .. Local Scalars ..
      LOGICAL            CBB, CBK, CBL, CES, CEV, CGG, CGK, CGL, CGS,
     $                   CGV, CGX, CHB, CSD, CSX, CVX, CXV, FATAL, GLM,
     $                   GQR, GSV, LSE, NEP, SEP, SVD, TSTCHK, TSTDIF,
     $                   TSTDRV, TSTERR
      CHARACTER          C1
      CHARACTER*3        C3, PATH
      CHARACTER*32       VNAME
      CHARACTER*10       INTSTR
      CHARACTER*80       LINE
      INTEGER            I, I1, IC, INFO, ITMP, K, LENP, MAXTYP, NEWSD,
     $                   NK, NN, NPARMS, NRHS, NTYPES,
     $                   VERS_MAJOR, VERS_MINOR, VERS_PATCH
      INTEGER*4          N_THREADS, ONE_THREAD
      REAL               EPS, S1, S2, THRESH, THRSHN
*     ..
*     .. Local Arrays ..
      LOGICAL            DOTYPE( MAXT ), LOGWRK( NMAX )
      INTEGER            IOLDSD( 4 ), ISEED( 4 ), IWORK( LIWORK ),
     $                   KVAL( MAXIN ), MVAL( MAXIN ), MXBVAL( MAXIN ),
     $                   NBCOL( MAXIN ), NBMIN( MAXIN ), NBVAL( MAXIN ),
     $                   NSVAL( MAXIN ), NVAL( MAXIN ), NXVAL( MAXIN ),
     $                   PVAL( MAXIN )
      INTEGER            INMIN( MAXIN ), INWIN( MAXIN ), INIBL( MAXIN ),
     $                   ISHFTS( MAXIN ), IACC22( MAXIN )
      REAL               ALPHA( NMAX ), BETA( NMAX ), DR( NMAX, 12 ),
     $                   RESULT( 500 )
      COMPLEX            DC( NMAX, 6 ), TAUA( NMAX ), TAUB( NMAX ),
     $                   X( 5*NMAX )
*     ..
*     .. Allocatable Arrays ..
      INTEGER AllocateStatus
      REAL, DIMENSION(:), ALLOCATABLE :: RWORK, S
      COMPLEX, DIMENSION(:), ALLOCATABLE :: WORK
      COMPLEX, DIMENSION(:,:), ALLOCATABLE :: A, B, C
*     ..
*     .. External Functions ..
      LOGICAL            LSAMEN
      REAL               SECOND, SLAMCH
      EXTERNAL           LSAMEN, SECOND, SLAMCH
*     ..
*     .. External Subroutines ..
      EXTERNAL           ALAREQ, CCHKBB, CCHKBD, CCHKBK, CCHKBL, CCHKEC,
     $                   CCHKGG, CCHKGK, CCHKGL, CCHKHB, CCHKHS, CCHKST,
     $                   CCKCSD, CCKGLM, CCKGQR, CCKGSV, CCKLSE, CDRGES,
     $                   CDRGEV, CDRGSX, CDRGVX, CDRVBD, CDRVES, CDRVEV,
     $                   CDRVSG, CDRVST, CDRVSX, CDRVVX, CERRBD,
     $                   CERRED, CERRGG, CERRHS, CERRST, ILAVER, XLAENV,
     $                   CDRGES3, CDRGEV3, 
     $                   CCHKST2STG, CDRVST2STG, CCHKHB2STG
*     ..
*     .. Intrinsic Functions ..
      INTRINSIC          LEN, MIN
*     ..
*     .. Scalars in Common ..
      LOGICAL            LERR, OK
      CHARACTER*32       SRNAMT
      INTEGER            INFOT, MAXB, NPROC, NSHIFT, NUNIT, SELDIM,
     $                   SELOPT
*     ..
*     .. Arrays in Common ..
      LOGICAL            SELVAL( 20 )
      INTEGER            IPARMS( 100 )
      REAL               SELWI( 20 ), SELWR( 20 )
*     ..
*     .. Common blocks ..
      COMMON             / CENVIR / NPROC, NSHIFT, MAXB
      COMMON             / CLAENV / IPARMS
      COMMON             / INFOC / INFOT, NUNIT, OK, LERR
      COMMON             / SRNAMC / SRNAMT
      COMMON             / SSLCT / SELOPT, SELDIM, SELVAL, SELWR, SELWI
*     ..
*     .. Data statements ..
      DATA               INTSTR / '0123456789' /
      DATA               IOLDSD / 0, 0, 0, 1 /
*     ..
*     .. Allocate memory dynamically ..
*
      ALLOCATE ( S(NMAX*NMAX), STAT = AllocateStatus )
      IF (AllocateStatus /= 0) STOP "*** Not enough memory ***"
      ALLOCATE ( A(NMAX*NMAX,NEED), STAT = AllocateStatus )
      IF (AllocateStatus /= 0) STOP "*** Not enough memory ***"
      ALLOCATE ( B(NMAX*NMAX,5), STAT = AllocateStatus )
      IF (AllocateStatus /= 0) STOP "*** Not enough memory ***"
      ALLOCATE ( C(NCMAX*NCMAX,NCMAX*NCMAX), STAT = AllocateStatus )
      IF (AllocateStatus /= 0) STOP "*** Not enough memory ***"
      ALLOCATE ( RWORK(LWORK), STAT = AllocateStatus )
      IF (AllocateStatus /= 0) STOP "*** Not enough memory ***"
      ALLOCATE ( WORK(LWORK), STAT = AllocateStatus )
      IF (AllocateStatus /= 0) STOP "*** Not enough memory ***"
*     ..
*     .. Executable Statements ..
*
      A = 0.0
      B = 0.0
      C = 0.0
      DC = 0.0
      S1 = SECOND( )
      FATAL = .FALSE.
      NUNIT = NOUT
*
*     Return to here to read multiple sets of data
*
   10 CONTINUE
*
*     Read the first line and set the 3-character test path
*
      READ( NIN, FMT = '(A80)', END = 380 )LINE
      PATH = LINE( 1: 3 )
      NEP = LSAMEN( 3, PATH, 'NEP' ) .OR. LSAMEN( 3, PATH, 'CHS' )
      SEP = LSAMEN( 3, PATH, 'SEP' ) .OR. LSAMEN( 3, PATH, 'CST' ) .OR.
     $      LSAMEN( 3, PATH, 'CSG' ) .OR. LSAMEN( 3, PATH, 'SE2' )
      SVD = LSAMEN( 3, PATH, 'SVD' ) .OR. LSAMEN( 3, PATH, 'CBD' )
      CEV = LSAMEN( 3, PATH, 'CEV' )
      CES = LSAMEN( 3, PATH, 'CES' )
      CVX = LSAMEN( 3, PATH, 'CVX' )
      CSX = LSAMEN( 3, PATH, 'CSX' )
      CGG = LSAMEN( 3, PATH, 'CGG' )
      CGS = LSAMEN( 3, PATH, 'CGS' )
      CGX = LSAMEN( 3, PATH, 'CGX' )
      CGV = LSAMEN( 3, PATH, 'CGV' )
      CXV = LSAMEN( 3, PATH, 'CXV' )
      CHB = LSAMEN( 3, PATH, 'CHB' )
      CBB = LSAMEN( 3, PATH, 'CBB' )
      GLM = LSAMEN( 3, PATH, 'GLM' )
      GQR = LSAMEN( 3, PATH, 'GQR' ) .OR. LSAMEN( 3, PATH, 'GRQ' )
      GSV = LSAMEN( 3, PATH, 'GSV' )
      CSD = LSAMEN( 3, PATH, 'CSD' )
      LSE = LSAMEN( 3, PATH, 'LSE' )
      CBL = LSAMEN( 3, PATH, 'CBL' )
      CBK = LSAMEN( 3, PATH, 'CBK' )
      CGL = LSAMEN( 3, PATH, 'CGL' )
      CGK = LSAMEN( 3, PATH, 'CGK' )
*
*     Report values of parameters.
*
      IF( PATH.EQ.'   ' ) THEN
         GO TO 10
      ELSE IF( NEP ) THEN
         WRITE( NOUT, FMT = 9987 )
      ELSE IF( SEP ) THEN
         WRITE( NOUT, FMT = 9986 )
      ELSE IF( SVD ) THEN
         WRITE( NOUT, FMT = 9985 )
      ELSE IF( CEV ) THEN
         WRITE( NOUT, FMT = 9979 )
      ELSE IF( CES ) THEN
         WRITE( NOUT, FMT = 9978 )
      ELSE IF( CVX ) THEN
         WRITE( NOUT, FMT = 9977 )
      ELSE IF( CSX ) THEN
         WRITE( NOUT, FMT = 9976 )
      ELSE IF( CGG ) THEN
         WRITE( NOUT, FMT = 9975 )
      ELSE IF( CGS ) THEN
         WRITE( NOUT, FMT = 9964 )
      ELSE IF( CGX ) THEN
         WRITE( NOUT, FMT = 9965 )
      ELSE IF( CGV ) THEN
         WRITE( NOUT, FMT = 9963 )
      ELSE IF( CXV ) THEN
         WRITE( NOUT, FMT = 9962 )
      ELSE IF( CHB ) THEN
         WRITE( NOUT, FMT = 9974 )
      ELSE IF( CBB ) THEN
         WRITE( NOUT, FMT = 9967 )
      ELSE IF( GLM ) THEN
         WRITE( NOUT, FMT = 9971 )
      ELSE IF( GQR ) THEN
         WRITE( NOUT, FMT = 9970 )
      ELSE IF( GSV ) THEN
         WRITE( NOUT, FMT = 9969 )
      ELSE IF( CSD ) THEN
         WRITE( NOUT, FMT = 9960 )
      ELSE IF( LSE ) THEN
         WRITE( NOUT, FMT = 9968 )
      ELSE IF( CBL ) THEN
*
*        CGEBAL:  Balancing
*
         CALL CCHKBL( NIN, NOUT )
         GO TO 380
      ELSE IF( CBK ) THEN
*
*        CGEBAK:  Back transformation
*
         CALL CCHKBK( NIN, NOUT )
         GO TO 380
      ELSE IF( CGL ) THEN
*
*        CGGBAL:  Balancing
*
         CALL CCHKGL( NIN, NOUT )
         GO TO 380
      ELSE IF( CGK ) THEN
*
*        CGGBAK:  Back transformation
*
         CALL CCHKGK( NIN, NOUT )
         GO TO 380
      ELSE IF( LSAMEN( 3, PATH, 'CEC' ) ) THEN
*
*        CEC:  Eigencondition estimation
*
         READ( NIN, FMT = * )THRESH
         CALL XLAENV( 1, 1 )
         CALL XLAENV( 12, 1 )
         TSTERR = .TRUE.
         CALL CCHKEC( THRESH, TSTERR, NIN, NOUT )
         GO TO 380
      ELSE
         WRITE( NOUT, FMT = 9992 )PATH
         GO TO 380
      END IF
      CALL ILAVER( VERS_MAJOR, VERS_MINOR, VERS_PATCH )
      WRITE( NOUT, FMT = 9972 ) VERS_MAJOR, VERS_MINOR, VERS_PATCH
      WRITE( NOUT, FMT = 9984 )
*
*     Read the number of values of M, P, and N.
*
      READ( NIN, FMT = * )NN
      IF( NN.LT.0 ) THEN
         WRITE( NOUT, FMT = 9989 )'   NN ', NN, 1
         NN = 0
         FATAL = .TRUE.
      ELSE IF( NN.GT.MAXIN ) THEN
         WRITE( NOUT, FMT = 9988 )'   NN ', NN, MAXIN
         NN = 0
         FATAL = .TRUE.
      END IF
*
*     Read the values of M
*
      IF( .NOT.( CGX .OR. CXV ) ) THEN
         READ( NIN, FMT = * )( MVAL( I ), I = 1, NN )
         IF( SVD ) THEN
            VNAME = '    M '
         ELSE
            VNAME = '    N '
         END IF
         DO 20 I = 1, NN
            IF( MVAL( I ).LT.0 ) THEN
               WRITE( NOUT, FMT = 9989 )VNAME, MVAL( I ), 0
               FATAL = .TRUE.
            ELSE IF( MVAL( I ).GT.NMAX ) THEN
               WRITE( NOUT, FMT = 9988 )VNAME, MVAL( I ), NMAX
               FATAL = .TRUE.
            END IF
   20    CONTINUE
         WRITE( NOUT, FMT = 9983 )'M:    ', ( MVAL( I ), I = 1, NN )
      END IF
*
*     Read the values of P
*
      IF( GLM .OR. GQR .OR. GSV .OR. CSD .OR. LSE ) THEN
         READ( NIN, FMT = * )( PVAL( I ), I = 1, NN )
         DO 30 I = 1, NN
            IF( PVAL( I ).LT.0 ) THEN
               WRITE( NOUT, FMT = 9989 )' P  ', PVAL( I ), 0
               FATAL = .TRUE.
            ELSE IF( PVAL( I ).GT.NMAX ) THEN
               WRITE( NOUT, FMT = 9988 )' P  ', PVAL( I ), NMAX
               FATAL = .TRUE.
            END IF
   30    CONTINUE
         WRITE( NOUT, FMT = 9983 )'P:    ', ( PVAL( I ), I = 1, NN )
      END IF
*
*     Read the values of N
*
      IF( SVD .OR. CBB .OR. GLM .OR. GQR .OR. GSV .OR. CSD .OR.
     $    LSE ) THEN
         READ( NIN, FMT = * )( NVAL( I ), I = 1, NN )
         DO 40 I = 1, NN
            IF( NVAL( I ).LT.0 ) THEN
               WRITE( NOUT, FMT = 9989 )'    N ', NVAL( I ), 0
               FATAL = .TRUE.
            ELSE IF( NVAL( I ).GT.NMAX ) THEN
               WRITE( NOUT, FMT = 9988 )'    N ', NVAL( I ), NMAX
               FATAL = .TRUE.
            END IF
   40    CONTINUE
      ELSE
         DO 50 I = 1, NN
            NVAL( I ) = MVAL( I )
   50    CONTINUE
      END IF
      IF( .NOT.( CGX .OR. CXV ) ) THEN
         WRITE( NOUT, FMT = 9983 )'N:    ', ( NVAL( I ), I = 1, NN )
      ELSE
         WRITE( NOUT, FMT = 9983 )'N:    ', NN
      END IF
*
*     Read the number of values of K, followed by the values of K
*
      IF( CHB .OR. CBB ) THEN
         READ( NIN, FMT = * )NK
         READ( NIN, FMT = * )( KVAL( I ), I = 1, NK )
         DO 60 I = 1, NK
            IF( KVAL( I ).LT.0 ) THEN
               WRITE( NOUT, FMT = 9989 )'    K ', KVAL( I ), 0
               FATAL = .TRUE.
            ELSE IF( KVAL( I ).GT.NMAX ) THEN
               WRITE( NOUT, FMT = 9988 )'    K ', KVAL( I ), NMAX
               FATAL = .TRUE.
            END IF
   60    CONTINUE
         WRITE( NOUT, FMT = 9983 )'K:    ', ( KVAL( I ), I = 1, NK )
      END IF
*
      IF( CEV .OR. CES .OR. CVX .OR. CSX ) THEN
*
*        For the nonsymmetric QR driver routines, only one set of
*        parameters is allowed.
*
         READ( NIN, FMT = * )NBVAL( 1 ), NBMIN( 1 ), NXVAL( 1 ),
     $      INMIN( 1 ), INWIN( 1 ), INIBL(1), ISHFTS(1), IACC22(1)
         IF( NBVAL( 1 ).LT.1 ) THEN
            WRITE( NOUT, FMT = 9989 )'   NB ', NBVAL( 1 ), 1
            FATAL = .TRUE.
         ELSE IF( NBMIN( 1 ).LT.1 ) THEN
            WRITE( NOUT, FMT = 9989 )'NBMIN ', NBMIN( 1 ), 1
            FATAL = .TRUE.
         ELSE IF( NXVAL( 1 ).LT.1 ) THEN
            WRITE( NOUT, FMT = 9989 )'   NX ', NXVAL( 1 ), 1
            FATAL = .TRUE.
         ELSE IF( INMIN( 1 ).LT.1 ) THEN
            WRITE( NOUT, FMT = 9989 )'   INMIN ', INMIN( 1 ), 1
            FATAL = .TRUE.
         ELSE IF( INWIN( 1 ).LT.1 ) THEN
            WRITE( NOUT, FMT = 9989 )'   INWIN ', INWIN( 1 ), 1
            FATAL = .TRUE.
         ELSE IF( INIBL( 1 ).LT.1 ) THEN
            WRITE( NOUT, FMT = 9989 )'   INIBL ', INIBL( 1 ), 1
            FATAL = .TRUE.
         ELSE IF( ISHFTS( 1 ).LT.1 ) THEN
            WRITE( NOUT, FMT = 9989 )'   ISHFTS ', ISHFTS( 1 ), 1
            FATAL = .TRUE.
         ELSE IF( IACC22( 1 ).LT.0 ) THEN
            WRITE( NOUT, FMT = 9989 )'   IACC22 ', IACC22( 1 ), 0
            FATAL = .TRUE.
         END IF
         CALL XLAENV( 1, NBVAL( 1 ) )
         CALL XLAENV( 2, NBMIN( 1 ) )
         CALL XLAENV( 3, NXVAL( 1 ) )
         CALL XLAENV(12, MAX( 11, INMIN( 1 ) ) )
         CALL XLAENV(13, INWIN( 1 ) )
         CALL XLAENV(14, INIBL( 1 ) )
         CALL XLAENV(15, ISHFTS( 1 ) )
         CALL XLAENV(16, IACC22( 1 ) )
         WRITE( NOUT, FMT = 9983 )'NB:   ', NBVAL( 1 )
         WRITE( NOUT, FMT = 9983 )'NBMIN:', NBMIN( 1 )
         WRITE( NOUT, FMT = 9983 )'NX:   ', NXVAL( 1 )
         WRITE( NOUT, FMT = 9983 )'INMIN:   ', INMIN( 1 )
         WRITE( NOUT, FMT = 9983 )'INWIN: ', INWIN( 1 )
         WRITE( NOUT, FMT = 9983 )'INIBL: ', INIBL( 1 )
         WRITE( NOUT, FMT = 9983 )'ISHFTS: ', ISHFTS( 1 )
         WRITE( NOUT, FMT = 9983 )'IACC22: ', IACC22( 1 )
*
      ELSE IF( CGS .OR. CGX .OR. CGV .OR. CXV ) THEN
*
*        For the nonsymmetric generalized driver routines, only one set of
*        parameters is allowed.
*
         READ( NIN, FMT = * )NBVAL( 1 ), NBMIN( 1 ), NXVAL( 1 ),
     $      NSVAL( 1 ), MXBVAL( 1 )
         IF( NBVAL( 1 ).LT.1 ) THEN
            WRITE( NOUT, FMT = 9989 )'   NB ', NBVAL( 1 ), 1
            FATAL = .TRUE.
         ELSE IF( NBMIN( 1 ).LT.1 ) THEN
            WRITE( NOUT, FMT = 9989 )'NBMIN ', NBMIN( 1 ), 1
            FATAL = .TRUE.
         ELSE IF( NXVAL( 1 ).LT.1 ) THEN
            WRITE( NOUT, FMT = 9989 )'   NX ', NXVAL( 1 ), 1
            FATAL = .TRUE.
         ELSE IF( NSVAL( 1 ).LT.2 ) THEN
            WRITE( NOUT, FMT = 9989 )'   NS ', NSVAL( 1 ), 2
            FATAL = .TRUE.
         ELSE IF( MXBVAL( 1 ).LT.1 ) THEN
            WRITE( NOUT, FMT = 9989 )' MAXB ', MXBVAL( 1 ), 1
            FATAL = .TRUE.
         END IF
         CALL XLAENV( 1, NBVAL( 1 ) )
         CALL XLAENV( 2, NBMIN( 1 ) )
         CALL XLAENV( 3, NXVAL( 1 ) )
         CALL XLAENV( 4, NSVAL( 1 ) )
         CALL XLAENV( 8, MXBVAL( 1 ) )
         WRITE( NOUT, FMT = 9983 )'NB:   ', NBVAL( 1 )
         WRITE( NOUT, FMT = 9983 )'NBMIN:', NBMIN( 1 )
         WRITE( NOUT, FMT = 9983 )'NX:   ', NXVAL( 1 )
         WRITE( NOUT, FMT = 9983 )'NS:   ', NSVAL( 1 )
         WRITE( NOUT, FMT = 9983 )'MAXB: ', MXBVAL( 1 )
      ELSE IF( .NOT.CHB .AND. .NOT.GLM .AND. .NOT.GQR .AND. .NOT.
     $         GSV .AND. .NOT.CSD .AND. .NOT.LSE ) THEN
*
*        For the other paths, the number of parameters can be varied
*        from the input file.  Read the number of parameter values.
*
         READ( NIN, FMT = * )NPARMS
         IF( NPARMS.LT.1 ) THEN
            WRITE( NOUT, FMT = 9989 )'NPARMS', NPARMS, 1
            NPARMS = 0
            FATAL = .TRUE.
         ELSE IF( NPARMS.GT.MAXIN ) THEN
            WRITE( NOUT, FMT = 9988 )'NPARMS', NPARMS, MAXIN
            NPARMS = 0
            FATAL = .TRUE.
         END IF
*
*        Read the values of NB
*
         IF( .NOT.CBB ) THEN
            READ( NIN, FMT = * )( NBVAL( I ), I = 1, NPARMS )
            DO 70 I = 1, NPARMS
               IF( NBVAL( I ).LT.0 ) THEN
                  WRITE( NOUT, FMT = 9989 )'   NB ', NBVAL( I ), 0
                  FATAL = .TRUE.
               ELSE IF( NBVAL( I ).GT.NMAX ) THEN
                  WRITE( NOUT, FMT = 9988 )'   NB ', NBVAL( I ), NMAX
                  FATAL = .TRUE.
               END IF
   70       CONTINUE
            WRITE( NOUT, FMT = 9983 )'NB:   ',
     $         ( NBVAL( I ), I = 1, NPARMS )
         END IF
*
*        Read the values of NBMIN
*
         IF( NEP .OR. SEP .OR. SVD .OR. CGG ) THEN
            READ( NIN, FMT = * )( NBMIN( I ), I = 1, NPARMS )
            DO 80 I = 1, NPARMS
               IF( NBMIN( I ).LT.0 ) THEN
                  WRITE( NOUT, FMT = 9989 )'NBMIN ', NBMIN( I ), 0
                  FATAL = .TRUE.
               ELSE IF( NBMIN( I ).GT.NMAX ) THEN
                  WRITE( NOUT, FMT = 9988 )'NBMIN ', NBMIN( I ), NMAX
                  FATAL = .TRUE.
               END IF
   80       CONTINUE
            WRITE( NOUT, FMT = 9983 )'NBMIN:',
     $         ( NBMIN( I ), I = 1, NPARMS )
         ELSE
            DO 90 I = 1, NPARMS
               NBMIN( I ) = 1
   90       CONTINUE
         END IF
*
*        Read the values of NX
*
         IF( NEP .OR. SEP .OR. SVD ) THEN
            READ( NIN, FMT = * )( NXVAL( I ), I = 1, NPARMS )
            DO 100 I = 1, NPARMS
               IF( NXVAL( I ).LT.0 ) THEN
                  WRITE( NOUT, FMT = 9989 )'   NX ', NXVAL( I ), 0
                  FATAL = .TRUE.
               ELSE IF( NXVAL( I ).GT.NMAX ) THEN
                  WRITE( NOUT, FMT = 9988 )'   NX ', NXVAL( I ), NMAX
                  FATAL = .TRUE.
               END IF
  100       CONTINUE
            WRITE( NOUT, FMT = 9983 )'NX:   ',
     $         ( NXVAL( I ), I = 1, NPARMS )
         ELSE
            DO 110 I = 1, NPARMS
               NXVAL( I ) = 1
  110       CONTINUE
         END IF
*
*        Read the values of NSHIFT (if CGG) or NRHS (if SVD
*        or CBB).
*
         IF( SVD .OR. CBB .OR. CGG ) THEN
            READ( NIN, FMT = * )( NSVAL( I ), I = 1, NPARMS )
            DO 120 I = 1, NPARMS
               IF( NSVAL( I ).LT.0 ) THEN
                  WRITE( NOUT, FMT = 9989 )'   NS ', NSVAL( I ), 0
                  FATAL = .TRUE.
               ELSE IF( NSVAL( I ).GT.NMAX ) THEN
                  WRITE( NOUT, FMT = 9988 )'   NS ', NSVAL( I ), NMAX
                  FATAL = .TRUE.
               END IF
  120       CONTINUE
            WRITE( NOUT, FMT = 9983 )'NS:   ',
     $         ( NSVAL( I ), I = 1, NPARMS )
         ELSE
            DO 130 I = 1, NPARMS
               NSVAL( I ) = 1
  130       CONTINUE
         END IF
*
*        Read the values for MAXB.
*
         IF( CGG ) THEN
            READ( NIN, FMT = * )( MXBVAL( I ), I = 1, NPARMS )
            DO 140 I = 1, NPARMS
               IF( MXBVAL( I ).LT.0 ) THEN
                  WRITE( NOUT, FMT = 9989 )' MAXB ', MXBVAL( I ), 0
                  FATAL = .TRUE.
               ELSE IF( MXBVAL( I ).GT.NMAX ) THEN
                  WRITE( NOUT, FMT = 9988 )' MAXB ', MXBVAL( I ), NMAX
                  FATAL = .TRUE.
               END IF
  140       CONTINUE
            WRITE( NOUT, FMT = 9983 )'MAXB: ',
     $         ( MXBVAL( I ), I = 1, NPARMS )
         ELSE
            DO 150 I = 1, NPARMS
               MXBVAL( I ) = 1
  150       CONTINUE
         END IF
*
*        Read the values for INMIN.
*
         IF( NEP ) THEN
            READ( NIN, FMT = * )( INMIN( I ), I = 1, NPARMS )
            DO 540 I = 1, NPARMS
               IF( INMIN( I ).LT.0 ) THEN
                  WRITE( NOUT, FMT = 9989 )' INMIN ', INMIN( I ), 0
                  FATAL = .TRUE.
               END IF
  540       CONTINUE
            WRITE( NOUT, FMT = 9983 )'INMIN: ',
     $         ( INMIN( I ), I = 1, NPARMS )
         ELSE
            DO 550 I = 1, NPARMS
               INMIN( I ) = 1
  550       CONTINUE
         END IF
*
*        Read the values for INWIN.
*
         IF( NEP ) THEN
            READ( NIN, FMT = * )( INWIN( I ), I = 1, NPARMS )
            DO 560 I = 1, NPARMS
               IF( INWIN( I ).LT.0 ) THEN
                  WRITE( NOUT, FMT = 9989 )' INWIN ', INWIN( I ), 0
                  FATAL = .TRUE.
               END IF
  560       CONTINUE
            WRITE( NOUT, FMT = 9983 )'INWIN: ',
     $         ( INWIN( I ), I = 1, NPARMS )
         ELSE
            DO 570 I = 1, NPARMS
               INWIN( I ) = 1
  570       CONTINUE
         END IF
*
*        Read the values for INIBL.
*
         IF( NEP ) THEN
            READ( NIN, FMT = * )( INIBL( I ), I = 1, NPARMS )
            DO 580 I = 1, NPARMS
               IF( INIBL( I ).LT.0 ) THEN
                  WRITE( NOUT, FMT = 9989 )' INIBL ', INIBL( I ), 0
                  FATAL = .TRUE.
               END IF
  580       CONTINUE
            WRITE( NOUT, FMT = 9983 )'INIBL: ',
     $         ( INIBL( I ), I = 1, NPARMS )
         ELSE
            DO 590 I = 1, NPARMS
               INIBL( I ) = 1
  590       CONTINUE
         END IF
*
*        Read the values for ISHFTS.
*
         IF( NEP ) THEN
            READ( NIN, FMT = * )( ISHFTS( I ), I = 1, NPARMS )
            DO 600 I = 1, NPARMS
               IF( ISHFTS( I ).LT.0 ) THEN
                  WRITE( NOUT, FMT = 9989 )' ISHFTS ', ISHFTS( I ), 0
                  FATAL = .TRUE.
               END IF
  600       CONTINUE
            WRITE( NOUT, FMT = 9983 )'ISHFTS: ',
     $         ( ISHFTS( I ), I = 1, NPARMS )
         ELSE
            DO 610 I = 1, NPARMS
               ISHFTS( I ) = 1
  610       CONTINUE
         END IF
*
*        Read the values for IACC22.
*
         IF( NEP .OR. CGG ) THEN
            READ( NIN, FMT = * )( IACC22( I ), I = 1, NPARMS )
            DO 620 I = 1, NPARMS
               IF( IACC22( I ).LT.0 ) THEN
                  WRITE( NOUT, FMT = 9989 )' IACC22 ', IACC22( I ), 0
                  FATAL = .TRUE.
               END IF
  620       CONTINUE
            WRITE( NOUT, FMT = 9983 )'IACC22: ',
     $         ( IACC22( I ), I = 1, NPARMS )
         ELSE
            DO 630 I = 1, NPARMS
               IACC22( I ) = 1
  630       CONTINUE
         END IF
*
*        Read the values for NBCOL.
*
         IF( CGG ) THEN
            READ( NIN, FMT = * )( NBCOL( I ), I = 1, NPARMS )
            DO 160 I = 1, NPARMS
               IF( NBCOL( I ).LT.0 ) THEN
                  WRITE( NOUT, FMT = 9989 )'NBCOL ', NBCOL( I ), 0
                  FATAL = .TRUE.
               ELSE IF( NBCOL( I ).GT.NMAX ) THEN
                  WRITE( NOUT, FMT = 9988 )'NBCOL ', NBCOL( I ), NMAX
                  FATAL = .TRUE.
               END IF
  160       CONTINUE
            WRITE( NOUT, FMT = 9983 )'NBCOL:',
     $         ( NBCOL( I ), I = 1, NPARMS )
         ELSE
            DO 170 I = 1, NPARMS
               NBCOL( I ) = 1
  170       CONTINUE
         END IF
      END IF
*
*     Calculate and print the machine dependent constants.
*
      WRITE( NOUT, FMT = * )
      EPS = SLAMCH( 'Underflow threshold' )
      WRITE( NOUT, FMT = 9981 )'underflow', EPS
      EPS = SLAMCH( 'Overflow threshold' )
      WRITE( NOUT, FMT = 9981 )'overflow ', EPS
      EPS = SLAMCH( 'Epsilon' )
      WRITE( NOUT, FMT = 9981 )'precision', EPS
*
*     Read the threshold value for the test ratios.
*
      READ( NIN, FMT = * )THRESH
      WRITE( NOUT, FMT = 9982 )THRESH
      IF( SEP .OR. SVD .OR. CGG ) THEN
*
*        Read the flag that indicates whether to test LAPACK routines.
*
         READ( NIN, FMT = * )TSTCHK
*
*        Read the flag that indicates whether to test driver routines.
*
         READ( NIN, FMT = * )TSTDRV
      END IF
*
*     Read the flag that indicates whether to test the error exits.
*
      READ( NIN, FMT = * )TSTERR
*
*     Read the code describing how to set the random number seed.
*
      READ( NIN, FMT = * )NEWSD
*
*     If NEWSD = 2, read another line with 4 integers for the seed.
*
      IF( NEWSD.EQ.2 )
     $   READ( NIN, FMT = * )( IOLDSD( I ), I = 1, 4 )
*
      DO 180 I = 1, 4
         ISEED( I ) = IOLDSD( I )
  180 CONTINUE
*
      IF( FATAL ) THEN
         WRITE( NOUT, FMT = 9999 )
         STOP
      END IF
*
*     Read the input lines indicating the test path and its parameters.
*     The first three characters indicate the test path, and the number
*     of test matrix types must be the first nonblank item in columns
*     4-80.
*
  190 CONTINUE
*
      IF( .NOT.( CGX .OR. CXV ) ) THEN
*
  200    CONTINUE
         READ( NIN, FMT = '(A80)', END = 380 )LINE
         C3 = LINE( 1: 3 )
         LENP = LEN( LINE )
         I = 3
         ITMP = 0
         I1 = 0
  210    CONTINUE
         I = I + 1
         IF( I.GT.LENP ) THEN
            IF( I1.GT.0 ) THEN
               GO TO 240
            ELSE
               NTYPES = MAXT
               GO TO 240
            END IF
         END IF
         IF( LINE( I: I ).NE.' ' .AND. LINE( I: I ).NE.',' ) THEN
            I1 = I
            C1 = LINE( I1: I1 )
*
*        Check that a valid integer was read
*
            DO 220 K = 1, 10
               IF( C1.EQ.INTSTR( K: K ) ) THEN
                  IC = K - 1
                  GO TO 230
               END IF
  220       CONTINUE
            WRITE( NOUT, FMT = 9991 )I, LINE
            GO TO 200
  230       CONTINUE
            ITMP = 10*ITMP + IC
            GO TO 210
         ELSE IF( I1.GT.0 ) THEN
            GO TO 240
         ELSE
            GO TO 210
         END IF
  240    CONTINUE
         NTYPES = ITMP
*
*     Skip the tests if NTYPES is <= 0.
*
         IF( .NOT.( CEV .OR. CES .OR. CVX .OR. CSX .OR. CGV .OR.
     $       CGS ) .AND. NTYPES.LE.0 ) THEN
            WRITE( NOUT, FMT = 9990 )C3
            GO TO 200
         END IF
*
      ELSE
         IF( CGX )
     $      C3 = 'CGX'
         IF( CXV )
     $      C3 = 'CXV'
      END IF
*
*     Reset the random number seed.
*
      IF( NEWSD.EQ.0 ) THEN
         DO 250 K = 1, 4
            ISEED( K ) = IOLDSD( K )
  250    CONTINUE
      END IF
*
      IF( LSAMEN( 3, C3, 'CHS' ) .OR. LSAMEN( 3, C3, 'NEP' ) ) THEN
*
*        -------------------------------------
*        NEP:  Nonsymmetric Eigenvalue Problem
*        -------------------------------------
*        Vary the parameters
*           NB    = block size
*           NBMIN = minimum block size
*           NX    = crossover point
*           NS    = number of shifts
*           MAXB  = minimum submatrix size
*
         MAXTYP = 21
         NTYPES = MIN( MAXTYP, NTYPES )
         CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
         CALL XLAENV( 1, 1 )
         IF( TSTERR )
     $      CALL CERRHS( 'CHSEQR', NOUT )
         DO 270 I = 1, NPARMS
            CALL XLAENV( 1, NBVAL( I ) )
            CALL XLAENV( 2, NBMIN( I ) )
            CALL XLAENV( 3, NXVAL( I ) )
            CALL XLAENV(12, MAX( 11, INMIN( I ) ) )
            CALL XLAENV(13, INWIN( I ) )
            CALL XLAENV(14, INIBL( I ) )
            CALL XLAENV(15, ISHFTS( I ) )
            CALL XLAENV(16, IACC22( I ) )
*
            IF( NEWSD.EQ.0 ) THEN
               DO 260 K = 1, 4
                  ISEED( K ) = IOLDSD( K )
  260          CONTINUE
            END IF
            WRITE( NOUT, FMT = 9961 )C3, NBVAL( I ), NBMIN( I ),
     $         NXVAL( I ), MAX( 11, INMIN(I)),
     $         INWIN( I ), INIBL( I ), ISHFTS( I ), IACC22( I )
            CALL CCHKHS( NN, NVAL, MAXTYP, DOTYPE, ISEED, THRESH, NOUT,
     $                   A( 1, 1 ), NMAX, A( 1, 2 ), A( 1, 3 ),
     $                   A( 1, 4 ), A( 1, 5 ), NMAX, A( 1, 6 ),
     $                   A( 1, 7 ), DC( 1, 1 ), DC( 1, 2 ), A( 1, 8 ),
     $                   A( 1, 9 ), A( 1, 10 ), A( 1, 11 ), A( 1, 12 ),
     $                   DC( 1, 3 ), WORK, LWORK, RWORK, IWORK, LOGWRK,
     $                   RESULT, INFO )
            IF( INFO.NE.0 )
     $         WRITE( NOUT, FMT = 9980 )'CCHKHS', INFO
  270    CONTINUE
*
      ELSE IF( LSAMEN( 3, C3, 'CST' ) .OR. LSAMEN( 3, C3, 'SEP' )
     $                                .OR. LSAMEN( 3, C3, 'SE2' ) ) THEN
*
*        ----------------------------------
*        SEP:  Symmetric Eigenvalue Problem
*        ----------------------------------
*        Vary the parameters
*           NB    = block size
*           NBMIN = minimum block size
*           NX    = crossover point
*
         MAXTYP = 21
         NTYPES = MIN( MAXTYP, NTYPES )
         CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
         CALL XLAENV( 1, 1 )
         CALL XLAENV( 9, 25 )
         IF( TSTERR ) THEN
#if defined(_OPENMP)
            N_THREADS = OMP_GET_MAX_THREADS()
            ONE_THREAD = 1
            CALL OMP_SET_NUM_THREADS(ONE_THREAD)
#endif
            CALL CERRST( 'CST', NOUT )
#if defined(_OPENMP)
            CALL OMP_SET_NUM_THREADS(N_THREADS)
#endif
         END IF
         DO 290 I = 1, NPARMS
            CALL XLAENV( 1, NBVAL( I ) )
            CALL XLAENV( 2, NBMIN( I ) )
            CALL XLAENV( 3, NXVAL( I ) )
*
            IF( NEWSD.EQ.0 ) THEN
               DO 280 K = 1, 4
                  ISEED( K ) = IOLDSD( K )
  280          CONTINUE
            END IF
            WRITE( NOUT, FMT = 9997 )C3, NBVAL( I ), NBMIN( I ),
     $         NXVAL( I )
            IF( TSTCHK ) THEN
               IF( LSAMEN( 3, C3, 'SE2' ) ) THEN
               CALL CCHKST2STG( NN, NVAL, MAXTYP, DOTYPE, ISEED, THRESH,
     $                      NOUT, A( 1, 1 ), NMAX, A( 1, 2 ),
     $                      DR( 1, 1 ), DR( 1, 2 ), DR( 1, 3 ),
     $                      DR( 1, 4 ), DR( 1, 5 ), DR( 1, 6 ),
     $                      DR( 1, 7 ), DR( 1, 8 ), DR( 1, 9 ),
     $                      DR( 1, 10 ), DR( 1, 11 ), A( 1, 3 ), NMAX,
     $                      A( 1, 4 ), A( 1, 5 ), DC( 1, 1 ), A( 1, 6 ),
     $                      WORK, LWORK, RWORK, LWORK, IWORK, LIWORK,
     $                      RESULT, INFO )
               ELSE
               CALL CCHKST( NN, NVAL, MAXTYP, DOTYPE, ISEED, THRESH,
     $                      NOUT, A( 1, 1 ), NMAX, A( 1, 2 ),
     $                      DR( 1, 1 ), DR( 1, 2 ), DR( 1, 3 ),
     $                      DR( 1, 4 ), DR( 1, 5 ), DR( 1, 6 ),
     $                      DR( 1, 7 ), DR( 1, 8 ), DR( 1, 9 ),
     $                      DR( 1, 10 ), DR( 1, 11 ), A( 1, 3 ), NMAX,
     $                      A( 1, 4 ), A( 1, 5 ), DC( 1, 1 ), A( 1, 6 ),
     $                      WORK, LWORK, RWORK, LWORK, IWORK, LIWORK,
     $                      RESULT, INFO )
               ENDIF
               IF( INFO.NE.0 )
     $            WRITE( NOUT, FMT = 9980 )'CCHKST', INFO
            END IF
            IF( TSTDRV ) THEN
               IF( LSAMEN( 3, C3, 'SE2' ) ) THEN
               CALL CDRVST2STG( NN, NVAL, 18, DOTYPE, ISEED, THRESH,
     $                    NOUT, A( 1, 1 ), NMAX, DR( 1, 3 ), DR( 1, 4 ),
     $                    DR( 1, 5 ), DR( 1, 8 ), DR( 1, 9 ),
     $                    DR( 1, 10 ), A( 1, 2 ), NMAX, A( 1, 3 ),
     $                    DC( 1, 1 ), A( 1, 4 ), WORK, LWORK, RWORK,
     $                    LWORK, IWORK, LIWORK, RESULT, INFO )
               ELSE
               CALL CDRVST( NN, NVAL, 18, DOTYPE, ISEED, THRESH, NOUT,
     $                    A( 1, 1 ), NMAX, DR( 1, 3 ), DR( 1, 4 ),
     $                    DR( 1, 5 ), DR( 1, 8 ), DR( 1, 9 ),
     $                    DR( 1, 10 ), A( 1, 2 ), NMAX, A( 1, 3 ),
     $                    DC( 1, 1 ), A( 1, 4 ), WORK, LWORK, RWORK,
     $                    LWORK, IWORK, LIWORK, RESULT, INFO )
           ENDIF
               IF( INFO.NE.0 )
     $            WRITE( NOUT, FMT = 9980 )'CDRVST', INFO
            END IF
  290    CONTINUE
*
      ELSE IF( LSAMEN( 3, C3, 'CSG' ) ) THEN
*
*        ----------------------------------------------
*        CSG:  Hermitian Generalized Eigenvalue Problem
*        ----------------------------------------------
*        Vary the parameters
*           NB    = block size
*           NBMIN = minimum block size
*           NX    = crossover point
*
         MAXTYP = 21
         NTYPES = MIN( MAXTYP, NTYPES )
         CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
         CALL XLAENV( 9, 25 )
         DO 310 I = 1, NPARMS
            CALL XLAENV( 1, NBVAL( I ) )
            CALL XLAENV( 2, NBMIN( I ) )
            CALL XLAENV( 3, NXVAL( I ) )
*
            IF( NEWSD.EQ.0 ) THEN
               DO 300 K = 1, 4
                  ISEED( K ) = IOLDSD( K )
  300          CONTINUE
            END IF
            WRITE( NOUT, FMT = 9997 )C3, NBVAL( I ), NBMIN( I ),
     $         NXVAL( I )
            IF( TSTCHK ) THEN
*               CALL CDRVSG( NN, NVAL, MAXTYP, DOTYPE, ISEED, THRESH,
*     $                      NOUT, A( 1, 1 ), NMAX, A( 1, 2 ), NMAX,
*     $                      DR( 1, 3 ), A( 1, 3 ), NMAX, A( 1, 4 ),
*     $                      A( 1, 5 ), A( 1, 6 ), A( 1, 7 ), WORK,
*     $                      LWORK, RWORK, LWORK, IWORK, LIWORK, RESULT,
*     $                      INFO )
               CALL CDRVSG2STG( NN, NVAL, MAXTYP, DOTYPE, ISEED, THRESH,
     $                          NOUT, A( 1, 1 ), NMAX, A( 1, 2 ), NMAX,
     $                          DR( 1, 3 ), DR( 1, 4 ), A( 1, 3 ), NMAX,
     $                          A( 1, 4 ), A( 1, 5 ), A( 1, 6 ),
     $                          A( 1, 7 ), WORK, LWORK, RWORK, LWORK,
     $                          IWORK, LIWORK, RESULT, INFO )
               IF( INFO.NE.0 )
     $            WRITE( NOUT, FMT = 9980 )'CDRVSG', INFO
            END IF
  310    CONTINUE
*
      ELSE IF( LSAMEN( 3, C3, 'CBD' ) .OR. LSAMEN( 3, C3, 'SVD' ) ) THEN
*
*        ----------------------------------
*        SVD:  Singular Value Decomposition
*        ----------------------------------
*        Vary the parameters
*           NB    = block size
*           NBMIN = minimum block size
*           NX    = crossover point
*           NRHS  = number of right hand sides
*
         MAXTYP = 16
         NTYPES = MIN( MAXTYP, NTYPES )
         CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
         CALL XLAENV( 9, 25 )
*
*        Test the error exits
*
         CALL XLAENV( 1, 1 )
         IF( TSTERR .AND. TSTCHK )
     $      CALL CERRBD( 'CBD', NOUT )
         IF( TSTERR .AND. TSTDRV )
     $      CALL CERRED( 'CBD', NOUT )
*
         DO 330 I = 1, NPARMS
            NRHS = NSVAL( I )
            CALL XLAENV( 1, NBVAL( I ) )
            CALL XLAENV( 2, NBMIN( I ) )
            CALL XLAENV( 3, NXVAL( I ) )
            IF( NEWSD.EQ.0 ) THEN
               DO 320 K = 1, 4
                  ISEED( K ) = IOLDSD( K )
  320          CONTINUE
            END IF
            WRITE( NOUT, FMT = 9995 )C3, NBVAL( I ), NBMIN( I ),
     $         NXVAL( I ), NRHS
            IF( TSTCHK ) THEN
               CALL CCHKBD( NN, MVAL, NVAL, MAXTYP, DOTYPE, NRHS, ISEED,
     $                      THRESH, A( 1, 1 ), NMAX, DR( 1, 1 ),
     $                      DR( 1, 2 ), DR( 1, 3 ), DR( 1, 4 ),
     $                      A( 1, 2 ), NMAX, A( 1, 3 ), A( 1, 4 ),
     $                      A( 1, 5 ), NMAX, A( 1, 6 ), NMAX, A( 1, 7 ),
     $                      A( 1, 8 ), WORK, LWORK, RWORK, NOUT, INFO )
               IF( INFO.NE.0 )
     $            WRITE( NOUT, FMT = 9980 )'CCHKBD', INFO
            END IF
            IF( TSTDRV )
     $         CALL CDRVBD( NN, MVAL, NVAL, MAXTYP, DOTYPE, ISEED,
     $                      THRESH, A( 1, 1 ), NMAX, A( 1, 2 ), NMAX,
     $                      A( 1, 3 ), NMAX, A( 1, 4 ), A( 1, 5 ),
     $                      A( 1, 6 ), DR( 1, 1 ), DR( 1, 2 ),
     $                      DR( 1, 3 ), WORK, LWORK, RWORK, IWORK, NOUT,
     $                      INFO )
  330    CONTINUE
*
      ELSE IF( LSAMEN( 3, C3, 'CEV' ) ) THEN
*
*        --------------------------------------------
*        CEV:  Nonsymmetric Eigenvalue Problem Driver
*              CGEEV (eigenvalues and eigenvectors)
*        --------------------------------------------
*
         MAXTYP = 21
         NTYPES = MIN( MAXTYP, NTYPES )
         IF( NTYPES.LE.0 ) THEN
            WRITE( NOUT, FMT = 9990 )C3
         ELSE
            IF( TSTERR )
     $         CALL CERRED( C3, NOUT )
            CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
            CALL CDRVEV( NN, NVAL, NTYPES, DOTYPE, ISEED, THRESH, NOUT,
     $                   A( 1, 1 ), NMAX, A( 1, 2 ), DC( 1, 1 ),
     $                   DC( 1, 2 ), A( 1, 3 ), NMAX, A( 1, 4 ), NMAX,
     $                   A( 1, 5 ), NMAX, RESULT, WORK, LWORK, RWORK,
     $                   IWORK, INFO )
            IF( INFO.NE.0 )
     $         WRITE( NOUT, FMT = 9980 )'CGEEV', INFO
         END IF
         WRITE( NOUT, FMT = 9973 )
         GO TO 10
*
      ELSE IF( LSAMEN( 3, C3, 'CES' ) ) THEN
*
*        --------------------------------------------
*        CES:  Nonsymmetric Eigenvalue Problem Driver
*              CGEES (Schur form)
*        --------------------------------------------
*
         MAXTYP = 21
         NTYPES = MIN( MAXTYP, NTYPES )
         IF( NTYPES.LE.0 ) THEN
            WRITE( NOUT, FMT = 9990 )C3
         ELSE
            IF( TSTERR )
     $         CALL CERRED( C3, NOUT )
            CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
            CALL CDRVES( NN, NVAL, NTYPES, DOTYPE, ISEED, THRESH, NOUT,
     $                   A( 1, 1 ), NMAX, A( 1, 2 ), A( 1, 3 ),
     $                   DC( 1, 1 ), DC( 1, 2 ), A( 1, 4 ), NMAX,
     $                   RESULT, WORK, LWORK, RWORK, IWORK, LOGWRK,
     $                   INFO )
            IF( INFO.NE.0 )
     $         WRITE( NOUT, FMT = 9980 )'CGEES', INFO
         END IF
         WRITE( NOUT, FMT = 9973 )
         GO TO 10
*
      ELSE IF( LSAMEN( 3, C3, 'CVX' ) ) THEN
*
*        --------------------------------------------------------------
*        CVX:  Nonsymmetric Eigenvalue Problem Expert Driver
*              CGEEVX (eigenvalues, eigenvectors and condition numbers)
*        --------------------------------------------------------------
*
         MAXTYP = 21
         NTYPES = MIN( MAXTYP, NTYPES )
         IF( NTYPES.LT.0 ) THEN
            WRITE( NOUT, FMT = 9990 )C3
         ELSE
            IF( TSTERR )
     $         CALL CERRED( C3, NOUT )
            CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
            CALL CDRVVX( NN, NVAL, NTYPES, DOTYPE, ISEED, THRESH, NIN,
     $                   NOUT, A( 1, 1 ), NMAX, A( 1, 2 ), DC( 1, 1 ),
     $                   DC( 1, 2 ), A( 1, 3 ), NMAX, A( 1, 4 ), NMAX,
     $                   A( 1, 5 ), NMAX, DR( 1, 1 ), DR( 1, 2 ),
     $                   DR( 1, 3 ), DR( 1, 4 ), DR( 1, 5 ), DR( 1, 6 ),
     $                   DR( 1, 7 ), DR( 1, 8 ), RESULT, WORK, LWORK,
     $                   RWORK, INFO )
            IF( INFO.NE.0 )
     $         WRITE( NOUT, FMT = 9980 )'CGEEVX', INFO
         END IF
         WRITE( NOUT, FMT = 9973 )
         GO TO 10
*
      ELSE IF( LSAMEN( 3, C3, 'CSX' ) ) THEN
*
*        ---------------------------------------------------
*        CSX:  Nonsymmetric Eigenvalue Problem Expert Driver
*              CGEESX (Schur form and condition numbers)
*        ---------------------------------------------------
*
         MAXTYP = 21
         NTYPES = MIN( MAXTYP, NTYPES )
         IF( NTYPES.LT.0 ) THEN
            WRITE( NOUT, FMT = 9990 )C3
         ELSE
            IF( TSTERR )
     $         CALL CERRED( C3, NOUT )
            CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
            CALL CDRVSX( NN, NVAL, NTYPES, DOTYPE, ISEED, THRESH, NIN,
     $                   NOUT, A( 1, 1 ), NMAX, A( 1, 2 ), A( 1, 3 ),
     $                   DC( 1, 1 ), DC( 1, 2 ), DC( 1, 3 ), A( 1, 4 ),
     $                   NMAX, A( 1, 5 ), RESULT, WORK, LWORK, RWORK,
     $                   LOGWRK, INFO )
            IF( INFO.NE.0 )
     $         WRITE( NOUT, FMT = 9980 )'CGEESX', INFO
         END IF
         WRITE( NOUT, FMT = 9973 )
         GO TO 10
*
      ELSE IF( LSAMEN( 3, C3, 'CGG' ) ) THEN
*
*        -------------------------------------------------
*        CGG:  Generalized Nonsymmetric Eigenvalue Problem
*        -------------------------------------------------
*        Vary the parameters
*           NB    = block size
*           NBMIN = minimum block size
*           NS    = number of shifts
*           MAXB  = minimum submatrix size
*           IACC22: structured matrix multiply
*           NBCOL = minimum column dimension for blocks
*
         MAXTYP = 26
         NTYPES = MIN( MAXTYP, NTYPES )
         CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
         CALL XLAENV(1,1)
         IF( TSTCHK .AND. TSTERR )
     $      CALL CERRGG( C3, NOUT )
         DO 350 I = 1, NPARMS
            CALL XLAENV( 1, NBVAL( I ) )
            CALL XLAENV( 2, NBMIN( I ) )
            CALL XLAENV( 4, NSVAL( I ) )
            CALL XLAENV( 8, MXBVAL( I ) )
            CALL XLAENV( 16, IACC22( I ) )
            CALL XLAENV( 5, NBCOL( I ) )
*
            IF( NEWSD.EQ.0 ) THEN
               DO 340 K = 1, 4
                  ISEED( K ) = IOLDSD( K )
  340          CONTINUE
            END IF
            WRITE( NOUT, FMT = 9996 )C3, NBVAL( I ), NBMIN( I ),
     $         NSVAL( I ), MXBVAL( I ), IACC22( I ), NBCOL( I )
            TSTDIF = .FALSE.
            THRSHN = 10.
            IF( TSTCHK ) THEN
               CALL CCHKGG( NN, NVAL, MAXTYP, DOTYPE, ISEED, THRESH,
     $                      TSTDIF, THRSHN, NOUT, A( 1, 1 ), NMAX,
     $                      A( 1, 2 ), A( 1, 3 ), A( 1, 4 ), A( 1, 5 ),
     $                      A( 1, 6 ), A( 1, 7 ), A( 1, 8 ), A( 1, 9 ),
     $                      NMAX, A( 1, 10 ), A( 1, 11 ), A( 1, 12 ),
     $                      DC( 1, 1 ), DC( 1, 2 ), DC( 1, 3 ),
     $                      DC( 1, 4 ), A( 1, 13 ), A( 1, 14 ), WORK,
     $                      LWORK, RWORK, LOGWRK, RESULT, INFO )
               IF( INFO.NE.0 )
     $            WRITE( NOUT, FMT = 9980 )'CCHKGG', INFO
            END IF
  350    CONTINUE
*
      ELSE IF( LSAMEN( 3, C3, 'CGS' ) ) THEN
*
*        -------------------------------------------------
*        CGS:  Generalized Nonsymmetric Eigenvalue Problem
*              CGGES (Schur form)
*        -------------------------------------------------
*
         MAXTYP = 26
         NTYPES = MIN( MAXTYP, NTYPES )
         IF( NTYPES.LE.0 ) THEN
            WRITE( NOUT, FMT = 9990 )C3
         ELSE
            IF( TSTERR )
     $         CALL CERRGG( C3, NOUT )
            CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
            CALL CDRGES( NN, NVAL, MAXTYP, DOTYPE, ISEED, THRESH, NOUT,
     $                   A( 1, 1 ), NMAX, A( 1, 2 ), A( 1, 3 ),
     $                   A( 1, 4 ), A( 1, 7 ), NMAX, A( 1, 8 ),
     $                   DC( 1, 1 ), DC( 1, 2 ), WORK, LWORK, RWORK,
     $                   RESULT, LOGWRK, INFO )
*
            IF( INFO.NE.0 )
     $         WRITE( NOUT, FMT = 9980 )'CDRGES', INFO
*
* Blocked version
*
            CALL XLAENV(16,2)
            CALL CDRGES3( NN, NVAL, MAXTYP, DOTYPE, ISEED, THRESH, NOUT,
     $                    A( 1, 1 ), NMAX, A( 1, 2 ), A( 1, 3 ),
     $                    A( 1, 4 ), A( 1, 7 ), NMAX, A( 1, 8 ),
     $                    DC( 1, 1 ), DC( 1, 2 ), WORK, LWORK, RWORK,
     $                    RESULT, LOGWRK, INFO )
*
            IF( INFO.NE.0 )
     $         WRITE( NOUT, FMT = 9980 )'CDRGES3', INFO
         END IF
         WRITE( NOUT, FMT = 9973 )

         GO TO 10
*
      ELSE IF( CGX ) THEN
*
*        -------------------------------------------------
*        CGX  Generalized Nonsymmetric Eigenvalue Problem
*              CGGESX (Schur form and condition numbers)
*        -------------------------------------------------
*
         MAXTYP = 5
         NTYPES = MAXTYP
         IF( NN.LT.0 ) THEN
            WRITE( NOUT, FMT = 9990 )C3
         ELSE
            IF( TSTERR )
     $         CALL CERRGG( C3, NOUT )
            CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
            CALL XLAENV( 5, 2 )
            CALL CDRGSX( NN, NCMAX, THRESH, NIN, NOUT, A( 1, 1 ), NMAX,
     $                   A( 1, 2 ), A( 1, 3 ), A( 1, 4 ), A( 1, 5 ),
     $                   A( 1, 6 ), DC( 1, 1 ), DC( 1, 2 ), C,
     $                   NCMAX*NCMAX, S, WORK, LWORK, RWORK, IWORK,
     $                   LIWORK, LOGWRK, INFO )
            IF( INFO.NE.0 )
     $         WRITE( NOUT, FMT = 9980 )'CDRGSX', INFO
         END IF
         WRITE( NOUT, FMT = 9973 )
         GO TO 10
*
      ELSE IF( LSAMEN( 3, C3, 'CGV' ) ) THEN
*
*        -------------------------------------------------
*        CGV:  Generalized Nonsymmetric Eigenvalue Problem
*              CGGEV (Eigenvalue/vector form)
*        -------------------------------------------------
*
         MAXTYP = 26
         NTYPES = MIN( MAXTYP, NTYPES )
         IF( NTYPES.LE.0 ) THEN
            WRITE( NOUT, FMT = 9990 )C3
         ELSE
            IF( TSTERR )
     $         CALL CERRGG( C3, NOUT )
            CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
            CALL CDRGEV( NN, NVAL, MAXTYP, DOTYPE, ISEED, THRESH, NOUT,
     $                   A( 1, 1 ), NMAX, A( 1, 2 ), A( 1, 3 ),
     $                   A( 1, 4 ), A( 1, 7 ), NMAX, A( 1, 8 ),
     $                   A( 1, 9 ), NMAX, DC( 1, 1 ), DC( 1, 2 ),
     $                   DC( 1, 3 ), DC( 1, 4 ), WORK, LWORK, RWORK,
     $                   RESULT, INFO )
            IF( INFO.NE.0 )
     $         WRITE( NOUT, FMT = 9980 )'CDRGEV', INFO
*
* Blocked version
*
            CALL XLAENV(16,2)
            CALL CDRGEV3( NN, NVAL, MAXTYP, DOTYPE, ISEED, THRESH, NOUT,
     $                    A( 1, 1 ), NMAX, A( 1, 2 ), A( 1, 3 ),
     $                    A( 1, 4 ), A( 1, 7 ), NMAX, A( 1, 8 ),
     $                    A( 1, 9 ), NMAX, DC( 1, 1 ), DC( 1, 2 ),
     $                    DC( 1, 3 ), DC( 1, 4 ), WORK, LWORK, RWORK,
     $                    RESULT, INFO )
            IF( INFO.NE.0 )
     $           WRITE( NOUT, FMT = 9980 )'CDRGEV3', INFO
         END IF
         WRITE( NOUT, FMT = 9973 )
         GO TO 10
*
      ELSE IF( CXV ) THEN
*
*        -------------------------------------------------
*        CXV:  Generalized Nonsymmetric Eigenvalue Problem
*              CGGEVX (eigenvalue/vector with condition numbers)
*        -------------------------------------------------
*
         MAXTYP = 2
         NTYPES = MAXTYP
         IF( NN.LT.0 ) THEN
            WRITE( NOUT, FMT = 9990 )C3
         ELSE
            IF( TSTERR )
     $         CALL CERRGG( C3, NOUT )
            CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
            CALL CDRGVX( NN, THRESH, NIN, NOUT, A( 1, 1 ), NMAX,
     $                   A( 1, 2 ), A( 1, 3 ), A( 1, 4 ), DC( 1, 1 ),
     $                   DC( 1, 2 ), A( 1, 5 ), A( 1, 6 ), IWORK( 1 ),
     $                   IWORK( 2 ), DR( 1, 1 ), DR( 1, 2 ), DR( 1, 3 ),
     $                   DR( 1, 4 ), DR( 1, 5 ), DR( 1, 6 ), WORK,
     $                   LWORK, RWORK, IWORK( 3 ), LIWORK-2, RESULT,
     $                   LOGWRK, INFO )
*
            IF( INFO.NE.0 )
     $         WRITE( NOUT, FMT = 9980 )'CDRGVX', INFO
         END IF
         WRITE( NOUT, FMT = 9973 )
         GO TO 10
*
      ELSE IF( LSAMEN( 3, C3, 'CHB' ) ) THEN
*
*        ------------------------------
*        CHB:  Hermitian Band Reduction
*        ------------------------------
*
         MAXTYP = 15
         NTYPES = MIN( MAXTYP, NTYPES )
         CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
         IF( TSTERR ) THEN
#if defined(_OPENMP)
            N_THREADS = OMP_GET_MAX_THREADS()
            ONE_THREAD = 1
            CALL OMP_SET_NUM_THREADS(ONE_THREAD)
#endif
            CALL CERRST( 'CHB', NOUT )
#if defined(_OPENMP)
            CALL OMP_SET_NUM_THREADS(N_THREADS)
#endif
         END IF
*         CALL CCHKHB( NN, NVAL, NK, KVAL, MAXTYP, DOTYPE, ISEED, THRESH,
*     $                NOUT, A( 1, 1 ), NMAX, DR( 1, 1 ), DR( 1, 2 ),
*     $                A( 1, 2 ), NMAX, WORK, LWORK, RWORK, RESULT,
*     $                INFO )
         CALL CCHKHB2STG( NN, NVAL, NK, KVAL, MAXTYP, DOTYPE, ISEED,
     $                 THRESH, NOUT, A( 1, 1 ), NMAX, DR( 1, 1 ), 
     $                 DR( 1, 2 ), DR( 1, 3 ), DR( 1, 4 ), DR( 1, 5 ),
     $                 A( 1, 2 ), NMAX, WORK, LWORK, RWORK, RESULT, 
     $                 INFO )
         IF( INFO.NE.0 )
     $      WRITE( NOUT, FMT = 9980 )'CCHKHB', INFO
*
      ELSE IF( LSAMEN( 3, C3, 'CBB' ) ) THEN
*
*        ------------------------------
*        CBB:  General Band Reduction
*        ------------------------------
*
         MAXTYP = 15
         NTYPES = MIN( MAXTYP, NTYPES )
         CALL ALAREQ( C3, NTYPES, DOTYPE, MAXTYP, NIN, NOUT )
         DO 370 I = 1, NPARMS
            NRHS = NSVAL( I )
*
            IF( NEWSD.EQ.0 ) THEN
               DO 360 K = 1, 4
                  ISEED( K ) = IOLDSD( K )
  360          CONTINUE
            END IF
            WRITE( NOUT, FMT = 9966 )C3, NRHS
            CALL CCHKBB( NN, MVAL, NVAL, NK, KVAL, MAXTYP, DOTYPE, NRHS,
     $                   ISEED, THRESH, NOUT, A( 1, 1 ), NMAX,
     $                   A( 1, 2 ), 2*NMAX, DR( 1, 1 ), DR( 1, 2 ),
     $                   A( 1, 4 ), NMAX, A( 1, 5 ), NMAX, A( 1, 6 ),
     $                   NMAX, A( 1, 7 ), WORK, LWORK, RWORK, RESULT,
     $                   INFO )
            IF( INFO.NE.0 )
     $         WRITE( NOUT, FMT = 9980 )'CCHKBB', INFO
  370    CONTINUE
*
      ELSE IF( LSAMEN( 3, C3, 'GLM' ) ) THEN
*
*        -----------------------------------------
*        GLM:  Generalized Linear Regression Model
*        -----------------------------------------
*
         CALL XLAENV( 1, 1 )
         IF( TSTERR )
     $      CALL CERRGG( 'GLM', NOUT )
         CALL CCKGLM( NN, NVAL, MVAL, PVAL, NTYPES, ISEED, THRESH, NMAX,
     $                A( 1, 1 ), A( 1, 2 ), B( 1, 1 ), B( 1, 2 ), X,
     $                WORK, DR( 1, 1 ), NIN, NOUT, INFO )
         IF( INFO.NE.0 )
     $      WRITE( NOUT, FMT = 9980 )'CCKGLM', INFO
*
      ELSE IF( LSAMEN( 3, C3, 'GQR' ) ) THEN
*
*        ------------------------------------------
*        GQR:  Generalized QR and RQ factorizations
*        ------------------------------------------
*
         CALL XLAENV( 1, 1 )
         IF( TSTERR )
     $      CALL CERRGG( 'GQR', NOUT )
         CALL CCKGQR( NN, MVAL, NN, PVAL, NN, NVAL, NTYPES, ISEED,
     $                THRESH, NMAX, A( 1, 1 ), A( 1, 2 ), A( 1, 3 ),
     $                A( 1, 4 ), TAUA, B( 1, 1 ), B( 1, 2 ), B( 1, 3 ),
     $                B( 1, 4 ), B( 1, 5 ), TAUB, WORK, DR( 1, 1 ), NIN,
     $                NOUT, INFO )
         IF( INFO.NE.0 )
     $      WRITE( NOUT, FMT = 9980 )'CCKGQR', INFO
*
      ELSE IF( LSAMEN( 3, C3, 'GSV' ) ) THEN
*
*        ----------------------------------------------
*        GSV:  Generalized Singular Value Decomposition
*        ----------------------------------------------
*
         CALL XLAENV(1,1)
         IF( TSTERR )
     $      CALL CERRGG( 'GSV', NOUT )
         CALL CCKGSV( NN, MVAL, PVAL, NVAL, NTYPES, ISEED, THRESH, NMAX,
     $                A( 1, 1 ), A( 1, 2 ), B( 1, 1 ), B( 1, 2 ),
     $                A( 1, 3 ), B( 1, 3 ), A( 1, 4 ), ALPHA, BETA,
     $                B( 1, 4 ), IWORK, WORK, DR( 1, 1 ), NIN, NOUT,
     $                INFO )
         IF( INFO.NE.0 )
     $      WRITE( NOUT, FMT = 9980 )'CCKGSV', INFO
*
      ELSE IF( LSAMEN( 3, C3, 'CSD' ) ) THEN
*
*        ----------------------------------------------
*        CSD:  CS Decomposition
*        ----------------------------------------------
*
         CALL XLAENV(1,1)
         IF( TSTERR )
     $      CALL CERRGG( 'CSD', NOUT )
         CALL CCKCSD( NN, MVAL, PVAL, NVAL, NTYPES, ISEED, THRESH, NMAX,
     $                A( 1, 1 ), A( 1, 2 ), A( 1, 3 ), A( 1, 4 ),
     $                A( 1, 5 ), A( 1, 6 ), RWORK, IWORK, WORK,
     $                DR( 1, 1 ), NIN, NOUT, INFO )
         IF( INFO.NE.0 )
     $      WRITE( NOUT, FMT = 9980 )'CCKCSD', INFO
*
      ELSE IF( LSAMEN( 3, C3, 'LSE' ) ) THEN
*
*        --------------------------------------
*        LSE:  Constrained Linear Least Squares
*        --------------------------------------
*
         CALL XLAENV( 1, 1 )
         IF( TSTERR )
     $      CALL CERRGG( 'LSE', NOUT )
         CALL CCKLSE( NN, MVAL, PVAL, NVAL, NTYPES, ISEED, THRESH, NMAX,
     $                A( 1, 1 ), A( 1, 2 ), B( 1, 1 ), B( 1, 2 ), X,
     $                WORK, DR( 1, 1 ), NIN, NOUT, INFO )
         IF( INFO.NE.0 )
     $      WRITE( NOUT, FMT = 9980 )'CCKLSE', INFO
      ELSE
         WRITE( NOUT, FMT = * )
         WRITE( NOUT, FMT = * )
         WRITE( NOUT, FMT = 9992 )C3
      END IF
      IF( .NOT.( CGX .OR. CXV ) )
     $   GO TO 190
  380 CONTINUE
      WRITE( NOUT, FMT = 9994 )
      S2 = SECOND( )
      WRITE( NOUT, FMT = 9993 )S2 - S1    
*
      DEALLOCATE (S, STAT = AllocateStatus)
      DEALLOCATE (A, STAT = AllocateStatus)
      DEALLOCATE (B, STAT = AllocateStatus)
      DEALLOCATE (C, STAT = AllocateStatus)
      DEALLOCATE (RWORK, STAT = AllocateStatus)
      DEALLOCATE (WORK,  STAT = AllocateStatus)
*
 9999 FORMAT( / ' Execution not attempted due to input errors' )
 9997 FORMAT( / / 1X, A3, ':  NB =', I4, ', NBMIN =', I4, ', NX =', I4 )
 9996 FORMAT( / / 1X, A3, ':  NB =', I4, ', NBMIN =', I4, ', NS =', I4,
     $      ', MAXB =', I4, ', IACC22 =', I4, ', NBCOL =', I4 )
 9995 FORMAT( / / 1X, A3, ':  NB =', I4, ', NBMIN =', I4, ', NX =', I4,
     $      ', NRHS =', I4 )
 9994 FORMAT( / / ' End of tests' )
 9993 FORMAT( ' Total time used = ', F12.2, ' seconds', / )
 9992 FORMAT( 1X, A3, ':  Unrecognized path name' )
 9991 FORMAT( / / ' *** Invalid integer value in column ', I2,
     $      ' of input', ' line:', / A79 )
 9990 FORMAT( / / 1X, A3, ' routines were not tested' )
 9989 FORMAT( ' Invalid input value: ', A, '=', I6, '; must be >=',
     $      I6 )
 9988 FORMAT( ' Invalid input value: ', A, '=', I6, '; must be <=',
     $      I6 )
 9987 FORMAT( ' Tests of the Nonsymmetric Eigenvalue Problem routines' )
 9986 FORMAT( ' Tests of the Hermitian Eigenvalue Problem routines' )
 9985 FORMAT( ' Tests of the Singular Value Decomposition routines' )
 9984 FORMAT( / ' The following parameter values will be used:' )
 9983 FORMAT( 4X, A, 10I6, / 10X, 10I6 )
 9982 FORMAT( / ' Routines pass computational tests if test ratio is ',
     $      'less than', F8.2, / )
 9981 FORMAT( ' Relative machine ', A, ' is taken to be', E16.6 )
 9980 FORMAT( ' *** Error code from ', A, ' = ', I4 )
 9979 FORMAT( / ' Tests of the Nonsymmetric Eigenvalue Problem Driver',
     $      / '    CGEEV (eigenvalues and eigevectors)' )
 9978 FORMAT( / ' Tests of the Nonsymmetric Eigenvalue Problem Driver',
     $      / '    CGEES (Schur form)' )
 9977 FORMAT( / ' Tests of the Nonsymmetric Eigenvalue Problem Expert',
     $      ' Driver', / '    CGEEVX (eigenvalues, eigenvectors and',
     $      ' condition numbers)' )
 9976 FORMAT( / ' Tests of the Nonsymmetric Eigenvalue Problem Expert',
     $      ' Driver', / '    CGEESX (Schur form and condition',
     $      ' numbers)' )
 9975 FORMAT( / ' Tests of the Generalized Nonsymmetric Eigenvalue ',
     $      'Problem routines' )
 9974 FORMAT( ' Tests of CHBTRD', / ' (reduction of a Hermitian band ',
     $      'matrix to real tridiagonal form)' )
 9973 FORMAT( / 1X, 71( '-' ) )
 9972 FORMAT( / ' LAPACK VERSION ', I1, '.', I1, '.', I1 )
 9971 FORMAT( / ' Tests of the Generalized Linear Regression Model ',
     $      'routines' )
 9970 FORMAT( / ' Tests of the Generalized QR and RQ routines' )
 9969 FORMAT( / ' Tests of the Generalized Singular Value',
     $      ' Decomposition routines' )
 9968 FORMAT( / ' Tests of the Linear Least Squares routines' )
 9967 FORMAT( ' Tests of CGBBRD', / ' (reduction of a general band ',
     $      'matrix to real bidiagonal form)' )
 9966 FORMAT( / / 1X, A3, ':  NRHS =', I4 )
 9965 FORMAT( / ' Tests of the Generalized Nonsymmetric Eigenvalue ',
     $      'Problem Expert Driver CGGESX' )
 9964 FORMAT( / ' Tests of the Generalized Nonsymmetric Eigenvalue ',
     $      'Problem Driver CGGES' )
 9963 FORMAT( / ' Tests of the Generalized Nonsymmetric Eigenvalue ',
     $      'Problem Driver CGGEV' )
 9962 FORMAT( / ' Tests of the Generalized Nonsymmetric Eigenvalue ',
     $      'Problem Expert Driver CGGEVX' )
 9961 FORMAT( / / 1X, A3, ':  NB =', I4, ', NBMIN =', I4, ', NX =', I4,
     $      ', INMIN=', I4,
     $      ', INWIN =', I4, ', INIBL =', I4, ', ISHFTS =', I4,
     $      ', IACC22 =', I4)
 9960 FORMAT( / ' Tests of the CS Decomposition routines' )
*
*     End of CCHKEE
*
      END
