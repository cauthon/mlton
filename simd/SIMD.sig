signature SIMD_AVAIL =
sig
  val sse:bool
  val sse2:bool
  val sse3:bool
  val ssse3:bool
  val sse4.1:bool
  val sse4.2:bool
  val avx:bool
  val avx2:bool
end
signature SIMD_REAL_STRUCTS =
sig
  structure SimdSize:SIMD_SIZE
  structure RealSize:REAL_SIZE
  structure SimdAvail:SIMD_AVAIL
end
signature SIMD_REAL =
(*there are enough differences between floating pt simd instructions and 
 *integer ones that they merit different signatures*)
sig
  val vec_size:SimdSize.t (*size of the simd vector, multiple of 128*)
  val real_size:RealSize.t
  type t (* high level type *)
(*math*)
  val VADD:t*t->t(*vex 256 && 128*)
  val VSUB:t*t->t(*vex 256 && 128*)
  val VMUL:t*t->t(*vex 256 && 128*)
  val VDIV:t*t->t(*vex 256 && 128*)
(*  val VRCP:t*t->t(*reciprocal*)*)
  val VSQRT:t*t->t(*vex 256 && 128*)
(*  val VRSQRT:t*t->t(*1/SQRT*)(*vex 256 && 128*)*)
  val VMIN:t*t->t(*vex 256 && 128*)
  val VMAX:t*t->t(*vex 256 && 128*)
(*HADD(HSUB is same but with - instead of +
 *SRC :|X7|X6|X5|X4|X3|X2|X1|X0|
 *DEST:|Y7|Y6|Y5|Y4|Y3|Y2|Y1|Y0| (*or SRC2*)
 *END :|Y6+Y7|Y4+Y5|X6+X7|X4+X5|Y2+Y3|X0+Y1|X2+X3|X0+X1|*)
  val VHADD:t*t->t(*horozontal add*)(*vex 256 && 128*)
  val VHSUB:t*t->t(*horozontal sub*)(*vex 256 && 128*)
  val VADDSUB:t*t->t(*add odd indices, sub even indices*)(*vex 256 && 128*)
(*  val VDOT:v*v->e vdot not acutually super useful *)
(*bitwise, no shifts for floating pt numbers*)
  val VAND:t*t->t(*vex 256 && 128*)
  val VXOR:t*t->t(*vex 256 && 128*)
  val VOR: t*t->t(*vex 256 && 128*)
  val VANDN:t*t->t(*vex 256 && 128*)
  val VNOT:t->t (*0xff..ff and opperand = ! opperand*)
(*Round/Convert*)
  val VROUNDP:v*v*Word8.word->vi(*actual round instruction*)(*vex 256 && 128*)
(*might not make ^ part of the final sig, but it does need to exist internally*)
  (*Need to implement these myself,all are just round with a different imm*)
  (*Also need to make theme take a type argument to determine size*)
  val VROUND:t*t*int->WordX.t(*imm=00*)
  val VCEIL:t*t*int->WordX.t(*imm=01*)
  val VFLOOR:t*t*int->WordX.t(*imm=10*)
  val VTRUNC:t*t*int->WordX.t(*imm=11*)
(*these are a lot more complicated, but we should be able to just have a from
 *and a to function and pick the right instruction based on the types*)
  val VCVT2F:WordX.t->t
  val VCVT2I:t->WordX.t
(*SSE has 8 float comparisons, AVX has 32 so we implement comparisons as
 *a datatype of possible comparisions and a function that takes
 *a value of that type to generate the right instruction*)
  datatype Cmp(*type of comparison predicates*)
  val VCMP:t*t*Cmp->t(*vex 256 && 128*)
(*unpack/shuffle/blend,etc*)
(*if we can have any size vector not sure how best to do shuffle*)
  val VSHUF:t*t*word->t(*vex 256 && 128*)
(*not sure what should go in the public sig, but blend seems useful even
 *for higher level programming*)
  val VBLEND:t*t*t->t(*vex 256 && 128*)
(*whole bunch of mov & pack/unpack etc instructions, don't need those in the
 *public sig, though part of me wants to put them there since I hate private
 *stuff that doesn't need to be private*)
end

signature SIMD_WORD = sig
(*integer instructios are not promoted to 256 bit vectors in avx
 *thus all vector integer types are 128 bit(assuming we ignore mmx)
 *avx still provides 3 opperannd instructions and unaligned access
 *so it is still quite useful. the only note are for insructinons
 *than don't support the avx exensions(I believe there aren't any)*)
  val vec_size:SimdSize.t
  val word_size:WordSize.prim
  type t
  type t2 (* t with element size of word_size*2 *)
(*Math*)
(*S & US suffixs are for signed and unsigned saturation, saturation means
 *values don't wraparound, ie in an unsigned byte 255+1->0 w/o saturation
 *but 255+1->255 w/ saturation*)
  val VADD:t*t->t
  val VADDS:t*t->t
  val VADDUS:t*t->t
  val VSUB:t*t->t
  val VSUBS:t*t->t
  val VSUBUS:t*t->t
  val VMIN:t*t->t
  val VMAX:t*t->t
  val VPMADD:t*t->t2(*multiply adjecent elements of t and add adjectent
                     *elements of t2 intermediates to get t2 (unsigned)*)
  val VMADDS:t*t->t2(*same as VPMADD but with signed*)
  val VMULH:t*t->t (*multiply t*t and take low bytes of t2 results*)
  val VMULL:t*t->t (*multiply t*t and take higt bytes of t2 results*)
  val VMULO:t*t->t2 (*multiply odd elements of t,t and return t2 result*)
  val VMULE:t*t->t2 (*shift arguments left element_size bytes and do VMULO*)
  val VHADD:t*t->t(*same convention as floating point HADD*)
  val VHSUB:t*t->t
  val VABS:t->t
(*Bitwise*)
  val VAND:t*t->t
  val VNOR:t*t->t
  val VOR: t*t->t
  val VXOR:t*t->t
  val VANDN:t*t->t
  val VNOT:t->t(*VANDN 0xff..ff*t->t*)
(*SA=arathmatic shift(preserve sign) SL=logical shift(fill w/zeros*)
  val VSAR:t*t->t
  val VSLR:t*t->t
  val VSLL:t*t->t
(*we can also logically shift a full 128bit vector left/right*)
(*Comparison*)
  datatype cmp
  val VCMP:v*v*cmp->v
  (*this is all we get for builtin integer comparison*)
  val VCMPEQ:t*t->t
  val VCMPGT:t*t->t
(*so I'll need to write these myself
 *VCMPNE(!=),VCMPGEp(= | >),VCMPLT(!(> | =)),VCMPLE(!>)
 *VCMPNGT(!>),VCMPNGE(!(= | >)),VCMPNLT(> | =),VCMPNLE(>)*)
  val VBLEND:t*t*t->t(*maybe?*)
end
