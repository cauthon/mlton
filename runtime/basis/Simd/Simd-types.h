typedef __m128 Simd128_Real32;
typedef __m128d Simd128_Real64;
#define SimdWord(n) typedef __m128i  Simd128_Word##n
int i;
for (i=8;i<=64;i*=2){
  SimdWord(i);
 }
#undef SimdWord
#ifdef __AVX__
typedef __m256 Simd256_Real32
typedef __m256d Simd256_Real64
#define SimdWord(n) typedef __m256i Simd256_Word##n
for (i=8;i<=64;i*=2){
  SimdWord(i);
 }
#undef SimdWord
#endif
