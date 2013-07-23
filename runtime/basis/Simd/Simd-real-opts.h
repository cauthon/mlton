/*TUCKER: TODO: still need to write all avx macros*/
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
#undef SimdLoadReal
#define SimdSetFloat4(opcode){
Simd128_Real32_t Simd128_Real32_##opcode                \
(Real32_t r1, Real32_t r2, Real32_t r3, Real32_t r4){   \
  return  _mm_##opcode (r1,r2,r3,r4);                   \
}
SimdSetFloat4(set_ps)
SimdSetFloat4(setr_ps)
MLTON_CODEGEN_STATIC_INLINE                       
Simd128_Real32_t Simd128_Real_set1_ps (Real32_t r1) {
  return  _mm_set1_ps(r1);
}
#undef SimdSetFloat4
#define SimdSetDouble4(opcode){
Simd128_Real64_t Simd128_Real64_##opcode                \
(Real64_t r1, Real64_t r2, Real64_t r3, Real64_t r4){   \
  return  _mm_##opcode (r1,r2,r3,r4);                   \
}
SimdSetDouble4(set_ps)
SimdSetDouble4(setr_ps)
MLTON_CODEGEN_STATIC_INLINE                       
Simd128_Real64_t Simd128_Real_set1_ps (Real64_t r1) {
  return  _mm_set1_ps(r1);
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
  binarySimdReal (opcode,ps,32)
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
//because compairisons return a simd type they're also binary operations
both(cmpeq)
both(cmplt)
both(cmple)
both(cmpunord)
both(cmpneq)
both(cmpnlt)
both(cmpnle)
both(cmpord)
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
