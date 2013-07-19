/*TUCKER: TODO: still need to write all avx macros and still need to
 *write in a few more uses of the word macros*/
/*all of these are unaligned, but its fairly simple to make them aligned*/

#define SimdLoadReal(opcode,size)                \
  MLTON_CODEGEN_STATIC_INLINE                       \
  Simd128_Real##size##_t                            \
  Simd128_Real##size##_##opcode (Real_##size##_t* r){   \
    return _mm_##opcode (r);                            \
  }
SimdLoadReal(loadu_ps,32)
SimdLoadReal(loadu_pd,64)
SimdLoadReal(load_ps,32)
SimdLoadReal(load_pd,64)
SimdLoadReal(loadr_ps,32)
SimdLoadReal(loadr_pd,64)
SimdLoadReal(load1_ps,32)
SimdLoadReal(load1_pd,64)
#define SimdSetFloat4(opcode){
Simd128_Real32_t Simd128_Real32_##opcode                \
(Real32_t r1, Real32_t r2, Real32_t r3, Real32_t r4){   \
  return  _mm_##opcode (r1,r2,r3,r4);                   \
}
#define SimdSetDouble4(opcode){
Simd128_Real64_t Simd128_Real64_##opcode                \
(Real64_t r1, Real64_t r2, Real64_t r3, Real64_t r4){   \
  return  _mm_##opcode (r1,r2,r3,r4);                   \
}
  /*macro to define unary simd real functions
 *being as there reall is only one its called like this
 *unaryReal(sqrt,double*,double*,__m128d,pd) and this
 *unaryReal(sqrt,float*,float*,__m128,ps)  */
  /*  void Simd128_Real##size##_##opcode (argv arg1,retype retval);     */
#define unarySimdReal(opcode,id,size)                                   \
  MLTON_CODEGEN_STATIC_INLINE                                           \
  Simd128_Real##size##_t                                                \
  Simd128_Real##size##_##opcode (Simd128_Real##size##_t s){             \
    return _mm_##opcode##_##id (s);}                                    
#define unarySimdFloat(opcode)                  \
  unarySimdReal (opcode,ps,32)
unarySimdFloat (sqrt)
#define unarySimdDouble(opcode)\
  unarySimdReal (opcode,pd,64)
unarySimdDouble (sqrt)
/*argv,retype,type,
 *macro to define binary simd real functions, called like
 *binaryReal(add,float*,float*,__m128,ps)(defines a function
 *mlton_add_ps which takes 2 float*s as arguements and another float*
 *which defines a memory location for the result*/
#define binarySimdReal(opcode,id,size)                                  \
  Simd128_Real##size##_t    /*return type*/                             \
  Simd128_Real##size##_##opcode  /*function name*/                      \
  (Simd128_Real##size##_t s1, Simd128_Real##size##_t s2){               \
    return _mm_##opcode##_##id(s1,s2));                                 \
  }
/*there are some functions that have different retvals, but we'll
 *ignore them for right now*/
#define binarySimdFloat(opcode)                         \
  binarySimdReal (opcode,ps,32)
