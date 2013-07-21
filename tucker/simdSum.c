#include <x86intrin.h>
#include <stdio.h>
#include <time.h>
//(*fun simdSum (v:'a vector) =
//    (*??? pick correct simd type*)
//    (*let simd struct=Simd, element = e, elements/simd = n*)*)
//example written in c, using sse and floats
float simdSum(float* v,int len){
  /* x1|x2|x3|x4 copy & shuffle 00 01 =1 10 11 = b
     x4|x3|x2|x1 add
     y1|y2|y2|y1 copy and shuffle 01 01 01 01
     y2|y2|y1|y1 add
     z | now extract ans*/
  int i;
  float result = 0;
  __m128 x=_mm_setzero_ps(),y;
  //slightly less efficent than other ways, but easiest to write
  switch(len % 4) {
    //    case 7: result += v[len-7];
    //    case 6: result += v[len-6];
    //    case 5: result += v[len-5];
    //    case 4: result += v[len-4];
    case 3: result += v[len-3];
    case 2: result += v[len-2];
    case 1: result += v[len-1];
  }
  __m128 z = _mm_load_ss(&result);
  for(i=0;i<len;i+=4){
    x=_mm_add_ps(x,_mm_load_ps(v+i));
  }
  y=x;
  x=_mm_shuffle_ps(x,y,0x1b);
  x=_mm_add_ps(x,y);
  y=_mm_shuffle_ps(x,y,0x55);
  x=_mm_add_ps(x,y);
  z=_mm_add_ss(x,z);
  /*algebraically the code above and the loop below give the same results
   *however because of floating point numbers the loop above gives a slightly
   *different answer than the one below, granted the one above runs much quicker*/
  /*  for(i=0;i<len;i+=8){
    x=_mm_load_ps(v+i);
    y=_mm_load_ps(v+i+4);
    x=_mm_add_ps(x,y);
    y=_mm_shuffle_ps(x,y,0x1b);
    //y=_mm_movelh_ps(x,y);
    x=_mm_add_ps(x,y);
    y=_mm_shuffle_ps(x,y,0x55);
    x=_mm_add_ps(x,y);
    z=_mm_add_ss(x,z);
    }*/
  _mm_store_ss(&result,z);
  return result;
}
float Sum(float* v,int len){
  float result;
  int i;
  for(i=0;i<len;i++){
    result+=v[i];
  }
  return result;
}
int main(){
  float x[1000000];
  int i;
  clock_t start,simd,end;
  struct timespec t1,t2,t3;
  for (i=0;i<1000000;i++){
    x[i]=i;
  }
  start=clock();
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t1);
  printf("The sum using simdSum is: %f\n",simdSum(x,1000000));
  simd=clock();
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t2);
  printf("The sum using Sum is:     %f\n",Sum(x,1000000));
  end=clock();
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t3);
  printf("Clock Cycles for Simd: %ld\nClock Cycles for Sum : %ld\n",
         (t2.tv_nsec-t1.tv_nsec),(t3.tv_nsec-t2.tv_nsec));
  return;
}
