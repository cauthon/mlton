signature SSE_TYPES =
sig
  type v2df = Real64.real Array.array
  type v4sf = Real32.real Array.array
(*would like to do this  datatype m128i = v2di | v4si | v8hi | v16qi*)
(*  type v2di
  type v4si
  type v8hi
  type v16qi*)
  type m128i = Word8.word Array.array
(* packed types/values(with x = the appropiate integer)
 * vxdf = double float
 * vxsf = single float
 * vxdi = packed quadword
 * vxsi = packed doubleword
 * vxhi = packed word
 * vxqi = packed byte *)
end
signature SSE_C_TYPES =
sig
  include SSE_TYPES
  type t2df
  type t4sf
(*  datatype simdInt = t2di| t4si | t8hi | t16qi *)
  type simdInt
  val packDouble:t2df->v2df
  val packFloat:t4sf->v4sf
  val packInt:simdInt->m128i
  val unpackDouble:Real64.real Array.array->t2df
  val unpackFloat:Real32.real Array.array->t4sf
  val unpackInt:m128i->simdInt
end
signature SSE_C_FLOATS =
sig
  type v2df = Real64.real Array.array
  type v4sf = Real32.real Array.array
  type t2df
  type t4sf
  val packDouble:t2df->v2df
  val packFloat:t4sf->v4sf
  val unpackDouble:Real64.real Array.array->t2df
  val unpackFloat:Real32.real Array.array->t4sf
end
signature SSE_C_INTS =
sig
 (*datatype m128i = v2di | v4si | v8hi | v16qi
  datatype simdInt = t2di| t4si | t8hi | t16qi*)
  type m128i
  type simdInt
  val packInt:simdInt->m128i
  val unpackInt:m128i->simdInt
end
structure SSE_Types:SSE_TYPES =
struct 
  type v2df = Real64.real Array.array
  type v4sf = Real32.real Array.array
(*  local
    type v2di = Word64.word Array.array
    type v4si = Word32.word Array.array
    type v8hi = Word16.word Array.array
    type v16qi = Word8.word Array.array
  in
  datatype m128i = v2di | v4si | v8hi | v16qi *)
  type m128i = Word8.word Array.array
end
structure SSE_Ctype_array:SSE_C_TYPES =
struct
  open SSE_Types
  type t2df = v2df
  type t4sf = v4sf
  type simdInt = m128i
  local
    val id = fn x => x
  in
  val packDouble=id
  val packFloat=id
  val packInt=id
  val unpackDouble=id
  val unpackFloat=id
  val unpackInt=id
  end
end
structure SSE_Ctype_vector:SSE_C_TYPES =
struct
  open SSE_Types
  type t2df = Real64.real Vector.vector
  type t4sf = Real32.real Vector.vector
  type simdInt = Word8.word Vector.vector
  fun packDouble a = let 
    val z = Unsafe.Array.create (2,0.0:Real64.real)
  in (Array.copyVec{src=a,dst=z,di=0};z) end
  fun packFloat a = let 
    val z = Unsafe.Array.create (4,0.0:Real32.real)
  in (Array.copyVec{src=a,dst=z,di=0};z) end
  fun packInt a = let 
    val z = Unsafe.Array.create (16,0w0:Word8.word)
  in (Array.copyVec{src=a,dst=z,di=0};z) end
  fun unpackDouble x = Array.vector x
  fun unpackFloat x = Array.vector x
  fun unpackInt x = Array.vector x
end
(*
structure SSE_Ctype_array:SSE_C_TYPES =
struct
  open SSE_Types
  type t2df = v2df
  type t4sf = v4sf
  local
    type t2di = Word64.word Array.array
    type t4si = Word32.word Array.array
    type t8hi = Word16.word Array.array
    type t16qi = Word8.word Array.array
  in
  datatype simdInt = t2di | t4si | t8hi | t16qi
  end
  local
    val id = fn x => x
  in
  val packDouble=id
  val packFloat=id
  val packInt=id
  val unpack2f=id
  val unpack4f=id
  val unpackInt=id
  end
end*)
(*signature SSE_C_WORDS =
sig
  type v2di = Word64.word Array.array
  type v4si = Word32.word Array.array
  type v8hi = Word16.word Array.array
  type v16qi = Word8.word Array.array
  type t2di
  type t4si
  type t8hi
  type t16qi
  val pack2i:t2di->v2di
  val pack4i:t4si->v4si
  val pack8i:t8hi->v8hi
  val pack16i:t16qi->v16qi
  val unpack2i:Word64.word Array.array->t2di
  val unpack4i:Word32.word Array.array->t4si
  val unpack8i:Word16.word Array.array->t8hi
  val unpack16i:Word8.word Array.array->t16qi
end*)