#define binarySimdDouble(opcode)                        \
  binarySimdReal (opcode,ps,32
#define both(opcode)                            \
  binarySimdFloat(opcode)                       \
  binarySimdDouble(opcode)
both(add)
both(sub)
both(mul)
both(div)
both(max)
both(min)
both(and)
both(or)
both(xor)
both(andnot)
#ifdef __SSE3__
both(hadd)
both(hsub)
both(addsub)
#endif
#undef both
#undef unarySimdReal
#undef unarySimdFloat
#undef unarySimdDouble
#undef binarySimdReal
#undef binarySimdFloat
#undef binarySimdDouble
#ifdef __AVX__
/*avx macros*/
#endif
#ifdef __AVX2__
#endif
/*
_mm_set_epi64 (long long __q1, long long __q0)
_mm_set_epi32 (int __q3, int __q2, int __q1, int __q0)
_mm_set_epi16 (short __q7, short __q6, short __q5, short __q4,
	       short __q3, short __q2, short __q1, short __q0)
_mm_set_epi8 (char __q15, char __q14, char __q13, char __q12,
	      char __q11, char __q10, char __q09, char __q08,
	      char __q07, char __q06, char __q05, char __q04,
	      char __q03, char __q02, char __q01, char __q00)
_mm_set1_epi64 (__m64 __A)
_mm_set1_epi32 (int __A)
_mm_set1_epi16 (short __A)
_mm_set1_epi8 (char __A)
/*Defines unary simd integer operations
 *just one arguement of the for <base_opcode>_<suffix>
 *where suffix is of the form ep or s (ep=packed,i=scalar) +
 * i or u (signed or unsigned) + size (8,16,32,64)
 *defines a function mlton_opcode*/

#define SimdWordImm(opcode,sign,size)                           \
  void Simd_Word_##opcode##_##sign##size                            \
  (__m128i* arg1,__m128i* retval,unsigned char imm){                      \
__m128i x = _mm_loadu_si128(arg1);                       \
 _mm_storeu_si128(retval,_mm_##opcode##_##sign##size (x,imm));}
/*defines binary simd integer operations, same syntax as unary ones*/
#define binarySimdWord(opcode,sign,size)                                \
  void Simd_Word_##opcode##_##sign##size                                    \
  (__m128i* arg1,__m128i* arg2,__m128i* retval);                        \
  void Simd_Word_##opcode##_##sign##size                                    \
  (__m128i* arg1,__m128i* arg2,__m128i* retval){                        \
    __m128i x = _mm_loadu_si128(arg1);                                  \
    __m128i y = _mm_loadu_si128(arg2);                                  \
    _mm_storeu_si128(retval,_mm_##opcode##_##sign##size (x,y));}       
#define packedBinary(opcode,sign,size)          \
  binarySimdWord(opcode,ep##sign,size)
#define do8and16(opcode,sign)                     \
  packedBinary(opcode,sign,8)                   \
  packedBinary(opcode,sign,16)
#define do16and32 (opcode,sign)                    \
  packedBinary(opcode,sign,16)                   \
  packedBinary(opcode,sign,32)
#define do16and32and64 (opcode,sign)               \
  do16and32(opcode,sign)                           \
  packedBinary(opcode,sign,64)                    
#define do8and16and32and64                        \
  do16and32and64(opcode,sign)                     \
  packedBinary(opcode,sign,8)

do8and16(avg,u)
do8and16(adds,i)
do8and16(adds,u)
packedBinary(mul,u,32)
/* this is what I wanted to do, even this is execssive for lisp but
 * still impossible in c
void do_defn(){
int j;
for (j=8;j<=64;j*=2){
  if (j == 32){
    packedBinary(mul,i,j)
      }
  if (j == 8 || j == 16){
    packedBinary(avg,u,j)
    both_signs(adds,j)
  } if (j == 8){
    packedBinary(sad,u,i)
    packedBinary(min,u,i)
    packedBinary(max,u,i)
      }
  switch (j) {
  case 16:
    both_signs(mulhi,j)
      packedBinary(madd,i,j)
  case 32:
    packedBinary(sra,i,j)
      packedBinary(srai,i,j)
      packedBinary(add,i,j)
  case 64:
    packedBinary(sll,i,j)
      packedBinary(slli,i,j)
      packedBinary(srl,i,j)
      packedBinary(srli,i,j)
  case 8:
    packedBinary(add,i,j)
      packedBinarp(sub,i,j)
      }
    }
    }*/
binarySimdWord(and,si,128)
binarySimdWord(andnot,si,128)
binarySimdWord(or,si,128)
binarySimdWord(xor,si,128)
/*SimdWordImm(slli,si,128)
  SimdWordImm(srli,si,128)*/
#undef binarySimdWord
#undef unarySimdWord


