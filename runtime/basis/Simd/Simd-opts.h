/*TUCKER: TODO: still need to write all avx macros and still need to
 *write in a few more uses of the word macros*/
/*all of these are unaligned, but its fairly simple to make them aligned*/

#define SimdLoadReal(opcode,size)                   \
  MLTON_CODEGEN_STATIC_INLINE                       \
  Simd128_Real##size##_t                            \
  Simd128_Real##size##_##opcode (Real##size##_t* r){   \
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
#define SimdSetFloat4(opcode)                           \
  MLTON_CODEGEN_STATIC_INLINE                           \
Simd128_Real32_t Simd128_Real32_##opcode                \
(Real32_t r1, Real32_t r2, Real32_t r3, Real32_t r4){   \
  return  _mm_##opcode (r1,r2,r3,r4);                   \
}
SimdSetFloat4(set_ps)
SimdSetFloat4(setr_ps)

#define SimdSetReal1(size,id)                                   \
  MLTON_CODEGEN_STATIC_INLINE                                   \
  Simd128_Real##size##_t                                        \
  Simd128_Real_set1_##id (Real##size##_t r1) {                  \
    return  _mm_set1_##id(r1);                                  \
}

#define SimdSetDouble2(opcode)                          \
  MLTON_CODEGEN_STATIC_INLINE                           \
Simd128_Real64_t Simd128_Real64_##opcode                \
  (Real64_t r1, Real64_t r2){                           \
  return  _mm_##opcode (r1,r2);                         \
}
SimdSetDouble2(set_pd)
SimdSetDouble2(setr_pd)
SimdSetReal1(32,ps)
SimdSetReal1(64,pd)
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
unarySimdReal (sqrt,ps,32)
unarySimdReal (sqrt,pd,64)
/*argv,retype,type,
 *macro to define binary simd real functions, called like
 *binaryReal(add,float*,float*,__m128,ps)(defines a function
 *mlton_add_ps which takes 2 float*s as arguements and another float*
 *which defines a memory location for the result*/
#define binarySimdReal(opcode,id,size)                                  \
  MLTON_CODEGEN_STATIC_INLINE                                           \
  Simd128_Real##size##_t    /*return type*/                             \
  Simd128_Real##size##_##opcode  /*function name*/                      \
  (Simd128_Real##size##_t s1, Simd128_Real##size##_t s2){               \
    return _mm_##opcode##_##id (s1,s2);                                  \
  }
/*there are some functions that have different retvals, but we'll
 *ignore them for right now*/
#define both(opcode)                            \
  binarySimdReal(opcode,ps,32)                    \
  binarySimdReal(opcode,pd,64)
both(add)
both(sub)
both(mul)
both(div)
both(min)
both(max)
#define logicalSimdReal(opcode,id,size)                                  \
  MLTON_CODEGEN_STATIC_INLINE                                           \
  Simd128_Real##size##_t    /*return type*/                             \
  Simd128_Real##size##opcode##b  /*function name*/                      \
  (Simd128_Real##size##_t s1, Simd128_Real##size##_t s2){               \
    return _mm##opcode##_##id (s1,s2);                                  \
  }
#define bothl(opcode)                           \
  logicalSimdReal(opcode,ps,32)               \
  logicalSimdReal(opcode,pd,64)
bothl(_and)
bothl(_or)
bothl(_xor)
bothl(_andnot)
#ifdef __SSE3__
both(hadd)
both(hsub)
both(addsub)
#endif
#undef both
#undef bothl
#undef unarySimdReal
#undef binarySimdReal
#undef logicalSimdReal
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
_mm_set1_epi8 (char __A)*/
/*Defines unary simd integer operations
 *just one arguement of the for <base_opcode>_<suffix>
 *where suffix is of the form ep or s (ep=packed,i=scalar) +
 * i or u (signed or unsigned) + size (8,16,32,64)
 *defines a function mlton_opcode*/

/*#define SimdWordImm(opcode,sign,size)                               \
MLTON_CODEGEN_STATIC_INLINE                                           \
  void Simd_Word_##opcode##_##sign##size                            \
  (__m128i* arg1,__m128i* retval,unsigned char imm){                      \
__m128i x = _mm_loadu_si128(arg1);                       \
 _mm_storeu_si128(retval,_mm_##opcode##_##sign##size (x,imm));}
//defines binary simd integer operations, same syntax as unary ones
#define binarySimdWord(opcode,sign,size)                                \
  MLTON_CODEGEN_STATIC_INLINE                                           \
  void Simd_Word_##opcode##_##sign##size                                \
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

binarySimdWord(and,si,128)
binarySimdWord(andnot,si,128)
binarySimdWord(or,si,128)
binarySimdWord(xor,si,128)
//SimdWordImm(slli,si,128)
//SimdWordImm(srli,si,128)
#undef binarySimdWord
#undef unarySimdWord*/


