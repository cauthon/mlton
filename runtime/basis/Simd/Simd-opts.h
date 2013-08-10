/*TUCKER: TODO: still need to write all avx macros and still need to
 *write in a few more uses of the word macros*/
/*all of these are unaligned, but its fairly simple to make them aligned*/
/*#define fromArray(size,suffix,opcode,type)                \
  Simd128_Real##size Simd128_Real##size##_fromArray         \
  (Array(Real##size##_t) r,int i){                      \
    return _mm_##opcode##_##suffix((type*)r[i]);        \
  }
fromArray(32,ps,loadu,float)
fromArray(64,pd,loadu,double)*/
#define SimdLoadReal(opcode,size,suffix,type)                   \
  MLTON_CODEGEN_STATIC_INLINE                                   \
  Simd128_Real##size##_t                                        \
  Simd128_Real##size##_##opcode (Array(Real##size##_t) r){      \
    return _mm_##opcode##_##suffix ((type*)r);                  \
  }
SimdLoadReal(loadu,32,ps,float)
SimdLoadReal(loadu,64,pd,double)
SimdLoadReal(load,32,ps,float)
SimdLoadReal(load,64,pd,double)
SimdLoadReal(loadr,32,ps,float)
SimdLoadReal(loadr,64,pd,double)
#define SimdLoad1Real(opcode,size,suffix)                       \
  MLTON_CODEGEN_STATIC_INLINE                                        \
  Simd128_Real##size##_t                                             \
  Simd128_Real##size##_##opcode (Real##size##_t r){                  \
    return _mm_##opcode##_##suffix (&r);                       \
  }
SimdLoad1Real(load1,32,ps)
SimdLoad1Real(load1,64,pd)

#define SimdStoreReal(opcode,size,suffix,type)          \
  MLTON_CODEGEN_STATIC_INLINE                           \
  void Simd128_Real##size##_##opcode                    \
  (Array(Real##size##_t) r,Simd128_Real##size##_t s){   \
    return _mm_##opcode##_##suffix ((type*)r,s);        \
  }
SimdStoreReal(store,32,ps,float)
SimdStoreReal(store,64,pd,double)
SimdStoreReal(storeu,32,ps,float)
SimdStoreReal(storeu,64,pd,double)
SimdStoreReal(storer,32,ps,float)
SimdStoreReal(storer,64,pd,double)
#define SimdLoadScalar(size,suffix,type)                   \
  MLTON_CODEGEN_STATIC_INLINE                                     \
  Simd128_Real##size##_t Simd128_Real##size##_loads               \
  (Real##size##_t r){                                             \
    return _mm_load_##suffix (&r);                                 \
  }
SimdLoadScalar(32,ss,float)
SimdLoadScalar(64,sd,double)

MLTON_CODEGEN_STATIC_INLINE
Real32_t Simd128_Real32_stores (Simd128_Real32_t x){
  float temp;
  asm ("movss %0,%1" : "=x" (temp) : "x" (x));
  return temp;
}
MLTON_CODEGEN_STATIC_INLINE
Real64_t Simd128_Real64_stores (Simd128_Real64_t x){
  double temp;
  asm ("movsd %0,%1" : "=x" (temp) : "x" (x));
  return temp;
}
#define SimdSetFloat4(opcode,suffix)                    \
  MLTON_CODEGEN_STATIC_INLINE                           \
Simd128_Real32_t Simd128_Real32_##opcode                \
(Real32_t r1, Real32_t r2, Real32_t r3, Real32_t r4){   \
  return  _mm_##opcode##_##suffix (r1,r2,r3,r4);        \
}
//unhygenic macro, its not good, but it works
#define asm_cmppd(i)                              \
  asm("cmppd %2,%1,%0" : "=x" (x) : "x" (y), "i" (i));  \
  return x
#define asm_cmpps(i)                              \
  asm("cmpps %2,%1,%0" : "=x" (x) : "x" (y), "i" (i));  \
  return x
MLTON_CODEGEN_STATIC_INLINE
Simd128_Real64_t Simd128_Real64_cmp 
(Simd128_Real64_t x, Simd128_Real64_t y, Word8_t imm){
  switch (imm){
    case 0:asm_cmppd(0);
    case 1:asm_cmppd(1);
    case 2:asm_cmppd(2);
    case 3:asm_cmppd(3);
    case 4:asm_cmppd(4);
    case 5:asm_cmppd(5);
    case 6:asm_cmppd(6);
    case 7:asm_cmppd(7);
  }
}
MLTON_CODEGEN_STATIC_INLINE
Simd128_Real32_t Simd128_Real32_cmp 
(Simd128_Real32_t x, Simd128_Real32_t y, Word8_t imm){
  switch (imm){
    case 0:asm_cmpps(0);
    case 1:asm_cmpps(1);
    case 2:asm_cmpps(2);
    case 3:asm_cmpps(3);
    case 4:asm_cmpps(4);
    case 5:asm_cmpps(5);
    case 6:asm_cmpps(6);
    case 7:asm_cmpps(7);
  }
}
#undef asm_cmpps
#undef asm_cmppd
SimdSetFloat4(set,ps)
SimdSetFloat4(setr,ps)

#define SimdSetReal1(size,opcode,id)                    \
  MLTON_CODEGEN_STATIC_INLINE                           \
  Simd128_Real##size##_t                                \
  Simd128_Real##size##_##opcode (Real##size##_t r1) {   \
    return  _mm_##opcode##_##id(r1);                    \
  }

