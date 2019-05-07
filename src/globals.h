/* globals.h
 * 
 * Copyright (C) 2001 Havard Rue
 * 
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or (at
 * your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 *
 * The author's contact information:
 *
 *       H{\aa}vard Rue
 *       Department of Mathematical Sciences
 *       The Norwegian University of Science and Technology
 *       N-7491 Trondheim, Norway
 *       Voice: +47-7359-3533    URL  : http://www.math.ntnu.no/~hrue  
 *       Fax  : +47-7359-3524    Email: havard.rue@math.ntnu.no
 *
 * RCSId: $Id: globals.h 1 2013-03-28 13:54:24Z hanne $
 *
 */


/*!
  \file globals.h
  \brief Typedefs and defines for \ref globals.c

  This file contains definitions of global variables and other typedefs.

  The random number generator (RNG) used in GMRFLib, need to support the following requirements.

  - A function of type \c GMRFLib_uniform_tp() used to return a Uniform(0,1) variable.
  - A function of type \c GMRFLib_uniform_init_tp() to initialize the RNG
  - A function of type \c GMRFLib_uniform_getstate_tp() which returns in a malloc'ed array the state
    of the RNG
  - A function of type \c GMRFLib_uniform_setstate_tp() which set the state in the RNG.

  GMRFLib's implementation of this RNG is available in the file random.c

*/



#ifndef __GMRFLib_GLOBALS_H__
#define __GMRFLib_GLOBALS_H__

#undef __BEGIN_DECLS
#undef __END_DECLS
#ifdef __cplusplus
# define __BEGIN_DECLS extern "C" {
# define __END_DECLS }
#else
# define __BEGIN_DECLS /* empty */
# define __END_DECLS /* empty */
#endif

__BEGIN_DECLS

#if !defined(GMRFLib_FALSE)
/*!
  \brief Define GMRFLib_FALSE
*/
#define GMRFLib_FALSE 0
#endif

#if !defined(GMRFLib_TRUE)
/*!
  \brief Define GMRFLib_TRUE
*/
#define GMRFLib_TRUE  1
#endif


/*!
  \brief RNG get
*/
typedef double GMRFLib_uniform_tp(void); 	           

/*!
  \brief RNG init
*/
typedef int    GMRFLib_uniform_init_tp(unsigned int seed); 

/*!
  \brief RNG getstate
*/
typedef char*  GMRFLib_uniform_getstate_tp(void);          

/*!
  \brief RNG setstate
*/
typedef int    GMRFLib_uniform_setstate_tp(char *state);   


/*!
  \brief The CPU timing routine
*/
typedef double GMRFLib_get_ctime_tp(void);	 

/* 
   define the global variables, unless __GMRFLib_DONT_DEFINE_GLOBALS is set
 */
#ifndef __GMRFLib_DONT_DEFINE_GLOBALS

extern int GMRFLib_smtp;			  
extern int GMRFLib_blas_level;
extern int GMRFLib_use_wa_table_lookup;
extern int GMRFLib_collect_timer_statistics;
extern int GMRFLib_verify_graph_read_from_disc;

/*!
  \brief Define the function of type GMRFLib_uniform_tp
*/
extern GMRFLib_uniform_tp          *GMRFLib_uniform; 

/*!
  \brief Hold the pointer to the function of type GMRFLib_init_tp
  \sa random.c
*/
extern GMRFLib_uniform_init_tp     *GMRFLib_uniform_init;

/*!
  \brief Hold the pointer to the function of type GMRFLib_getstate_tp
  \sa random.c
*/
extern GMRFLib_uniform_getstate_tp *GMRFLib_uniform_getstate;

/*!
  \brief Hold the pointer to the function of type GMRFLib_setstate_tp
  \sa random.c
*/
extern GMRFLib_uniform_setstate_tp *GMRFLib_uniform_setstate;

/*!
  \brief Hold the pointer to the function of type GMRFLib_get_ctime_tp
  \sa globals.c
*/
extern GMRFLib_get_ctime_tp        *GMRFLib_get_ctime;

#endif

__END_DECLS
#endif




