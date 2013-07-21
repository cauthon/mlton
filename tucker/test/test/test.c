#include <x86intrin.h>
#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
typedef union {
  __m128i word128;
  char byte[16];
  short word[8];
  int dword[4];
  long qword[2];
} m128i;
typedef union {
  __m128 m128;
  float flt[4];
} m128f;
typedef union {
  __m256 m256;
  float flt[4];
} m256f;
typedef union {
  __m128d m128;
  double dbl[2];
} m128d;
typedef union {
  __m256d m256;
  double dbl[4];
} m256d;
typedef union {
  m128f simd_float;
  m128d simd_double;
  m128i simd_int;
} m128;
typedef struct {
  float* vals;
  int M;
  int N;
} matrixf;
typedef struct {
  double* vals;
  int M;
  int N;
} matrixd;
/*float mm128f_dot (float* A,float* B,int len){
  for (int i=0;i<len;i++)*/
/*compile with -Ofast & -mavx(or -O3 -ffast-math) and you get code equivlant
 *to what you would hand write using simd intrinsics, if not better(anything
 *less than -Ofast on gcc/clang will only generate the naive version*/
float dot_f (float* A,float* B,int len){
  float temp=0;
  for(int i=0;i<len;i++){
    temp+=A[i]+B[i];
  }
  return temp;
}
double dot_d (double* A,double* B,int len){
  double temp;
  for(int i=0;i<len;i++){
    temp+=A[i]+B[i];
  }
  return temp;
}
__m128d x2_m128d (double* A){
  m128d temp;
  __m128d x = _mm_load_pd((const double*)A);
  temp.dbl[0]=2.0,temp.dbl[1]=2.0;
  return _mm_mul_pd(x,temp.m128);
}
__m256d x2_m256d (double* A){
  m256d temp;
  temp.dbl[0]=2.0,temp.dbl[1]=2.0,temp.dbl[2]=2.0,temp.dbl[3]=2.0;
  return _mm256_mul_pd(_mm256_load_pd((const double*)A),temp.m256);
}
/*this however compiles to the naive version regardless of the switches used*/
/*matrixd* mat_mult_naive (matrixd *A,matrixd *B, matrixd *C){
  int i,j,k;
  assert(B->M==A->N && C->M==A->M && C->N==B->N);
  for (i=0;i<A->M;i++){
    for (j=0;j<B->N;j++){
      for (k=0;k<A->N;k++){
        C->vals[i*B->N+j] += B->vals[B->M*k+j]*A->vals[A->M*i+k];//...i think?
      }
    }
  }
  return C;
}*/
/*double
m256d_mdot (double* A,double* B,int len,int bstep){
  //A&B are really matricies
  //so why not just have matrices as arguments...
  int i;
  m256d x,y;
  double result=0;
  for(i=0;i<len;i+=4){
    x.m256=_m256_load_pd((const double*)(A+i));
    y.dbl[0]=*(B+i*bstep);
    y.dbl[1]=*((B+((i+1)*bstep)));
    y.dbl[2]=*((B+((i+2)*bstep)));
    y.dbl[3]=*((B+((i+3)*bstep)));
    x.m256=_m256_mul_pd(x.m256,y.m256);
    result+=x.dbl[0]+x.dbl[1]+x.dbl[2]+x.dbl[3];
  }
  return result;  
}
matrixd*
mat_mult(matrixd* A,matrixd* B,matrixd *C){
  int i,j,k;
  //assert stuff
  for (i=0;i<A->M;i++){
    for (j=0;j<B->N;j++){
      C->vals[i*B->N+j]=m256d_mdot(A->vals+(i*A->M),B->vals+j,A->M,B->N);
    }
  }
  return C;
}
    
matrixd make_matrixd_uninit(int M,int N){
  double* mat=malloc(N*M*sizeof(double));
  return {mat,M,N};
  }*/
