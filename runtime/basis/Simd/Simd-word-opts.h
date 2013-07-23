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
