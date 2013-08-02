#include <x86intrin.h>
#include <stdio.h>
typedef union {
  float flt[4];
  unsigned int ints[4];
  __m128 m128f;
} m128f;

void Simd128_Real32_print(__m128 x){
  m128f temp;
  temp.m128f=x;
  printf("Register Contents: %#0x, %#0x, %#0x, %#0x\nFloat Values: %f, %f, %f, %f\n",
         temp.ints[0],temp.ints[1],temp.ints[2],temp.ints[3],
         temp.flt[0],temp.flt[1],temp.flt[2],temp.flt[3]);
}
void Simd128_Real32_printScalar(m128f x){
  //is the scalar in 3 or 0 ...?
  printf("Bitwise Value: %#0x\nFloat Value: %f\n",x.ints[0],x.flt[0]);
}
