/* graph.h
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
 * RCSId: $Id: graph.h 1 2013-03-28 13:54:24Z hanne $
 *
 */
/*!
  \file graph.h
  \brief Typedefs and defines for \ref graph.c
*/

#ifndef __GMRFLib_GRAPH_H__
#define __GMRFLib_GRAPH_H__

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

#if !defined(__FreeBSD__) && !defined(__MACH__)
#include <malloc.h>
#endif
#include <stdlib.h>
#include <stdio.h>

/*
  unsigned char
 */
typedef unsigned char GMRFLib_uchar;

/* 
   for the (sometimes) fast 'IS_NEIGBOUR' function
 */
typedef struct
{
    int low, high;
    GMRFLib_uchar *bitmask;
}
GMRFLib_Is_Neighb_tp;

/*!
  \brief A template for functions defining the precision matrix <em>\b Q</em> of a GMRF <em>\b x</em>.

  \param node, nnode The nodes of the graph for which to compute the precision. <b> Note that node
  and nnode are always to be neighbours, or equal!</b> \param argument A \em character -pointer
  holding the address of a variable or data structure defining the arguments to the function.
  \return The value <em>Q(node,nnode)</em>, that is, the element of the precision matrix
  corresponding to nodes \em node and \em nnode.
  
  \remarks The precision matrix definition is problem specific, and should be provided by the user
  by implementing a function of the stated format.  A pointer to a \c GMRFLib_Qfunc_tp() is needed
  as an argument to \c GMRFLib_init_problem(), initializing the sampling problem.
  
  \par Example
  Consider the precision matrix
  \f[ Q_{ij} = \left\{\begin{array}{ll}nnbs[i] & \mbox{if  } i==j \\ 
  -1 & \mbox{if  } i \neq j \end{array}\right. \f]
  where <em>nnbs[i]</em> is the number of neighbours of node \em i in 
  the graph. This is the precision matrix <em>\b Q</em> of a GMRF with 
  density of the form 
  \f[ \pi(\bf{x}) \propto \exp(-\frac{1}{2}\sum_{i \sim j}(x_i -
      x_j)^2) = \exp(-\frac{1}{2}\bf{x}^T\bf{Q}\bf{x}) \f]
  A function of type \c GMRFLib_Qfunc_tp() implementing this precision matrix is
  \verbinclude example_doxygen_Qfunc_tp.txt	
  In this case, the problem specific \em char* argument is a \em graph
  -pointer, and the function uses a cast from \em char* to \em graph* to 
  access the \em graph -object. Note that the function requires nodes 
  \em node and \em nnode to be neighbours or equal!
  
  \sa GMRFLib_Qx
*/
typedef double GMRFLib_Qfunc_tp(int node, int nnode, char *argument);


/*!
  \struct GMRFLib_graph_tp graph.h 
  \brief Define the graph-type
 */
typedef struct
{
  /*!
    \brief Number of nodes in the graph.
  */
  int n;
    
  /*!
    \brief Number of neighbours for each node.
   
    A length \em n array, where <em>nnbs[i]</em> contains the number of neighbours of node <em>i; i
    = 0,..., n-1.</em> \n\n
   */
  int *nnbs;

  /*!
    \brief For each node: node numbers for neighbours 
   
    A length \em n array of arrays, where <em>nbs[i][j]</em> contains the node numbers <em>j; j =
    0,..., nnbs[j]-1</em> for the neighbours of node \em i. \n\n
   */
  int **nbs;

  /*!
    \brief For \em i in graph, then <em>mothergraph_idx[i]</em> is in the mother graph.
    
    If the graph is a subgraph, <em>mothergraph_idx[i]</em> is the index of node \em i in the
    mothergraph of the current graph. \n\n
   */
  int *mothergraph_idx;	
}
GMRFLib_graph_tp;

typedef struct
{
    /* 
       object to return when shifting a problem, containing a new graph, Qfunc and Qfunc_arg which
       work on the shifted graph

       ...not yet decided if this is the best way to doit.
    */
    GMRFLib_graph_tp *graph;
    GMRFLib_Qfunc_tp *Qfunc;
    char *Qfunc_arg;
}
GMRFLib_offset_tp;

typedef struct
{
    /* 
       arguments needed to return the correct value in GMRFLib_graph_offset_tp
    */
    GMRFLib_Qfunc_tp *Qfunc;			  /* original Qfunc */
    char *Qfunc_arg;				  /* original Qfunc_arg */
    int offset;					  /* offset */
    int n;					  /* original graph->n */
}
GMRFLib_offset_arg_tp;



