(* Copyright (C) 2013 Tucker DiNapoli
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

signature SIMD_WORD = sig
  val vecSize : Int32.int
  val wordSize : Int32.int
  val elements : Int32.int
  type elt 
  type simdWord
(*functions are commented with hardware supported element types,
 *key: b = Word8, w = Word16, d = Word32, q = Word64, dq = `Word128`*)
(*Math*)
(*S & US suffixs are for signed and unsigned saturation, saturation means
 *values don't wraparound, ie in an unsigned byte 255+1->0 w/o saturation
 *but 255+1->255 w/ saturation*)
  val toArray:elt array * simdWord -> unit
(*  val toArrayOffset:elt array * Int32.int * simdWord -> unit*)
  val fromArray:elt array -> simdWord
  val fromArrayOffset:elt array * Int32.int -> simdWord
  val toScalar: simdWord -> elt
  val fromScalar:elt -> simdWord
  val add:simdWord*simdWord->simdWord (* b w d q *)
  val adds:simdWord*simdWord->simdWord (* b w *)
  val addus:simdWord*simdWord->simdWord (* b w *)
  val sub:simdWord*simdWord->simdWord (* b w d q *)
  val subs:simdWord*simdWord->simdWord (* b w *)
  val subus:simdWord*simdWord->simdWord (* b w *)
  val minu:simdWord*simdWord->simdWord (* w, if sse4.1 then + b d *)
  val mins:simdWord*simdWord->simdWord (* b, if sse4.1 then + w d *)
  val maxu:simdWord*simdWord->simdWord (* w, if sse4.1 then + b d *)
  val maxs:simdWord*simdWord->simdWord (* b, if sse4.1 then + w d *)
(*  val pmadd:simdWord*simdWord->simdWord2(*multiply adjecent elements of t and add adjectent
                     *elements of t2 intermediates to get t2 (unsigned)*)
  val madds:simdWord*simdWord->simdWord2(*same as vpmadd but with signed*)*)
  val mulshi:simdWord*simdWord->simdWord (*multiply t*t and take low bytes of t2 results*)
  val muluhi:simdWord*simdWord->simdWord (*multiply t*t and take low bytes of t2 results*)
  val mullo:simdWord*simdWord->simdWord (*multiply t*t and take higt bytes of t2 results*)
(*  val mulo:simdWord*simdWord->simdWord2 (*multiply odd elements of t,t and return t2 result*)
  val mule:simdWord*simdWord->simdWord2 (*shift arguments left element_size bytes and do vmulo*)*)
  (*same convention as floating point hadd/hsub*)
  val hadd:simdWord*simdWord->simdWord (* w d + saturated w *)
  val hsub:simdWord*simdWord->simdWord (* w d + saturated w*)
  val abs:simdWord->simdWord (* b w d *)
(*bitwise*)
  val andb:simdWord*simdWord->simdWord
  (*val norb:simdWord*simdWord->simdWord*)
  val orb: simdWord*simdWord->simdWord
  val xorb:simdWord*simdWord->simdWord
  val andnb:simdWord*simdWord->simdWord
  (*val notb:simdWord->simdWord(*vandn 0xff..ff*simdWord->simdWord*)*)
(*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
  val sar:simdWord*simdWord->simdWord
  val slr:simdWord*simdWord->simdWord
  val sll:simdWord*simdWord->simdWord
  val sari:simdWord*Word8.word->simdWord
  val slri:simdWord*Word8.word->simdWord
  val slli:simdWord*Word8.word->simdWord
(*we can also logically shift a full 128bit vector left/right*)
(*Comparison*)
  (*this is all we get for builtin integer comparison*)
  val cmpeq:simdWord*simdWord->simdWord
  val cmpgt:simdWord*simdWord->simdWord
  val toString: simdWord -> string
  val toStringScalar: simdWord -> string
  val toStringElt: elt -> string
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
  val add:simdWord*simdWord->simdWord (* b w d q *)
  val adds:simdWord*simdWord->simdWord (* b w *)
  val addus:simdWord*simdWord->simdWord (* b w *)
  val sub:simdWord*simdWord->simdWord (* b w d q *)
  val subs:simdWord*simdWord->simdWord (* b w *)
  val subus:simdWord*simdWord->simdWord (* b w *)
  val minu:simdWord*simdWord->simdWord (* w, if sse4.1 then + b d *)
  val min:simdWord*simdWord->simdWord (* b, if sse4.1 then + w d *)
  val maxu:simdWord*simdWord->simdWord (* w, if sse4.1 then + b d *)
  val max:simdWord*simdWord->simdWord (* b, if sse4.1 then + w d *)
(*Its not too hard to translate word instructions to bytes, but
 *I'll leave word only stuff commented out for now*)
(*  val pmadd:simdWord*simdWord->simdWord2(*multiply adjecent elements of t and add adjectent
                     *elements of t2 intermediates to get t2 (unsigned)*)
  val madds:simdWord*simdWord->simdWord2(*same as vpmadd but with signed*)
  val mulh:simdWord*simdWord->simdWord (*multiply t*t and take low bytes of t2 results*)
  val mull:simdWord*simdWord->simdWord (*multiply t*t and take higt bytes of t2 results*)
  val mulo:simdWord*simdWord->simdWord2 (*multiply odd elements of t,t and return t2 result*)
  val mule:simdWord*simdWord->simdWord2 (*shift arguments left element_size bytes and do vmulo*)
  val hadd:simdWord*simdWord->simdWord(*same convention as floating point hadd*)
  val hsub:simdWord*simdWord->simdWord*)
  val abs:simdWord->simdWord
(*bitwise*)
  val andb:simdWord*simdWord->simdWord
  (*val norb:simdWord*simdWord->simdWord*)
  val orb: simdWord*simdWord->simdWord
  val xorb:simdWord*simdWord->simdWord
  val andnb:simdWord*simdWord->simdWord
  (*val notb:simdWord->simdWord(*vandn 0xff..ff*simdWord->simdWord*)*)
(*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
(*  val sar:simdWord*simdWord->simdWord
  val slr:simdWord*simdWord->simdWord
  val sll:simdWord*simdWord->simdWord
  val sari:t*Word8.word->t
  val slri:t*Word8.word->t
  val slli:t*Word8.word->t*)
(*we can also logically shift a full 128bit vector left/right*)
(*Comparison*)
  (*this is all we get for builtin integer comparison*)
  val cmpeq:simdWord*simdWord->simdWord
  val cmpgt:simdWord*simdWord->simdWord
(*so i'll need to write these myself
 *vcmpne(!=),vcmpgep(= | >),vcmplt(!(> | =)),vcmple(!>)
 *vcmpngt(!>),vcmpnge(!(= | >)),vcmpnlt(> | =),vcmpnle(>)*)
(*  val vblend:t*simdWord*simdWord->simdWord(*maybe?*)*)
  val shuffle: simdWord*simdWord->simdWord(*inplace shuffle of arg1 with arg2 as selector*)
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
  val add:simdWord*simdWord->simdWord (* b w d q *)
  val adds:simdWord*simdWord->simdWord (* b w *)
  val addus:simdWord*simdWord->simdWord (* b w *)
  val sub:simdWord*simdWord->simdWord (* b w d q *)
  val subs:simdWord*simdWord->simdWord (* b w *)
  val subus:simdWord*simdWord->simdWord (* b w *)
  val minu:simdWord*simdWord->simdWord (* w, if sse4.1 then + b d *)
  val min:simdWord*simdWord->simdWord (* b, if sse4.1 then + w d *)
  val maxu:simdWord*simdWord->simdWord (* w, if sse4.1 then + b d *)
  val max:simdWord*simdWord->simdWord (* b, if sse4.1 then + w d *)
(*  val pmadd:simdWord*simdWord->simdWord2(*multiply adjecent elements of t and add adjectent
                     *elements of t2 intermediates to get t2 (unsigned)*)
  val madds:simdWord*simdWord->simdWord2(*same as vpmadd but with signed*)*)
  val mulshi:simdWord*simdWord->simdWord (*multiply t*t and take low bytes of t2 results*)
  val muluhi:simdWord*simdWord->simdWord (*multiply t*t and take low bytes of t2 results*)
  val mullo:simdWord*simdWord->simdWord (*multiply t*t and take higt bytes of t2 results*)
(*would need to translate to 32 bits to do these two*)
(*  val mulo:simdWord*simdWord->simdWord2 (*multiply odd elements of t,t and return t2 result*)
  val mule:simdWord*simdWord->simdWord2 (*shift arguments left element_size bytes and do vmulo*)*)
  val hadd:simdWord*simdWord->simdWord(*same convention as floating point hadd*)
  val hsub:simdWord*simdWord->simdWord
  val abs:simdWord->simdWord
(*bitwise*)
  val andb:simdWord*simdWord->simdWord
  (*val norb:simdWord*simdWord->simdWord*)
  val orb: simdWord*simdWord->simdWord
  val xorb:simdWord*simdWord->simdWord
  val andnb:simdWord*simdWord->simdWord
  (*val notb:simdWord->simdWord(*vandn 0xff..ff*simdWord->simdWord*)*)
(*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
  val sar:simdWord*simdWord->simdWord
  val slr:simdWord*simdWord->simdWord
  val sll:simdWord*simdWord->simdWord
  val sari:simdWord*Word8.word->simdWord
  val slri:simdWord*Word8.word->simdWord
  val slli:simdWord*Word8.word->simdWord
(*we can also logically shift a full 128bit vector left/right*)
(*Comparison*)
  (*this is all we get for builtin integer comparison*)
  val cmpeq:simdWord*simdWord->simdWord
  val cmpgt:simdWord*simdWord->simdWord
(*so i'll need to write these myself
 *vcmpne(!=),vcmpgep(= | >),vcmplt(!(> | =)),vcmple(!>)
 *vcmpngt(!>),vcmpnge(!(= | >)),vcmpnlt(> | =),vcmpnle(>)*)
(*  val vblend:t*simdWord*simdWord->simdWord(*maybe?*)
  val shufflehi:simdWord *Int32.int -> simdWord
  val shufflelo:simdWord*Int32.int -> simdWord*)
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
  val add:simdWord*simdWord->simdWord (* b w d q *)
  val sub:simdWord*simdWord->simdWord (* b w d q *)
  val minu:simdWord*simdWord->simdWord (* w, if sse4.1 then + b d *)
  val min:simdWord*simdWord->simdWord (* b, if sse4.1 then + w d *)
  val maxu:simdWord*simdWord->simdWord (* w, if sse4.1 then + b d *)
  val max:simdWord*simdWord->simdWord (* b, if sse4.1 then + w d *)
(*  val mulo:simdWord*simdWord->simdWord2 (*multiply odd elements of t,t and return t2 result*)
  val mule:simdWord*simdWord->simdWord2 (*shift arguments left element_size bytes and do vmulo*)*)
(*hadd/hsub are w and d*)
  val hadd:simdWord*simdWord->simdWord(*same convention as floating point hadd*)
  val hsub:simdWord*simdWord->simdWord
  val abs:simdWord->simdWord
(*bitwise*)
  val andb:simdWord*simdWord->simdWord
  (*val norb:simdWord*simdWord->simdWord*)
  val orb: simdWord*simdWord->simdWord
  val xorb:simdWord*simdWord->simdWord
  val andnb:simdWord*simdWord->simdWord
  (*val notb:simdWord->simdWord(*vandn 0xff..ff*simdWord->simdWord*)*)
(*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
  val sar:simdWord*simdWord->simdWord (* w d *)     
  val slr:simdWord*simdWord->simdWord (* w d q dq *)
  val sll:simdWord*simdWord->simdWord (* w d q dq *)
  val sari:t*Word8.word->t
  val slri:t*Word8.word->t
  val slli:t*Word8.word->t
(*we can also logically shift a full 128bit vector left/right*)
(*Comparison*)
  (*this is all we get for builtin integer comparison*)
  val cmpeq:simdWord*simdWord->simdWord
  val cmpgt:simdWord*simdWord->simdWord
(*so i'll need to write these myself
 *vcmpne(!=),vcmpgep(= | >),vcmplt(!(> | =)),vcmple(!>)
 *vcmpngt(!>),vcmpnge(!(= | >)),vcmpnlt(> | =),vcmpnle(>)*)
(*  val shuffle:t*Int32.insimdWord->simdWord*)
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
  val add:simdWord*simdWord->simdWord (* b w d q *)
  val sub:simdWord*simdWord->simdWord (* b w d q *)
  val abs:simdWord->simdWord
(*bitwise*)
  val andb:simdWord*simdWord->simdWord
  (*val norb:simdWord*simdWord->simdWord*)
  val orb: simdWord*simdWord->simdWord
  val xorb:simdWord*simdWord->simdWord
  val andnb:simdWord*simdWord->simdWord
  (*val notb:simdWord->simdWord(*vandn 0xff..ff*simdWord->simdWord*)*)
(*sa=arathmatic shift(preserve sign) sl=logical shift(fill w/zeros*)
  val slr:simdWord*simdWord->simdWord
  val sll:simdWord*simdWord->simdWord
  val slri:t*Word8.word->t
  val slli:t*Word8.word->t
(*we can also logically shift a full 128bit vector left/right*)
(*Comparison*)
  (*this is all we get for builtin integer comparison*)
  val cmpeq:simdWord*simdWord->simdWord(*sse4.2*)
  val cmpgt:simdWord*simdWord->simdWord(*sse4.1*)
(*so i'll need to write these myself
 *vcmpne(!=),vcmpgep(= | >),vcmplt(!(> | =)),vcmple(!>)
 *vcmpngt(!>),vcmpnge(!(= | >)),vcmpnlt(> | =),vcmpnle(>)*)
  val shuffle:t*Int32.int -> t (*need to use shufpd, not sure if it'll work*)
end
