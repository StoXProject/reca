!> \brief \b SLARTG generates a plane rotation with real cosine and real sine.
!
!  =========== DOCUMENTATION ===========
!
! Online html documentation available at
!            http://www.netlib.org/lapack/explore-html/
!
!  Definition:
!  ===========
!
!       SUBROUTINE SLARTG( F, G, C, S, R )
!
!       .. Scalar Arguments ..
!       REAL(wp)          C, F, G, R, S
!       ..
!
!> \par Purpose:
!  =============
!>
!> \verbatim
!>
!> SLARTG generates a plane rotation so that
!>
!>    [  C  S  ]  .  [ F ]  =  [ R ]
!>    [ -S  C  ]     [ G ]     [ 0 ]
!>
!> where C**2 + S**2 = 1.
!>
!> The mathematical formulas used for C and S are
!>    R = sign(F) * sqrt(F**2 + G**2)
!>    C = F / R
!>    S = G / R
!> Hence C >= 0. The algorithm used to compute these quantities
!> incorporates scaling to avoid overflow or underflow in computing the
!> square root of the sum of squares.
!>
!> This version is discontinuous in R at F = 0 but it returns the same
!> C and S as SLARTG for complex inputs (F,0) and (G,0).
!>
!> This is a more accurate version of the BLAS1 routine SROTG,
!> with the following other differences:
!>    F and G are unchanged on return.
!>    If G=0, then C=1 and S=0.
!>    If F=0 and (G .ne. 0), then C=0 and S=sign(1,G) without doing any
!>       floating point operations (saves work in SBDSQR when
!>       there are zeros on the diagonal).
!>
!> If F exceeds G in magnitude, C will be positive.
!>
!> Below, wp=>sp stands for single precision from LA_CONSTANTS module.
!> \endverbatim
!
!  Arguments:
!  ==========
!
!> \param[in] F
!> \verbatim
!>          F is REAL(wp)
!>          The first component of vector to be rotated.
!> \endverbatim
!>
!> \param[in] G
!> \verbatim
!>          G is REAL(wp)
!>          The second component of vector to be rotated.
!> \endverbatim
!>
!> \param[out] C
!> \verbatim
!>          C is REAL(wp)
!>          The cosine of the rotation.
!> \endverbatim
!>
!> \param[out] S
!> \verbatim
!>          S is REAL(wp)
!>          The sine of the rotation.
!> \endverbatim
!>
!> \param[out] R
!> \verbatim
!>          R is REAL(wp)
!>          The nonzero component of the rotated vector.
!> \endverbatim
!
!  Authors:
!  ========
!
!> \author Edward Anderson, Lockheed Martin
!
!> \date July 2016
!
!> \ingroup OTHERauxiliary
!
!> \par Contributors:
!  ==================
!>
!> Weslley Pereira, University of Colorado Denver, USA
!
!> \par Further Details:
!  =====================
!>
!> \verbatim
!>
!>  Anderson E. (2017)
!>  Algorithm 978: Safe Scaling in the Level 1 BLAS
!>  ACM Trans Math Softw 44:1--28
!>  https://doi.org/10.1145/3061665
!>
!> \endverbatim
!
subroutine SLARTG( f, g, c, s, r )
   use LA_CONSTANTS, &
   only: wp=>sp, zero=>szero, half=>shalf, one=>sone, &
         rtmin=>srtmin, rtmax=>srtmax, safmin=>ssafmin, safmax=>ssafmax
!
!  -- LAPACK auxiliary routine --
!  -- LAPACK is a software package provided by Univ. of Tennessee,    --
!  -- Univ. of California Berkeley, Univ. of Colorado Denver and NAG Ltd..--
!     February 2021
!
!  .. Scalar Arguments ..
   real(wp) :: c, f, g, r, s
!  ..
!  .. Local Scalars ..
   real(wp) :: d, f1, fs, g1, gs, p, u, uu
!  ..
!  .. Intrinsic Functions ..
   intrinsic :: abs, sign, sqrt
!  ..
!  .. Executable Statements ..
!
   f1 = abs( f )
   g1 = abs( g )
   if( g == zero ) then
      c = one
      s = zero
      r = f
   else if( f == zero ) then
      c = zero
      s = sign( one, g )
      r = g1
   else if( f1 > rtmin .and. f1 < rtmax .and. &
            g1 > rtmin .and. g1 < rtmax ) then
      d = sqrt( f*f + g*g )
      p = one / d
      c = f1*p
      s = g*sign( p, f )
      r = sign( d, f )
   else
      u = min( safmax, max( safmin, f1, g1 ) )
      uu = one / u
      fs = f*uu
      gs = g*uu
      d = sqrt( fs*fs + gs*gs )
      p = one / d
      c = abs( fs )*p
      s = gs*sign( p, f )
      r = sign( d, f )*u
   end if
   return
end subroutine
