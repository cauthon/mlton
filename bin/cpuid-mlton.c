#include <stdio.h>
#include <ctype.h>
#include <unistd.h>
void features();
void mflags();
int main(int argc,char * const argv[]){
#if (defined (__x86_64__))
/* call cpuid function to determine available instructions,
   running the program prints a list of the form
   feature = 1/0, where 1 indicates the feature is present
   and 0 indicates it is not */
inline void
cpuid(unsigned info,unsigned *eax,unsigned *ebx,unsigned *ecx,unsigned *edx){
  asm volatile ("cpuid\n"
                    :"=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx)
                    :"0" (info));
}
  typedef union{
    unsigned int name;
    unsigned char bytes[4];
  } reg;
  //unsigned int eax,ebx,ecx,edx;
  reg eax,ebx,ecx,edx;
  cpuid(1,&eax.name,&ebx.name,&ecx.name,&edx.name);
  //w/lsb=31->msb=0
  //
  /*for cpuid, rax=1
    //in ecx:
    fma=0x1000,//bit 12=fma
    avx=0x10000000,//bit 28=avx
    // if avx supported; cpuid eax=07h,ecx=0h check bit 5 of ebx
    osxsave=0xc000000,//  bit 27=osxsave, operating system ymm support
    xsave=0x4000000,// bit 26=xsave, hardware ymm support
    aes=0x2000000,//bit 25=aes
    sse4_2=0x100000,//bit 20=sse4_2
    sse4_1=0xc0000,//bit 19=sse4_1
    ssse3=0x200,//bit 9=ssse3
    sse3=0x1,//bit 0=sse3
    //in edx:
    sse2=0x4000000,//bit 26=sse2
    sse=0x2000000,//bit 25=sse
    fxsave=0x1000000,//bit 24=fxsave(check before any sse stuff)
    mmx=0x800000;//bit 23=mmx
  unsigned int simd[13]={mmx,fxsave,sse,sse2,sse3,ssse3,sse4_1,sse4_2,
  aes,osxsave,avx,fma};*/
  //flags = mmx,fxsave,sse,sse2,sse3,ssse3,sse4.1,sse4.2,aes,osxsave,avx,fma,avx2
  volatile unsigned char flags[13]={0x80,0x1,0x2,0x4,0x1,0x2,0x8,0x16,0x2,0x8,0x10,0x10,0x20};
  flags[0]&=edx.bytes[2];
  flags[1]&=edx.bytes[3];
  flags[2]&=edx.bytes[3];
  flags[3]&=edx.bytes[3];
  flags[4]&=ecx.bytes[0];
  flags[5]&=ecx.bytes[1];
  flags[6]&=ecx.bytes[2];
  flags[7]&=ecx.bytes[2];
  flags[8]&=ecx.bytes[3];
  flags[9]&=ecx.bytes[3];
  flags[10]&=ecx.bytes[3];
  flags[11]&=ecx.bytes[1];
  cpuid(7,&eax.name,&ebx.name,&ecx.name,&edx.name);
  flags[12] &= ebx.bytes[0];
  unsigned char bool_flags[13]={0};
  int i;
  for (i=0;i<13;i++){
    bool_flags[i] = flags[i]==0?0x0:0x31;
  }
  void features(){
  printf(//"mmx=%c\nfxsave=%c\nsse=%c\nsse2=%c\n"
         "sse3=%c\nssse3=%c\nsse4_1=%c\nsse4_2=%c\n"
         "aes=%c\nosxsave=%c\navx=%c\nfma=%c\navx2=%c\n",
         //bool_flags[0],bool_flags[1],bool_flags[2],bool_flags[3]
         bool_flags[4],bool_flags[5],bool_flags[6],bool_flags[7],bool_flags[8],
         bool_flags[9],bool_flags[10],bool_flags[11],bool_flags[12]);
  }
  void mflags(){
    if (bool_flags[12]){
      printf("-mavx2");
    } else if (bool_flags[10]){
      printf("-mavx");
    } else if (bool_flags[7]){
      printf("-msse4.2");
    } else if (bool_flags[6]){
      printf("-msse4.1");
    } else if (bool_flags[5]){
      printf("-mssse3");
    } else if (bool_flags[4]){
      printf("-msse3");
    } else {
      printf("-msse2");
    }
  }
#else
void features(){}
void flags(){}
#endif
  if (getopt(argc,argv,"m") == 'm'){
    mflags();
  } else {
    features();
  }
  return 0;
}
