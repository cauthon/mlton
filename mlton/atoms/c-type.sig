(* Copyright (C) 2004-2007 Henry Cejtin, Matthew Fluet, Suresh
 *    Jagannathan, and Stephen Weeks.
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)

signature C_TYPE_STRUCTS = 
   sig
      structure RealSize: REAL_SIZE
      structure WordSize: WORD_SIZE
      structure SimdRealSize: SIMD_REAL_SIZE
      structure SimdWordSize: SIMD_WORD_SIZE
   end

signature C_TYPE = 
   sig
      include C_TYPE_STRUCTS

      datatype t =
         CPointer
       | Int8
       | Int16
       | Int32
       | Int64
       | Objptr
       | Real32
       | Real64
       | Word8
       | Word16
       | Word32
       | Word64
       | Simd128_Real32
       | Simd128_Real64
       | Simd128_WordX
       | Simd256_Real32
       | Simd256_Real64
       | Simd256_WordX

      val align: t * Bytes.t -> Bytes.t
      val all: t list
      val bool: t
      val cpointer: t
      val cint: unit -> t
      val csize: unit -> t
      val equals: t * t -> bool
      val objptrHeader: unit -> t
      val memo: (t -> 'a) -> t -> 'a
      (* name: I{8,16,32,64} R{32,64} W{8,16,32,64} *)
      val name: t -> string
      val layout: t -> Layout.t
      val objptr: t
      val real: RealSize.t -> t
      val seqIndex: unit -> t
      val shiftArg: t
      val size: t -> Bytes.t
      val thread: t
      val toString: t -> string
      val word: WordSize.t * {signed: bool} -> t
   end
