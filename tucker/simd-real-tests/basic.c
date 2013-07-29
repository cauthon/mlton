#include <x86intrin.h>
#include <stdio.h>
#include "simdTypedef.h"
m128f simple1,simple2,rand1,rand2,pi,e,temp1,temp2,temp3;
simple1.m128f = _mm_setr_ps(1.0,2.0,3.0,4.0);
simple2.m128f = _mm_setr_ps(5.0,6.0,7.0,8.0);
rand1.m128f = _mm_setr_ps(0.14751956, 0.2372235, 0.6751645, 0.8104256);
rand2.m128f = _mm_setr_ps(0.83982096, 0.98309407, 0.78378120, 0.03415542);
pi.m128f = _mm_load_ss(&3.14159265358);
e.m128f = _mm_load_ss(&2.71828182845);
void print_control((__m128)(*fp)(__m128,__m128)){
  temp1.m128f=(*fp)(simple1.m128f,simple2.m128f);
  temp2.m128f=(*fp)(rand1.m128f,rand2.m128f);
  temp3.m128f=(*fp)(pi.m128f,e.m128f)