#define SimdSetDouble2(opcode,suffix)                   \
  MLTON_CODEGEN_STATIC_INLINE                           \
Simd128_Real64_t Simd128_Real64_##opcode                \
  (Real64_t r1, Real64_t r2){                           \
  return  _mm_##opcode##_##suffix (r1,r2);              \
}
SimdSetDouble2(set,pd)
SimdSetDouble2(setr,pd)
SimdSetReal1(32,set1,ps)
SimdSetReal1(64,set1,pd)
  /*macro to define unary simd real functions
 *being as there reall is only one its called like this
 *unaryReal(sqrt,double*,double*,__m128d,pd) and this
 *unaryReal(sqrt,float*,float*,__m128,ps)  */
  /*  void Simd128_Real##size##_##opcode (argv arg1,retype retval);     */
#define unarySimdReal(opcode,id,size)                           \
  MLTON_CODEGEN_STATIC_INLINE                                   \
  Simd128_Real##size##_t                                        \
  Simd128_Real##size##_##opcode (Simd128_Real##size##_t s){     \
    return _mm_##opcode##_##id (s);}                                    
unarySimdReal (sqrt,ps,32)
unarySimdReal (sqrt,pd,64)
/*argv,retype,type,
 *macro to define binary simd real functions, called like
 *binaryReal(add,float*,float*,__m128,ps)(defines a function
 *mlton_add_ps which takes 2 float*s as arguements and another float*
 *which defines a memory location for the result*/
