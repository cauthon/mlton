#include <x86intrin.h>
#include <stdio.h>
#include "simdTypedef.h"
void Simd128_Real32_print(m128f x){
  printf("Register Contents: %#0x, %#0x, %#0x, %#0x\nFloat Values: %f, %f, %f, %f\n",
         x.ints[0],x.ints[1],x.ints[2],x.ints[3],
         x.flt[0],x.flt[1],x.flt[2],x.flt[3]);
}
void Simd128_Real32_printScalar(m128f x){
  //is the scalar in 3 or 0 ...?
  printf("Bitwise Value: %#0x\nFloat Value: %f",x.ints[3],x.flt[3]);
}
void Simd128_Real32_printArray(float * x){
  Simd128_Real32_print(_mm_loadu_ps(x));
}

void Simd128_Real64_print(m128d x){
  printf("Register Contents: %#0x, %#0x\nDouble Values: %f, %f\n",
         x.longs[0],x.longs[1],x.dbl[0],x.dbl[1]);
}
