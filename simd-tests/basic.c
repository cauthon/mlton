#include <x86intrin.h>
#include <stdio.h>
typedef union {
  float flt[4];
  unsigned int ints[4];
  __m128 m128f;
} m128f;
m128f simple1,simple2,rand1,rand2,scalar1,scalar2,temp1,temp2,temp3;
float scalar1_temp = 2.71828182845, scalar2_temp = 3.14159265358;
float simple1_temp[4]={1.0,2.0,3.0,4.0};
float simple2_temp[4]={5.0,6.0,7.0,8.0};
float rand1_temp[4]={0.14751956, 0.2372235, 0.6751645, 0.8104256};
float rand2_temp[4]={0.83982096, 0.98309407, 0.78378120, 0.03415542};

void Simd128_Real32_print(m128f x){
  printf("Register Contents: %#0x, %#0x, %#0x, %#0x\nFloat Values: %f, %f, %f, %f\n",
         x.ints[0],x.ints[1],x.ints[2],x.ints[3],
         x.flt[0],x.flt[1],x.flt[2],x.flt[3]);
}
void Simd128_Real32_printScalar(m128f x){
  //is the scalar in 3 or 0 ...?
  printf("Bitwise Value: %#0x\nFloat Value: %f\n",x.ints[0],x.flt[0]);
}
#define print_control(name)                                             \
  void print_control_##name () {                                        \
    temp1.m128f = _mm_##name##_ps(simple1.m128f,simple2.m128f);         \
    temp2.m128f=_mm_##name##_ps(rand1.m128f,rand2.m128f);             \
    temp3.m128f=_mm_##name##_ps(scalar1.m128f,scalar2.m128f);       \
  printf("Expected values for simd " #name ":\n");                      \
  printf("Simple:\n");                                                   \
  Simd128_Real32_print(temp1);                                          \
  printf("Rand:\n");                                                     \
  Simd128_Real32_print(temp2);                                          \
  printf("Scalar:\n");                                                   \
  Simd128_Real32_printScalar(temp3);                                    \
  }

print_control(add)
print_control(sub)
print_control(mul)
print_control(div)
print_control(min)
print_control(max)
print_control(and)
print_control(or)
print_control(xor)
print_control(andnot)

#ifdef __SSE3__
print_control(hadd)
print_control(hsub)
print_control(addsub)
#endif

/*int main() {
  simple1.m128f = _mm_load_ps(simple1_temp);
  simple2.m128f = _mm_load_ps(simple2_temp);
  rand1.m128f = _mm_load_ps(rand1_temp);
  rand2.m128f = _mm_load_ps(rand2_temp);
  scalar1.m128f = _mm_load_ss(&scalar1_temp);
  scalar2.m128f = _mm_load_ss(&scalar2_temp);

  print_control_add();
#ifdef __SSE3__
  print_control_hadd();
  print_control_hsub();
  print_control_addsub();
#endif
  print_control_sub();
  print_control_mul();
  print_control_div();
}*/
