/*all of these are unaligned, but its fairly simple to make them aligned*/

/*macro to define unary simd real functions
 *being as there reall is only one its called like this
 *unaryReal(sqrt,double*,double*,__m128d,pd) and this
 *unaryReal(sqrt,float*,float*,__m128,ps)  */
#define unarySimdReal(opcode,argv,retype,type,id)                \
  MLTON_CODEGEN_STATIC_INLINE                                    \
  void mlton_##opcode_##id (argv arg1,retypel retval){           \
    type x = _mm_loadu_##id (arg1);                              \
    _mm_storeu_##id (retval,_mm_##opcode##_##id (x));}
#define unarySimdFloat(opcode,retval)\
  unarySimdReal (opcode,float*,retval,__m128,ps)
unarySimdFloat (sqrt, __m128)
#define unarySimdDouble(opcode,retval)\
  unarySimdReal (opcode,double*,retval,__m128d,pd)
unarySimdDouble (sqrt, __m128d)
/*macro to define binary simd real functions, called like
 *binaryReal(add,float*,float*,__m128,ps)(defines a function
 *mlton_add_ps which takes 2 float*s as arguements and another float*
 *which defines a memory location for the result*/
#define binarySimdReal(opcode,argv,retype,type,id)                  \
  MLTON_CODEGEN_STATIC_INLINE                                       \
  void mlton_##opcode_##id (argv arg1,argv arg2,retype retval){     \
  type x = _mm_loadu_##id (arg1);                                   \
  type y = _mm_loadu_##id (arg2);                                   \
  _mm_storeu_##id (retval,_mm_##opcode##_##id(x,y));}
/*there are some functions that have different retvals, but we'll
 *ignore them for right now*/
#define binarySimdFloat(opcode)                         \
  binarySimdReal (opcode,float*,float*,__m128,ps)
binarySimdFloat
#define binarySimdDouble(opcode)                        \
  binarySimdReal (opcode,double*,double*,__m128d,pd)
#define both(opcode)                            \
  binarySimdFloat(opcode)                       \
  binarySimdDouble(opcode)
/*I really miss lisp macros, I could just do a mapcar and define all of these
 *at once
 *Going from lisp macros to c macros is not fun*/
both(add)
both(sub)
both(mul)
both(div)
both(max)
both(min)
both(and)
both(or)
both(xor)
both(andn)
#ifdef __SSE3__
both(hadd)
both(hsub)
both(addsub)
#endif
#undef both
/*Defines unary simd integer operations
 *just one arguement of the for <base_opcode>_<suffix>
 *where suffix is of the form ep or s (ep=packed,i=scalar) +
 * i or u (signed or unsigned) + size (8,16,32,64)
 *defines a function mlton_opcode*/
#define unarySimdWord(opcode)                            \
void mlton_##opcode (__m128i* arg1,__m128i* retval){     \
  MLTON_CODEGEN_STATIC_INLINE                            \
__m128i x = _mm_loadu_si128(arg1);                       \
 _mm_storeu_si128(retval,_mm_##opcode (x));}
/*defines binary simd integer operations, same syntax as unary ones*/
#define binarySimdWord(opcode)                                          \
  MLTON_CODEGEN_STATIC_INLINE                                           \
  void mlton_##opcode (__m128i* arg1,__m128i* arg2,__m128i* retval){    \
    __m128i x = _mm_loadu_si128(arg1);                                  \
    __m128i y = _mm_loadu_si128(arg2);                                  \
    _mm_storeu_si128(retval,_mm_##opcode(x,y));}       
/*GRRR i want to do (defmacro (opcode &rest sizes)
                      (dolist (i sizes)
                        binarySimdWord(
#define allBinary(opcode)                             \
  binarySimdWord(opcode##8)                           \
  binarySimdWord(opcode##16)                          \
  binarySimdWord(opcode##32)                          \
  binarySimdWord(opcode##64)
#define allSigns(opcode)
allBinary(opcode##i)                            \
allBinary(opcode##u)
allSigns(add_ep)
allSigns(sub_ep)
allBinary(min_ep)
allBinary(max_ep)