int GMRFLib_nQelm(GMRFLib_graph_tp *graph);
int GMRFLib_getbit(GMRFLib_uchar c, unsigned int bitno);
int GMRFLib_setbit(GMRFLib_uchar *c, unsigned int bitno);
int GMRFLib_printbits(FILE *fp, GMRFLib_uchar c);
int GMRFLib_make_empty_graph(GMRFLib_graph_tp **graph);
int GMRFLib_read_graph(GMRFLib_graph_tp **graph, char *filename);
int GMRFLib_read_graph_binary(GMRFLib_graph_tp **graph, char *filename);
int GMRFLib_print_graph(FILE *fp, GMRFLib_graph_tp *graph);
int GMRFLib_write_graph(char *filename, GMRFLib_graph_tp *graph);
int GMRFLib_write_graph_binary(char *filename, GMRFLib_graph_tp *graph);
int GMRFLib_free_graph(GMRFLib_graph_tp *graph);
int GMRFLib_prepare_graph(GMRFLib_graph_tp *graph);
int GMRFLib_make_nodes_unique(GMRFLib_graph_tp *graph);
int GMRFLib_intcmp(const void *a, const void *b);
int GMRFLib_sort_nodes(GMRFLib_graph_tp *graph);
int GMRFLib_compute_bandwidth(GMRFLib_graph_tp *graph, int *remap);
int GMRFLib_find_idx(int *idx, int n, int *iarray, int value);
int GMRFLib_validate_graph(FILE *fp, GMRFLib_graph_tp *graph);
int GMRFLib_remap_graph(GMRFLib_graph_tp **ngraph, GMRFLib_graph_tp *graph, int *remap);
int GMRFLib_copy_graph(GMRFLib_graph_tp **graph_new, GMRFLib_graph_tp *graph_old);
int GMRFLib_compute_subgraph(GMRFLib_graph_tp **subgraph, GMRFLib_graph_tp *graph, char *remove_flag);
int GMRFLib_convert_to_mapped(double *destination,  double *source, GMRFLib_graph_tp *graph, int *remap);
int GMRFLib_convert_from_mapped(double *destination,  double *source, GMRFLib_graph_tp *graph, int *remap);
int GMRFLib_Qx(double *result, double *x, GMRFLib_graph_tp *graph, GMRFLib_Qfunc_tp *Qfunc, char *Qfunc_arg);
double GMRFLib_xQx(double *x, GMRFLib_graph_tp *graph, GMRFLib_Qfunc_tp *Qfunc, char *Qfunc_arg);
int GMRFLib_lattice2node(int *node, int irow, int icol, int nrow, int ncol);
int GMRFLib_node2lattice(int node, int *irow, int *icol, int nrow, int ncol);
int GMRFLib_make_lattice_graph(GMRFLib_graph_tp **graph,
			   int nrow, int ncol, int nb_row, int nb_col, int cyclic_flag);
int GMRFLib_prune_graph(GMRFLib_graph_tp **new_graph, GMRFLib_graph_tp *graph,
			GMRFLib_Qfunc_tp *Qfunc, char *Qfunc_arg);
int GMRFLib_make_linear_graph(GMRFLib_graph_tp **graph, int n, int bw, int cyclic_flag);
int GMRFLib_make_rw_graph(GMRFLib_graph_tp **graph, GMRFLib_rwdef_tp *def);
int GMRFLib_make_crw_graph(GMRFLib_graph_tp **graph, GMRFLib_crwdef_tp *def);
int GMRFLib_fold_graph(GMRFLib_graph_tp **ng, GMRFLib_graph_tp *g, GMRFLib_graph_tp *gg);
int GMRFLib_nfold_graph(GMRFLib_graph_tp **ng, GMRFLib_graph_tp *og, int nfold);
int GMRFLib_is_neighb(int node, int nnode, GMRFLib_graph_tp *graph);
int GMRFLib_union_graph(GMRFLib_graph_tp **union_graph, GMRFLib_graph_tp **graph_array, int
			n_graphs);
int GMRFLib_complete_graph(GMRFLib_graph_tp **n_graph, GMRFLib_graph_tp *graph);
int GMRFLib_offset_graph(GMRFLib_graph_tp **new_graph, int n_new,  int offset, GMRFLib_graph_tp *graph);
double GMRFLib_offset_Qfunc(int node, int nnode,  char *arg);
int GMRFLib_offset(GMRFLib_offset_tp **off, int n_new,  int offset,
		   GMRFLib_graph_tp *graph, GMRFLib_Qfunc_tp *Qfunc, char *Qfunc_arg);



__END_DECLS
#endif
