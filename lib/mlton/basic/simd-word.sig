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
  val vadd:t*t->t
  val vadds:t*t->t
  val vaddus:t*t->t
  val vsub:t*t->t
  val vsubs:t*t->t
  val vsubus:t*t->t
  val vmin:t*t->t
  val vmax:t*t->t
  val vpmadd:t*t->t2(*multiply adjecent elements of t and add adjectent
                     *elements of t2 intermediates to get t2 (unsigned)*)
  val vmadds:t*t->t2(*same as vpmadd but with signed*)
  val vmulh:t*t->t (*multiply t*t and take low bytes of t2 results*)
  val vmull:t*t->t (*multiply t*t and take higt bytes of t2 results*)
  val vmulo:t*t->t2 (*multiply odd elements of t,t and return t2 result*)
  val vmule:t*t->t2 (*shift arguments left element_size bytes and do vmulo*)
  val vhadd:t*t->t(*same convention as floating point hadd*)
  val vhsub:t*t->t
  val vabs:t->t
(*bitwise*)
  val vand:t*t->t
  val vnor:t*t->t
  val vor: t*t->t
  val vxor:t*t->t
  val vandn:t*t->t
  val vnot:t->t(*vandn 0xff..ff*t->t*)
(*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
  val vsar:t*t->t
  val vslr:t*t->t
  val vsll:t*t->t
(*we can also logically shift a full 128bit vector left/right*)
(*Comparison*)
  datatype cmp
  val vcmp:v*v*cmp->v
  (*this is all we get for builtin integer comparison*)
  val vcmpeq:t*t->t
  val vcmpgt:t*t->t
(*so i'll need to write these myself
 *vcmpne(!=),vcmpgep(= | >),vcmplt(!(> | =)),vcmple(!>)
 *vcmpngt(!>),vcmpnge(!(= | >)),vcmpnlt(> | =),vcmpnle(>)*)
  val vblend:t*t*t->t(*maybe?*)
end
