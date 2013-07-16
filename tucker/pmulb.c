#include <x86intrin.h>
#include <stdio.h>
typedef union{
  unsigned char* bytes;
  __m128i m128i;
}m128b;

__m128i pmulb(__m128i x,__m128i y){
  __m128i tmpx=x,tmpy=y;
  m128b shuf_mask1,shuf_mask2;
  unsigned char m1[16]={128,7,128,6,128,5,128,4,128,3,128,2,128,1,128,0};
  unsigned char m2[16]={128,15,128,14,128,13,128,12,128,11,128,10,128,9,128,8};
  unsigned char t[16]={0};
  __m128i zero=_mm_load_si128((__m128i const*)t);
  /*move low bytes of words to first(least significant) 8 bytes*/
  shuf_mask1.bytes=m1;
  /*move low bytes of words to last(most significant) 8 bytes*/
  shuf_mask2.bytes=m2;
  __asm__  volatile 
    ("punpcklbw %4, %0\n"
     "punpckhbw %4, %1\n"
     "punpcklbw %4, %2\n"
     "punpckhbw %4, %3\n"
     "pmullw %2, %0\n"
     "pmullw %3, %1\n"
     "pshufb %5, %0\n"
     "pshufb %6, %1\n"
     "pand %1,%0\n"
     :"+x" (x), "+x" (tmpx), "+x" (y), "+x" (tmpy)
     :"x" (zero), "x" (shuf_mask1.m128i), "x" (shuf_mask2.m128i));
  return x;
}
int main(){
  typedef union{
    unsigned long longs[2];
    __m128i m128i;
  }m128l;
  const unsigned char a[16]={2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2};
  const unsigned char b[16]={2,2,2,2,2,2,2,2,4,4,4,4,4,4,4,4};
  __m128i x=_mm_load_si128((__m128i const*)a);
  __m128i y=_mm_load_si128((__m128i const*)b);
  __m128i z=pmulb(x,y);
  m128l q;
  q.m128i=z;
  printf("ans = %#080lx, %#080lx\n",q.longs[0],q.longs[1]);
  return;
}
