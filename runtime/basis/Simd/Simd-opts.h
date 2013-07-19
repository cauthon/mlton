/*TUCKER: TODO: still need to write all avx macros and still need to
 *write in a few more uses of the word macros*/
/*all of these are unaligned, but its fairly simple to make them aligned*/
/* insert  MLTON_CODEGEN_STATIC_INLINE into all macros, but I don't 
 *  exactally how it works*/

/*macro to define unary simd real functions
 *being as there reall is only one its called like this
 *unaryReal(sqrt,double*,double*,__m128d,pd) and this
 *unaryReal(sqrt,float*,float*,__m128,ps)  */
#define unarySimdReal(opcode,argv,retype,type,id)                \
  void mlton_##opcode##_##id (argv arg1,retype retval);           \
  void mlton_##opcode##_##id (argv arg1,retype retval){           \
    type x = _mm_loadu_##id (arg1);                              \
    _mm_storeu_##id (retval,_mm_##opcode##_##id (x));}
#define unarySimdFloat(opcode,retval)\
  unarySimdReal (opcode,float*,retval,__m128,ps)
unarySimdFloat (sqrt, float*)
#define unarySimdDouble(opcode,retval)\
  unarySimdReal (opcode,double*,retval,__m128d,pd)
unarySimdDouble (sqrt, double*)
/*macro to define binary simd real functions, called like
 *binaryReal(add,float*,float*,__m128,ps)(defines a function
 *mlton_add_ps which takes 2 float*s as arguements and another float*
 *which defines a memory location for the result*/
#define binarySimdReal(opcode,argv,retype,type,id)                  \
  void mlton_##opcode##_##id (argv arg1,argv arg2,retype retval);     \
  void mlton_##opcode##_##id (argv arg1,argv arg2,retype retval){     \
  type x = _mm_loadu_##id (arg1);                                   \
  type y = _mm_loadu_##id (arg2);                                   \
  _mm_storeu_##id (retval,_mm_##opcode##_##id(x,y));}
/*there are some functions that have different retvals, but we'll
 *ignore them for right now*/
#define binarySimdFloat(opcode)                         \
  binarySimdReal (opcode,float*,float*,__m128,ps)
#define binarySimdDouble(opcode)                        \
  binarySimdReal (opcode,double*,double*,__m128d,pd)
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
/*Defines unary simd integer operations
 *just one arguement of the for <base_opcode>_<suffix>
 *where suffix is of the form ep or s (ep=packed,i=scalar) +
 * i or u (signed or unsigned) + size (8,16,32,64)
 *defines a function mlton_opcode*/
#define SimdWordImm(opcode,sign,size)                           \
  void mlton_##opcode##_##sign##size                            \
  (__m128i* arg1,__m128i* retval,unsigned char imm){                      \
__m128i x = _mm_loadu_si128(arg1);                       \
 _mm_storeu_si128(retval,_mm_##opcode##_##sign##size (x,imm));}
/*defines binary simd integer operations, same syntax as unary ones*/
#define binarySimdWord(opcode,sign,size)                                \
  void mlton_##opcode##_##sign##size                                    \
  (__m128i* arg1,__m128i* arg2,__m128i* retval);                        \
  void mlton_##opcode##_##sign##size                                    \
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


