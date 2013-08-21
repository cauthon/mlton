#include <x86intrin.h>
#include <stdio.h>
#include <stdlib.h>
typedef union {
  float flt[4];
  unsigned int ints[4];
  __m128 m128f;
} m128f;
m128f simple1,simple2,simple3;
  float simple1_temp[4]={1.0,2.0,3.0,4.0};
  float simple2_temp[4]={5.0,6.0,7.0,8.0};
  float simple3_temp[4]={9.0,10.0,11.0,12.0};
__m128 _mm_fma_ps(__m128 s1,__m128 s2,__m128 s3){
  return _mm_add_ps(s1,_mm_mul_ps(s2,s3));
}
char* toString(m128f s){
  char* str;
  int size = 100*sizeof(char);
  if ((str = malloc(size)) == NULL){
    return NULL;
  }
  if (snprintf(str, size, "(%f,%f,%f,%f)",
               s.flt[0],s.flt[1],s.flt[2],s.flt[3]) == 0){
    return NULL;
  }
  return str;
}
int main(){
  m128f temp;
  simple1.m128f=_mm_load_ps(simple1_temp);
  simple2.m128f=_mm_load_ps(simple2_temp);
  simple3.m128f=_mm_load_ps(simple3_temp);
  temp.m128f = _mm_fma_ps(simple1.m128f,simple2.m128f,simple3.m128f);
  return
    printf("Results for testing simd fma:\n%s\n",toString(temp));
}