#define binarySimdReal(opcode,id,size)                          \
  MLTON_CODEGEN_STATIC_INLINE                                   \
  Simd128_Real##size##_t    /*return type*/                     \
  Simd128_Real##size##_##opcode  /*function name*/              \
  (Simd128_Real##size##_t s1, Simd128_Real##size##_t s2){       \
    return _mm_##opcode##_##id (s1,s2);                         \
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
define shuffleReal(id,size)                             \
MLTON_COGEGEN_STATIC_INLINE                             \
  Simd128_Real##size##_t                                \
  Simd128_Real##size##_##opcode                         \
  (Simd128_Real##size##_t s1,Simd128_Real##size##_t s2, \
   Word8_t imm){                                        \
    return _mm_shuffle_##id (s1,s2,imm);                \
  }
shuffleReal(ps,32)
shuffleReal(ps,64)
#define logicalSimdReal(opcode,id,size) \
  MLTON_CODEGEN_STATIC_INLINE \
  Simd128_Real##size##_t    /*return type*/ \
  Simd128_Real##size##opcode##b  /*function name*/ \
  (Simd128_Real##size##_t s1, Simd128_Real##size##_t s2){ \
    return _mm##opcode##_##id (s1,s2); \
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
#undef shuffleReal
#ifdef __AVX__
/*avx macros, just redefine above to take a simdSize parameter and 
 call them with it set to 128 above and 256 for avx*/
#endif
#ifdef __AVX2__
#endif
#define binarySimdWord(id,opcode,size,sign)                             \
  MLTON_CODEGEN_STATIC_INLINE                                           \
  Simd128_Word##size##_t    /*return type*/                             \
  Simd128_Word##size##_##opcode##sign  /*function name*/                \
  (Simd128_Word##size##_t s1, Simd128_Word##size##_t s2){               \
    return _mm_##opcode##_##id##size (s1,s2);                           \
  }
#define allBinaryWords(opcode,sign)             \
  binarySimdWord(epi,opcode,8,sign)             \
  binarySimdWord(epi,opcode,16,sign)            \
  binarySimdWord(epi,opcode,32,sign)            \
  binarySimdWord(epi,opcode,64,sign)
#define binaryWords8and16(id,opcode,sign)       \
  binarySimdWord(id,opcode,8,sign)             \
  binarySimdWord(id,opcode,16,sign)
#define binaryWords16and32(id,opcode,sign)       \
  binarySimdWord(id,opcode,16,sign)             \
  binarySimdWord(id,opcode,32,sign)
#define binaryWords8and16and32(id,opcode,sign)       \
  binarySimdWord(id,opcode,8,sign)             \
  binarySimdWord(id,opcode,16,sign)             \
  binarySimdWord(id,opcode,32,sign)
#define binaryWords16and32and64(id,opcode,sign)       \
  binarySimdWord(id,opcode,16,sign)             \
  binarySimdWord(id,opcode,32,sign)             \
  binarySimdWord(id,opcode,64,sign)             
allBinaryWords(add,)
allBinaryWords(sub,)
binaryWords8and16(epi,adds,s)
binaryWords8and16(epu,adds,u)
binaryWords8and16(epi,subs,s)
binaryWords8and16(epu,subs,u)
binaryWords8and16(epu,avg,)
binarySimdWord(epi,mulhi,16,s)
binarySimdWord(epu,mulhi,16,u)
binarySimdWord(epi,mullo,16,s)
binarySimdWord(epu,mul,32,32)
binaryWords8and16and32(epi,cmpgt,)
binaryWords8and16and32(epi,cmpeq,)
binaryWords16and32and64(epi,sll,)
binaryWords16and32and64(epi,srl,)
binaryWords16and32(epi,sra,)
/* SimdWord instruction names
       | Simd_Word_min (w,s) => simd_word (w,"min", SOME s)
       | Simd_Word_max (w,s) => simd_word (w,"max", SOME s)
       | Simd_Word_hadd w => simd_word (w,"hadd", NONE)
       | Simd_Word_hsub w => simd_word (w,"hsub", NONE)
       | Simd_Word_abs w => simd_word (w,"abs", NONE)
       | Simd_Word_andb w => simd_word (w,"andb", NONE)
       | Simd_Word_orb w => simd_word (w,"orb", NONE)
       | Simd_Word_xorb w => simd_word (w,"xorb", NONE)
       | Simd_Word_andnb w => simd_word (w,"andnb", NONE)
       | Simd_Word_sar w => simd_word (w,"sar", NONE)
       | Simd_Word_sll w => simd_word (w,"sll", NONE)
       | Simd_Word_slr w => simd_word (w,"slr", NONE)
       | Simd_Word_fromScalar w => simd_word (w,"loads", NONE)
       | Simd_Word_toScalar w => simd_word (w,"stores", NONE)
       | Simd_Word_fromArray w => simd_word (w,"loadu", NONE)
       | Simd_Word_toArray w => simd_word (w,"storeu", NONE)
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
  void Simd128_Word_##opcode##_##sign##size                            \
  (__m128i* arg1,__m128i* retval,unsigned char imm){                      \
__m128i x = _mm_loadu_si128(arg1);                       \
_mm_storeu_si128(retval,_mm_##opcode##_##sign##size (x,imm));}*/
//defines binary simd integer operations, same syntax as unary ones
#undef binarySimdWord

