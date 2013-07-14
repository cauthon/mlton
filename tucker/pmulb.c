#include <x86intrin.h>
#include <stdio.h>
__m128i pmulb(__m128i x,__m128i y){
  __m128i ans;
 unsigned char a[16]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
 __m128i q = _mm_load_si128((__m128i const*)a);
  __asm__  ("movdqa %2, %%xmm2\n"
            "movdqa %3, %%xmm3\n"
            "punpcklbw %1, %2\n"
            "punpcklbw %1, %3\n"
            "pmullw %3, %2\n"
            "punpcklbw %1, %%xmm2\n"
            "punpcklbw %1, %%xmm3\n"
            "pmullw %%xmm3, %%xmm2\n"
            "packuswb %%xmm2, %%xmm2\n"
            "movdqa %%xmm2,%0"
            :"=x" (ans)
            :"x" (q),"x" (x),"x" (y));
  return ans;
}
int main(){
  typedef union{
    unsigned long longs[2];
    __m128i m128i;
  }m128b;
  unsigned char a[16]={2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2};
  unsigned char b[16]={2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2};
  __m128i x=_mm_load_si128((__m128i const*)a);
  __m128i y=_mm_load_si128((__m128i const*)b);
  __m128i z=pmulb(x,y);
  m128b q;
  q.m128i=z;
  printf("ans = %#080lx, %#080lx\n",q.longs[0],q.longs[1]);
  return;
}
