#ifndef CAA_UTL_H_INCLUDED_
#define CAA_UTL_H_INCLUDED_

int **CALLOC2_i(int i_nrow,int i_ncol);
void FREE2_i(int**i_matrix,int i_nrow);
double **CALLOC2_d(int i_nrow,int i_ncol);
void FREE2_d(double**i_matrix,int i_nrow);

#endif // include guard
