#include <x86intrin.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
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
float m128Fold(float* v,int len,__m128(*fp)(__m128,__m128),float(*fs)(float,float)){
  /* x1|x2|x3|x4 copy & shuffle 00 01 =1 10 11 = b
     x4|x3|x2|x1 fp
     y1|y2|y2|y1 copy and shuffle 01 01 01 01
     y2|y2|y1|y1 fp
     z | now extract ans*/
  int i;
  float result = v[0],temp;
  __m128 x=_mm_load_ps(v),y;
  //slightly less efficent than other ways, but easiest to write
  switch(len % 4) {
    //    case 7: result += v[len-7];
    //    case 6: result += v[len-6];
    //    case 5: result += v[len-5];
    //    case 4: result += v[len-4];
    case 3: result =(*fs)(result,v[len-3]);
    case 2: result =(*fs)(result,v[len-2]);
    case 1: result =(*fs)(result,v[len-1]);
  }
  __m128 z = _mm_load_ss(&result);
  for(i=4;i<len;i+=4){
    x=(*fp)(x,_mm_load_ps(v+i));
  }
  y=x;
  x=_mm_shuffle_ps(x,y,0x1b);
  x=(*fp)(x,y);
  y=_mm_shuffle_ps(x,y,0x55);
  x=(*fp)(x,y);
  _mm_store_ss(&temp,x);
  return (*fs)(temp,result);
}
void m128App(float* v,int len,__m128(*fp)(__m128),float(*fs)(float)){
  int i;
  for(i=0;i<len;i+=4){
    _mm_store_ps((v+i),(*fp)(_mm_load_ps(v+i)));
  }
  switch(len % 4) {
    case 3: v[len-3]=(*fs)(v[len-3]);
    case 2: v[len-2]=(*fs)(v[len-2]);
    case 1: v[len-1]=(*fs)(v[len-1]);
  }
}
void app(float* v,int len,float(*fs)(float)){
  int i;
  for (i=0;i<len;i++){
    v[i]=(*fs)(v[i]);
  }
}
int find(float*v,int len, float val){
  int i=0;
  while(i<len){
    if (v[i] == val){
      return i;
    }
    i++;
  }
  return -1;
}

int simdFind(float* v,int len, float val){
  register __m128 search=_mm_set1_ps(val);
  __m128 x,y;
  int i=0,overflow=len % 4;
  //Note, you can't just try to load from an arbitrary array index
  //it needs to be 16 byte aligned, duh
  x=_mm_load_ps(v);
  y=_mm_cmpeq_ps(x,search);
  while (!(_mm_movemask_ps(y)) && (i < len)){
    i+=4;
    x=_mm_load_ps(v+i);
    y=_mm_cmpeq_ps(x,search);
  }
  //This seems like it might actually be a reasonable use of goto, but
  //I could be wrong, I feel like I've almost been conditoned to think
  //goto is just evil, but its not, it just needs to be used reasonably
  //as a note, before I added goto I had two redudant switch statements
  //which likely compiled to the same thing but was ugly

 AT_END: switch(_mm_movemask_ps(y)){
    case 0x1: return i;//0001
    case 0x2: return i+1;//0010
    case 0x3: return i;//0011
    case 0x4: return i+2;//0100
    case 0x5: return i;//0101
    case 0x6: return i+1;//0110
    case 0x7: return i;//0111
    case 0x8: return i+3;//1000
    case 0x9: return i;//1001
    case 0xa: return i+1;//1010
    case 0xb: return i://1011
    case 0xc: return i+2;//1100
    case 0xd: return i;//1101
    case 0xe: return i+1;//1110
    case 0xf: return i;//1111
    default: 
      i+=4;
      //are these backwards?
      switch(overflow){
        case 3: x=_mm_set_ps(NAN,NAN,NAN,v[len-1]);
          y=_mm_cmpeq_ps(x,search);
          overflow=0;
          goto AT_END;
        case 2: x=_mm_set_ps(NAN,NAN,v[len-1],v[len-2]);
          y=_mm_cmpeq_ps(x,search);
          overflow=0;
          goto AT_END;
        case 1: x=_mm_set_ps(NAN,v[len-1],v[len-2],v[len-3]);
          y=_mm_cmpeq_ps(x,search);
          overflow=0;
          goto AT_END;
        default: return -1;
      }
  }
}
float Sum(float* v,int len){
  float result;
  int i;
  for(i=0;i<len;i++){
    result+=v[i];
  }
  return result;
}
float max(float a,float b){
  return (a>b?a:b);
}
__m128 max_ps(__m128 a,__m128 b){
  return _mm_max_ps(a,b);
}
float times2(float a){
  return 1/sqrtf(a);
}
__m128 m128_two= {2.5,2.5,2.5,2.5};
__m128 times2_m128(__m128 a){
  return _mm_rsqrt_ps(a);
}
//double simdFold(double* v,int len,__m256d(*fp)(__mm256d,__m256d));
int main(){
  float x[1000000];
  int i;
  struct timespec t1,t2,t3;
  for (i=0;i<1000000;i++){
    x[i]=i;
  }
  __m128 (*fp)(__m128);
  float (*fs)(float);
  /*
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t1);
  printf("The sum using simdSum is: %f\n",simdSum(x,1000000));
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t2);
  printf("The sum using Sum is:     %f\n",Sum(x,1000000));
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t3);
  printf("Clock Cycles for Simd: %ld\nClock Cycles for Sum : %ld\n",
  (t2.tv_nsec-t1.tv_nsec),(t3.tv_nsec-t2.tv_nsec));*/
  /* __m128 (*fp)(__m128,__m128);
  float (*fs)(float,float);
  fp = max_ps;
  fs = max;
  for (i=0;i<10005;i++){
    x[i]=i;//(rand() % 100000);
  }
  printf("Max of x: %f\n",m128Fold(x,10000,fp,fs));*/
  /* srandom((unsigned int)time(NULL));
  int index = ((random() % 1200000)-100000);
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t1);
  printf("value %d found at index %d using simdFind\n"
         ,index,simdFind(x,1000000,index));
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t2);
  printf("value %d found at index %d using find\n"
         ,index,find(x,1000000,index));
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t3);
  printf("Clock Cycles for Simd: %ld\nClock Cycles for find : %ld\n",
  (t2.tv_nsec-t1.tv_nsec),(t3.tv_nsec-t2.tv_nsec));
  return;*/
#define cmp_time(a,b,c)                         \
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t1);  \
  a                                             \
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t2);  \
  b                                             \
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t3);  \
  printf(c,t2.tv_nsec-t1.tv_nsec),(t3.tv_nsec-t2.tv_nsec)))
  
  fp = times2_m128;
  fs = times2;
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t1);
  m128App(x,1000000,fp,fs);
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t2);
  app(x,1000000,fs);
  clock_gettime(CLOCK_PROCESS_CPUTIME_ID,&t3);
  printf("Clock Cycles for Simd: %ld\nClock Cycles for map:  %ld\n",
  (t2.tv_nsec-t1.tv_nsec),(t3.tv_nsec-t2.tv_nsec));
}
