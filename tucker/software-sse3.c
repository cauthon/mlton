#include <x86intrin.h>
#include <stdio.h>
__m128 haddps(__m128 x, __m128 y){
  __m128 tempx=x,tempy=y;
  tempx=_mm_shuffle_ps(tempx,x,_MM_SHUFFLE(2,3,0,1));
  tempy=_mm_shuffle_ps(tempy,y,_MM_SHUFFLE(2,3,0,1));
  tempx=_mm_add_ps(x,tempx);
  tempy=_mm_add_ps(y,tempy);
  return _mm_shuffle_ps(tempx,tempy,_MM_SHUFFLE(3,1,3,1));
}
__m128 addsubps(__m128 x, __m128 y){
  __m128 a = _mm_add_ps(x,y);
  __m128 b = _mm_sub_ps(x,y);
  a=_mm_shuffle_ps(a,b,_MM_SHUFFLE(0,2,1,3));
  return _mm_shuffle_ps(a,a,_MM_SHUFFLE());
}
int main(){
  typedef union{
    __m128 m128;
    float flt[4];
  } m128f;
  __m128 x = {1.0,2.0,3.0,4.0};
  __m128 y = {10.0,20.0,30.0,40.0};
  m128f s,h;
  s.m128=haddps(x,y);
  h.m128=_mm_hadd_ps(x,y);
  printf("Software hadd: %f %f %f %f\n",s.flt[0],s.flt[1],s.flt[2],s.flt[3]);
  printf("Hardware hadd: %f %f %f %f\n",h.flt[0],h.flt[1],h.flt[2],h.flt[3]);
  return;
}

