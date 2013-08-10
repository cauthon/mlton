#include <x86intrin.h>
#ifndef _SIMD_TYPES_H_
#define _SIMD_TYPES_H_
typedef union {
  float flt[4];
  unsigned int ints[4];
  __m128 m128f ;
} m128f;
typedef union {
  double dbl[2];
  unsigned long longs[2];
  __m128d m128d;
} m128d;
typedef union{
   __m128i m128i;
  unsigned char bytes[16];
  unsigned short words[8];
  unsigned int ints[4];
  unsigned long longs[2];
} m128i;
typedef union{
  m128i i;
  m128f f;
  m128d d;
} m128;
#endif
