#include <x86intrin.h>
void add(float* arg1,float* arg2,float* retval){
  __m128 x = _mm_loadu_ps(arg1);
  __m128 y = _mm_loadu_ps(arg2);
  _mm_storeu_ps(retval,_mm_add(x,y));
}
void sub(float* arg1,float* arg2,float* retval){
  __m128 x = _mm_loadu_ps(arg1);
  __m128 y = _mm_loadu_ps(arg2);
  _mm_storeu_ps(retval,_mm_sub(x,y));
}
void mul(float* arg1,float* arg2,float* retval){
  __m128 x = _mm_loadu_ps(arg1);
  __m128 y = _mm_loadu_ps(arg2);
  _mm_storeu_ps(retval,_mm_mul(x,y));
}
void div(float* arg1,float* arg2,float* retval){
  __m128 x = _mm_loadu_ps(arg1);
  __m128 y = _mm_loadu_ps(arg2);
  _mm_storeu_ps(retval,_mm_div(x,y));
}
