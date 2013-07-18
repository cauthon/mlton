#include <stdio.h>
#include <x86intrin.h>
#define binarySimdReal(opcode,argv,retype,type,id)                  \
  void mlton_##opcode##_##id (argv arg1,argv arg2,retype retval){     \
    type x = _mm_loadu_##id (arg1);                                   \
    type y = _mm_loadu_##id (arg2);                                   \
      _mm_storeu_##id                                                 \
        (retval,_mm_##opcode##_##id(x,y));}
#define binarySimdDouble(opcode,retype)                 \
  binarySimdReal (opcode,double*,retype,__m128d,pd)
typedef union {
  __m128d m128;
  double dbl[2];
} m128d;
binarySimdDouble (add, double*)
int main(){
  double arg1[2]={2,4},arg2[2]={8,16},retval[2];
  mlton_add_pd(arg1,arg2,retval);
  printf("retval %lf, %lf\n",retval[0],retval[1]);
  return;
}
