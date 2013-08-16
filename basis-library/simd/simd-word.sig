(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

signature SIMD_WORD = sig
  val vec_size : Int32.int
  val word_size : Int32.int
  type t
  type elt 
  type simdWord
(*functions are commented with hardware supported element types,
 *key: b = Word8, w = Word16, d = Word32, q = Word64, dq = `Word128`*)
(*Math*)
(*S & US suffixs are for signed and unsigned saturation, saturation means
 *values don't wraparound, ie in an unsigned byte 255+1->0 w/o saturation
 *but 255+1->255 w/ saturation*)
  val toArray:elt array * t -> unit
  val fromArray:elt array -> t
  val add:t*t->t (* b w d q *)
  val adds:t*t->t (* b w *)
  val addus:t*t->t (* b w *)
  val sub:t*t->t (* b w d q *)
  val subs:t*t->t (* b w *)
  val subus:t*t->t (* b w *)
  val minu:t*t->t (* w, if sse4.1 then + b d *)
  val min:t*t-> t (* b, if sse4.1 then + w d *)
  val maxu:t*t->t (* w, if sse4.1 then + b d *)
  val max:t*t-> t (* b, if sse4.1 then + w d *)
(*  val pmadd:t*t->t2(*multiply adjecent elements of t and add adjectent
                     *elements of t2 intermediates to get t2 (unsigned)*)
  val madds:t*t->t2(*same as vpmadd but with signed*)*)
  val mulshi:t*t->t (*multiply t*t and take low bytes of t2 results*)
  val muluhi:t*t->t (*multiply t*t and take low bytes of t2 results*)
  val mullo:t*t->t (*multiply t*t and take higt bytes of t2 results*)
(*  val mulo:t*t->t2 (*multiply odd elements of t,t and return t2 result*)
  val mule:t*t->t2 (*shift arguments left element_size bytes and do vmulo*)*)
  val hadd:t*t->t(*same convention as floating point hadd*)
  val hsub:t*t->t
  val abs:t->t
(*bitwise*)
  val andb:t*t->t
  (*val norb:t*t->t*)
  val orb: t*t->t
  val xorb:t*t->t
  val andnb:t*t->t
  (*val notb:t->t(*vandn 0xff..ff*t->t*)*)
(*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
  val sar:t*t->t
  val slr:t*t->t
  val sll:t*t->t
  val sari:t*Word8.word->t
  val slri:t*Word8.word->t
  val slli:t*Word8.word->t
(*we can also logically shift a full 128bit vector left/right*)
(*Comparison*)
  (*this is all we get for builtin integer comparison*)
  val cmpeq:t*t->t
  val cmpgt:t*t->t
(*so i'll need to write these myself
 *vcmpne(!=),vcmpgep(= | >),vcmplt(!(> | =)),vcmple(!>)
 *vcmpngt(!>),vcmpnge(!(= | >)),vcmpnlt(> | =),vcmpnle(>)*)
end
signature SIMD_WORD8 = sig
  val vec_size : Int32.int
  val word_size : Int32.int
  type t
  type elt 
  type simdWord
(*functions are commented with hardware supported element types,
 *key: b = Word8, w = Word16, d = Word32, q = Word64, dq = `Word128`*)
(*Math*)
(*S & US suffixs are for signed and unsigned saturation, saturation means
 *values don't wraparound, ie in an unsigned byte 255+1->0 w/o saturation
 *but 255+1->255 w/ saturation*)
  val add:t*t->t (* b w d q *)
  val adds:t*t->t (* b w *)
  val addus:t*t->t (* b w *)
  val sub:t*t->t (* b w d q *)
  val subs:t*t->t (* b w *)
  val subus:t*t->t (* b w *)
  val minu:t*t->t (* w, if sse4.1 then + b d *)
  val min:t*t-> t (* b, if sse4.1 then + w d *)
  val maxu:t*t->t (* w, if sse4.1 then + b d *)
  val max:t*t-> t (* b, if sse4.1 then + w d *)
(*Its not too hard to translate word instructions to bytes, but
 *I'll leave word only stuff commented out for now*)
(*  val pmadd:t*t->t2(*multiply adjecent elements of t and add adjectent
                     *elements of t2 intermediates to get t2 (unsigned)*)
  val madds:t*t->t2(*same as vpmadd but with signed*)
  val mulh:t*t->t (*multiply t*t and take low bytes of t2 results*)
  val mull:t*t->t (*multiply t*t and take higt bytes of t2 results*)
  val mulo:t*t->t2 (*multiply odd elements of t,t and return t2 result*)
  val mule:t*t->t2 (*shift arguments left element_size bytes and do vmulo*)
  val hadd:t*t->t(*same convention as floating point hadd*)
  val hsub:t*t->t*)
  val abs:t->t
(*bitwise*)
  val andb:t*t->t
  (*val norb:t*t->t*)
  val orb: t*t->t
  val xorb:t*t->t
  val andnb:t*t->t
  (*val notb:t->t(*vandn 0xff..ff*t->t*)*)
(*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
(*  val sar:t*t->t
  val slr:t*t->t
  val sll:t*t->t
  val sari:t*Word8.word->t
  val slri:t*Word8.word->t
  val slli:t*Word8.word->t*)
(*we can also logically shift a full 128bit vector left/right*)
(*Comparison*)
  (*this is all we get for builtin integer comparison*)
  val cmpeq:t*t->t
  val cmpgt:t*t->t
(*so i'll need to write these myself
 *vcmpne(!=),vcmpgep(= | >),vcmplt(!(> | =)),vcmple(!>)
 *vcmpngt(!>),vcmpnge(!(= | >)),vcmpnlt(> | =),vcmpnle(>)*)
(*  val vblend:t*t*t->t(*maybe?*)*)
  val shuffle: t*t->t(*inplace shuffle of arg1 with arg2 as selector*)
end

signature SIMD_WORD16 = sig
  val vec_size : Int32.int
  val word_size : Int32.int
  type t
  type elt 
  type simdWord
(*functions are commented with hardware supported element types,
 *key: b = Word8, w = Word16, d = Word32, q = Word64, dq = `Word128`*)
(*Math*)
(*S & US suffixs are for signed and unsigned saturation, saturation means
 *values don't wraparound, ie in an unsigned byte 255+1->0 w/o saturation
 *but 255+1->255 w/ saturation*)
  val add:t*t->t (* b w d q *)
  val adds:t*t->t (* b w *)
  val addus:t*t->t (* b w *)
  val sub:t*t->t (* b w d q *)
  val subs:t*t->t (* b w *)
  val subus:t*t->t (* b w *)
  val minu:t*t->t (* w, if sse4.1 then + b d *)
  val min:t*t-> t (* b, if sse4.1 then + w d *)
  val maxu:t*t->t (* w, if sse4.1 then + b d *)
  val max:t*t-> t (* b, if sse4.1 then + w d *)
(*  val pmadd:t*t->t2(*multiply adjecent elements of t and add adjectent
                     *elements of t2 intermediates to get t2 (unsigned)*)
  val madds:t*t->t2(*same as vpmadd but with signed*)*)
  val mulshi:t*t->t (*multiply t*t and take low bytes of t2 results*)
  val muluhi:t*t->t (*multiply t*t and take low bytes of t2 results*)
  val mullo:t*t->t (*multiply t*t and take higt bytes of t2 results*)
(*would need to translate to 32 bits to do these two*)
(*  val mulo:t*t->t2 (*multiply odd elements of t,t and return t2 result*)
  val mule:t*t->t2 (*shift arguments left element_size bytes and do vmulo*)*)
  val hadd:t*t->t(*same convention as floating point hadd*)
  val hsub:t*t->t
  val abs:t->t
(*bitwise*)
  val andb:t*t->t
  (*val norb:t*t->t*)
  val orb: t*t->t
  val xorb:t*t->t
  val andnb:t*t->t
  (*val notb:t->t(*vandn 0xff..ff*t->t*)*)
(*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
  val sar:t*t->t
  val slr:t*t->t
  val sll:t*t->t
  val sari:t*Word8.word->t
  val slri:t*Word8.word->t
  val slli:t*Word8.word->t
(*we can also logically shift a full 128bit vector left/right*)
(*Comparison*)
  (*this is all we get for builtin integer comparison*)
  val cmpeq:t*t->t
  val cmpgt:t*t->t
(*so i'll need to write these myself
 *vcmpne(!=),vcmpgep(= | >),vcmplt(!(> | =)),vcmple(!>)
 *vcmpngt(!>),vcmpnge(!(= | >)),vcmpnlt(> | =),vcmpnle(>)*)
  val vblend:t*t*t->t(*maybe?*)
  val shufflehi:t*Int32.int->t
  val shufflelo:t*Int32.int->t
end
signature SIMD_WORD32 = sig
  val vec_size : Int32.int
  val word_size : Int32.int
  type t
  type elt 
  type simdWord
(*functions are commented with hardware supported element types,
 *key: b = Word8, w = Word16, d = Word32, q = Word64, dq = `Word128`*)
(*Math*)
(*S & US suffixs are for signed and unsigned saturation, saturation means
 *values don't wraparound, ie in an unsigned byte 255+1->0 w/o saturation
 *but 255+1->255 w/ saturation*)
  val add:t*t->t (* b w d q *)
  val sub:t*t->t (* b w d q *)
  val minu:t*t->t (* w, if sse4.1 then + b d *)
  val min:t*t-> t (* b, if sse4.1 then + w d *)
  val maxu:t*t->t (* w, if sse4.1 then + b d *)
  val max:t*t-> t (* b, if sse4.1 then + w d *)
(*  val mulo:t*t->t2 (*multiply odd elements of t,t and return t2 result*)
  val mule:t*t->t2 (*shift arguments left element_size bytes and do vmulo*)*)
(*hadd/hsub are w and d*)
  val hadd:t*t->t(*same convention as floating point hadd*)
  val hsub:t*t->t
  val abs:t->t
(*bitwise*)
  val andb:t*t->t
  (*val norb:t*t->t*)
  val orb: t*t->t
  val xorb:t*t->t
  val andnb:t*t->t
  (*val notb:t->t(*vandn 0xff..ff*t->t*)*)
(*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
  val sar:t*t->t (* w d *)     
  val slr:t*t->t (* w d q dq *)
  val sll:t*t->t (* w d q dq *)
  val sari:t*Word8.word->t
  val slri:t*Word8.word->t
  val slli:t*Word8.word->t
(*we can also logically shift a full 128bit vector left/right*)
(*Comparison*)
  (*this is all we get for builtin integer comparison*)
  val cmpeq:t*t->t
  val cmpgt:t*t->t
(*so i'll need to write these myself
 *vcmpne(!=),vcmpgep(= | >),vcmplt(!(> | =)),vcmple(!>)
 *vcmpngt(!>),vcmpnge(!(= | >)),vcmpnlt(> | =),vcmpnle(>)*)
  val shuffle:t*Int32.int->t
end
signature SIMD_WORD64 = sig
  val vec_size : Int32.int
  val word_size : Int32.int
  type t
  type elt
  type simdWord
(*functions are commented with hardware supported element types,
 *key: b = Word8, w = Word16, d = Word32, q = Word64, dq = `Word128`*)
(*Math*)
(*S & US suffixs are for signed and unsigned saturation, saturation means
 *values don't wraparound, ie in an unsigned byte 255+1->0 w/o saturation
 *but 255+1->255 w/ saturation*)
  val add:t*t->t (* b w d q *)
  val sub:t*t->t (* b w d q *)
  val abs:t->t
(*bitwise*)
  val andb:t*t->t
  (*val norb:t*t->t*)
  val orb: t*t->t
  val xorb:t*t->t
  val andnb:t*t->t
  (*val notb:t->t(*vandn 0xff..ff*t->t*)*)
(*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
  val slr:t*t->t
  val sll:t*t->t
  val slri:t*Word8.word->t
  val slli:t*Word8.word->t
(*we can also logically shift a full 128bit vector left/right*)
(*Comparison*)
  (*this is all we get for builtin integer comparison*)
  val cmpeq:t*t->t(*sse4.2*)
  val cmpgt:t*t->t(*sse4.1*)
(*so i'll need to write these myself
 *vcmpne(!=),vcmpgep(= | >),vcmplt(!(> | =)),vcmple(!>)
 *vcmpngt(!>),vcmpnge(!(= | >)),vcmpnlt(> | =),vcmpnle(>)*)
  val shuffle:t*Int32.int -> t (*need to use shufpd, not sure if it'll work*)
end
