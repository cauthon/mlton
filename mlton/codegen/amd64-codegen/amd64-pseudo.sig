(* Copyright (C) 2009 Matthew Fluet.
 * Copyright (C) 1999-2008 Henry Cejtin, Matthew Fluet, Suresh
 *    Jagannathan, and Stephen Weeks.
 * Copyright (C) 1997-2000 NEC Research Institute.
 *
 * MLton is released under a BSD-style license.
 * See the file MLton-LICENSE for details.
 *)
(*TUCKER: Not sure what this is for, seems like its mostly just a copy
 *of amd64.sig*)
signature AMD64_PSEUDO =
  sig
    structure CFunction: C_FUNCTION
    structure CType: C_TYPE
    structure Label: ID
    structure RepType: REP_TYPE
    structure Runtime: RUNTIME
    structure WordSize: WORD_SIZE
    structure WordX: WORD_X
    sharing CFunction = RepType.CFunction
    sharing CType = RepType.CType
    sharing WordSize = CType.WordSize = WordX.WordSize

    val tracer : string -> ('a -> 'b) -> 
                 (('a -> 'b) * (unit -> unit))
    val tracerTop : string -> ('a -> 'b) -> 
                    (('a -> 'b) * (unit -> unit))

    structure Size :
      sig
        datatype class = INT | FLT | VEC
        datatype t 
          = BYTE | WORD | LONG  | QUAD
          | SNGL | DBLE | VXMM  | VYMM
        val fromBytes : int -> t
        val toBytes : t -> int
        val fromCType : CType.t -> t vector
        val class : t -> class
        val eq : t * t -> bool
        val lt : t * t -> bool
        val toString : t -> string
      end

    structure Immediate :
      sig
        type t

        val word : WordX.t -> t
        val int' : int * WordSize.t -> t
        val int : int -> t
        val zero : t
        val label : Label.t -> t
        val labelPlusWord : Label.t * WordX.t -> t
        val labelPlusInt : Label.t * int -> t
      end

    structure Scale :
      sig
        datatype t = One | Two | Four | Eight | Sixteen | ThirtyTwo
        val fromBytes : int -> t
        val fromCType : CType.t -> t
      end

    structure MemLoc :
      sig
        structure Class :
          sig
            type t
            val new : {name: string} -> t
            val Temp : t
            val StaticTemp : t
            val CArg : t
            val CStack : t
            val Code : t

            val eq : t * t -> bool
          end

        type t
        val layout : t -> Layout.t

        val imm : {base: Immediate.t,
                   index: Immediate.t,
                   scale: Scale.t,
                   size: Size.t,
                   class: Class.t} -> t
        val basic : {base: Immediate.t,
                     index: t,
                     scale: Scale.t,
                     size: Size.t,
                     class: Class.t} -> t
        val simple : {base: t,
                      index: Immediate.t,
                      scale: Scale.t,
                      size: Size.t,
                      class: Class.t} -> t
        val complex : {base: t,
                       index: t,
                       scale: Scale.t,
                       size: Size.t,
                       class: Class.t} -> t
        val shift : {origin: t,
                     disp: Immediate.t,
                     scale: Scale.t,
                     size: Size.t} -> t

        val class : t -> Class.t
        val compare : t * t -> order
        (*
         * Static memory locations
         *)
        val makeContents : {base: Immediate.t,
                            size: Size.t,
                            class: Class.t} -> t
      end

    structure ClassSet : SET
    sharing type ClassSet.Element.t = MemLoc.Class.t
    structure MemLocSet : SET
    sharing type MemLocSet.Element.t = MemLoc.t

    structure Operand : 
      sig
        type t

        val layout : t -> Layout.t
        val toString : t -> string

        val immediate : Immediate.t -> t
        val immediate_word : WordX.t -> t
        val immediate_int' : int * WordSize.t -> t
        val immediate_int : int -> t
        val immediate_zero : t
        val immediate_label : Label.t -> t
        val deImmediate : t -> Immediate.t option
        val label : Label.t -> t
        val deLabel : t -> Label.t option
        val memloc : MemLoc.t -> t
        val memloc_label: Label.t -> t
        val deMemloc : t -> MemLoc.t option

        val size : t -> Size.t option
        val eq : t * t -> bool
        val mayAlias : t * t -> bool
      end

    structure Instruction : 
      sig
        (* Integer binary arithmetic(w/o mult & div)/logic instructions. *)
        datatype binal
          = ADD (* signed/unsigned addition; p. 58 *)
          | ADC (* signed/unsigned addition with carry; p. 56 *)
          | SUB (* signed/unsigned subtraction; p. 234 *)
          | SBB (* signed/unsigned subtraction with borrow; p. 216 *)
          | AND (* logical and; p. 60 *)
          | OR  (* logical or; p. 176 *)
          | XOR (* logical xor; p. 243 *)
        (* Integer multiplication and division. *)
        datatype md
          = IMUL (* signed multiplication (one operand form); p. 114 *)
          | MUL  (* unsigned multiplication; p. 170 *)
          | IDIV (* signed division; p. 112 *)
          | DIV  (* unsigned division; p. 108 *)
          | IMOD (* signed modulus; *)
          | MOD  (* unsigned modulus; *)
        (* Integer unary arithmetic/logic instructions. *)
        datatype unal
          = INC (* increment by 1; p. 117 *)
          | DEC (* decrement by 1; p. 106 *)
          | NEG (* two's complement negation; p. 172 *)
          | NOT (* one's complement negation; p. 175 *)
        (* Integer shift/rotate arithmetic/logic instructions. *)
        datatype sral
          = SAL (* shift arithmetic left; p. 211 *)
          | SHL (* shift logical left; p. 211 *)
          | SAR (* shift arithmetic right; p. 214 *)
          | SHR (* shift logical right; p. 214 *)
          | ROL (* rotate left; p. 206 *)
          | RCL (* rotate through carry left; p. 197 *)
          | ROR (* rotate right; p. 208 *)
          | RCR (* rotate through carry right; p. 199 *)
        (* Move with extention instructions. *)
        datatype movx
          = MOVSX (* move with sign extention; p. 167 *)
          | MOVZX (* move with zero extention; p. 169 *)
        (* Condition test field; p. 340 *)
        datatype condition
          = O   (* overflow *)       | NO  (* not overflow *)
          | B   (* below *)          | NB  (* not below *)
          | AE  (* above or equal *) | NAE (* not above or equal *)
          | C   (* carry *)          | NC  (* not carry *)
          | E   (* equal *)          | NE  (* not equal *)
          | Z   (* zero *)           | NZ  (* not zero *)
          | BE  (* below or equal *) | NBE (* not below or equal *)
          | A   (* above *)          | NA  (* not above *)
          | S   (* sign *)           | NS  (* not sign *)
          | P   (* parity *)         | NP  (* not parity *)
          | PE  (* parity even *)    | PO  (* parity odd *)
          | L   (* less than *)      
          | NL  (* not less than *)
          | LE  (* less than or equal *) 
          | NLE (* not less than or equal *)
          | G   (* greater than *)   
          | NG  (* not greater than *)
          | GE  (* greater than or equal *) 
          | NGE (* not greater than or equal *)
        val condition_negate : condition -> condition
        val condition_reverse : condition -> condition

        (*Floating Point SSE instructions*)
        (* Scalar SSE binary arithmetic instructions. *)
        datatype sse_binas
          = SSE_ADDS (* addition; p. 7,10 *)
          | SSE_SUBS (* subtraction; p. 371,374 *)
          | SSE_MULS (* multiplication; p. 201,204 *)
          | SSE_DIVS (* division; p. 97,100 *)
          | SSE_MAXS (* maximum; p. 128, 130 *)
          | SSE_MINS (* minimum; p. 132, 134 *)
        (* Packed SSE binary arithmetic instructions. *)
        datatype sse_binap
          = SSE_ADDP
          | SSE_SUBP
          | SSE_MULP
          | SSE_DIVP
          | SSE_MAXP
          | SSE_MINP
        (* Scalar SSE unary arithmetic instructions. *)
        datatype sse_unas
          = SSE_SQRTS (* square root; p. 360,362 *)
        (* Packed SSE unary arithmetic instructions. *)
        datatype sse_unap
          = SSE_SQRTP
        (* Packed SSE binary logical instructions 
         *(same for scalar and packed). *)
        datatype sse_binlp
          = SSE_ANDNP (* and-not; p. 17,19 *)
          | SSE_ANDP (* and; p. 21,23 *)
          | SSE_ORP (* or; p. 206,208 *)
          | SSE_XORP (* xor; p. 391,393 *)
        datatype sse3_binap
          = SSE_ADDSUBP (*add odd pairs, subtract even pairs*)
          | SSE_HADDP (*horizontal add*)
          | SSE_HSUBP (*horizontal subtract*)
        (*floating point sse move instructions*)
        datatype sse_movfp
          = SSE_MOVAP
          | SSE_MOVUP
          | SSE_MOVLP
          | SSE_MOVHP
(*          | SSE_MOVS*)
        (* Packed SSE binary arithmetic instructions. (w/o mul/div/horizontal*)
        (*b=byte,w=word,d=doubleword,q=quadword,dq=doublequadword*)
        datatype sse_ibinap
          = SSE_PADD (*add signed or unsignedb,w,d,q*)
          | SSE_PADDS (*add signed integers w/saturation,b,w*)
          | SSE_PADDUS (*add  unsigned integers w/saturation*)
          | SSE_PSUB (*subtract signed or unsigned, b,w,d,q*)
          | SSE_PSUBS (*subtract signed ints w/saturation, b,w*)
          | SSE_PSUBUS (*subtract unsigned ints w/saturation, b,w*)
          | SSE_PMAXS (*max of signed ints, w(sse2), b,d(sse4.1)*)
          | SSE_PMAXU (*max of unsigned ints b(sse2), d,w(sse4.1)*)
          | SSE_PMINS (*min of signed ints w(sse2), b,d(sse4.1)*)
          | SSE_PMINU (*min of unsigned ints b(sse2), d,w (sse4.1)*)
          | SSE_PAVG (*average of packed ints, b,w*)
        datatype sse_imov
          = SSE_MOVDQA (*move aligned double quadword*)
          | SSE_MOVDQU (*move unaligned double quadword*)
        (*SSE4.1*)
          | SSE_PMOVSX (*packed move with sign extend*)
          | SSE_PMOVZX (*packed move with zero extend*)
        datatype sse_pmd (*multiply and divide for packed ints*)
          = SSE_PCMULQDQ (*this is special, it has its own cpuid flag*)
          | SSE_PMULHW (*multiply signed words, store high 16 bits of result*)
          | SSE_PMULHUW (*same as above but unsigned*)
          | SSE_PMULLW (*save low 16 bits of results instead*)
          | SSE_PMADDWD (*multiply words, add adjecent dword results & store*)
          (*sse4.1*)
          | SSE_PMULDQ (*multiply 1st & 3rd doublewords, save quadword results*)
          | SSE_PMULUDQ (*same as above, but unsigned*)
          | SSE_PMULD (*just multiply dwords and store low bits of result*)
        datatype ssse3_ibinap
          = SSE_PHADD (*horozintal add of signed words or doublewords*)
          | SSE_PHADDSW (*horozontal saturated add of signed words*)
          | SSE_PHSUB (*horizontal sub words or doublewords*)
          | SSE_PHSUBSW (*horizonal sub words w/saturation*)
          | SSE_PMULHRSW (*word multiply, but scale results & store high bits*)

        (* Packed SSE unary arithmetic instructions.*)
        (* Packed SSE binary logical instructions *)
        datatype sse_ibinlp
          = SSE_PAND
          | SSE_PANDN
          | SSE_PXOR
          | SSE_POR
          | SSE_PSLL (*logical shift left, w,d,q,dq*)
          | SSE_PSRL (*logical shift right w,d,q,dq*)
          | SSE_PSRA (*arithmetic shift right, w/d*)
(*TODO: AVX Instructions (TUCKER)
 *because there are AVX 128 bit vex incoded int instructions and
 *AVX2 256 bit vex incoded int instructions, we use a seperate prefix for
 *AVX and AVX2 instructions, or maybe just do VEX128 & VEX256?*)
(*lets just do avx 256 bit fp stuff 1st*)
(*        datatype avx_fp_binap
          = AVX_ADDP
          | AVX_MULP
          | AVX_DIVP
          | AVX_SUBP
          | AVX_ADDSUBP
          | AVX_HADDP
          | AVX_HSUBP
          | AVX_MINP
          | AVX_MAXP
        datatype avx_fp_binlp
          = AVX_ANDP
          | AVX_ANDNP
          | AVX_ORP
          | AVX_XORP
        datatype avx_fp_mov
          = MOVAPS
          | MOVAPD
          | MOVUPS
          | MOVUPD
          | MOVDQA
          | MOVDQU
        datatype avx_fp_shuf
          = SHUFP
          | BLENDP*)
        type t
      end

    structure PseudoOp :
      sig
        type t

        val toString : t -> string

        val data : unit -> t
        val text : unit -> t
        val p2align : Immediate.t * Immediate.t option * Immediate.t option -> t
        val byte : Immediate.t list -> t
        val word : Immediate.t list -> t
        val long : Immediate.t list -> t
        val quad : Immediate.t list -> t
      end

    structure Assembly :
      sig
        type t

        val toString : t -> string

        val comment : string -> t
        val isComment : t -> bool
        val pseudoop : PseudoOp.t -> t
        val pseudoop_data : unit -> t
        val pseudoop_text : unit -> t
        val pseudoop_p2align : Immediate.t * Immediate.t option * Immediate.t option -> t
        val pseudoop_byte : Immediate.t list -> t
        val pseudoop_global: Label.t -> t
        val pseudoop_word : Immediate.t list -> t
        val pseudoop_long : Immediate.t list -> t
        val pseudoop_quad : Immediate.t list -> t
        val label : Label.t -> t
        val instruction : Instruction.t -> t
        val instruction_nop : unit -> t
        val instruction_binal : {oper: Instruction.binal,
                                 src: Operand.t,
                                 dst: Operand.t,
                                 size: Size.t} -> t
        val instruction_pmd : {oper: Instruction.md,
                               src: Operand.t,
                               dst: Operand.t,
                               size: Size.t} -> t
        val instruction_imul2 : {src: Operand.t,
                                 dst: Operand.t,
                                 size: Size.t} -> t
        val instruction_unal : {oper: Instruction.unal,
                                dst: Operand.t,
                                size: Size.t} -> t
        val instruction_sral : {oper: Instruction.sral,
                                count: Operand.t,
                                dst: Operand.t,
                                size: Size.t} -> t
        val instruction_cmp : {src1: Operand.t,
                               src2: Operand.t,
                               size: Size.t} -> t
        val instruction_test : {src1: Operand.t,
                                src2: Operand.t,
                                size: Size.t} -> t
        val instruction_setcc : {condition: Instruction.condition,
                                 dst: Operand.t,
                                 size: Size.t} -> t
        val instruction_jmp : {target: Operand.t,
                               absolute: bool} -> t
        val instruction_jcc : {condition: Instruction.condition, 
                               target: Operand.t} -> t
        val instruction_call : {target: Operand.t,
                                absolute: bool} -> t
        val instruction_ret : {src: Operand.t option} -> t
        val instruction_mov : {src: Operand.t,
                               dst: Operand.t,
                               size: Size.t} -> t
        val instruction_cmovcc : {condition: Instruction.condition,
                                  src: Operand.t,
                                  dst: Operand.t,
                                  size: Size.t} -> t
        val instruction_xchg : {src: Operand.t, 
                                dst: Operand.t,
                                size: Size.t} -> t
        val instruction_ppush : {src: Operand.t,
                                 base: Operand.t,
                                 size: Size.t} -> t
        val instruction_ppop : {dst: Operand.t,
                                base: Operand.t,
                                size: Size.t} -> t
        val instruction_movx : {oper: Instruction.movx,
                                src: Operand.t,
                                srcsize: Size.t,
                                dst: Operand.t,
                                dstsize: Size.t} -> t
        val instruction_xvom : {src: Operand.t,
                                srcsize: Size.t,
                                dst: Operand.t,
                                dstsize: Size.t} -> t
        val instruction_lea : {src: Operand.t,
                               dst: Operand.t,
                               size: Size.t} -> t
        val instruction_sse_binas : {oper: Instruction.sse_binas,
                                     src: Operand.t,
                                     dst: Operand.t,
                                     size: Size.t} -> t
        val instruction_sse_unas : {oper: Instruction.sse_unas,
                                    src: Operand.t,
                                    dst: Operand.t,
                                    size: Size.t} -> t
        val instruction_sse_unap : {oper: Instruction.sse_unap,
                                    src: Operand.t,
                                    dst: Operand.t,
                                    size: Size.t} -> t
        val instruction_sse_binlp : {oper: Instruction.sse_binlp,
                                     src: Operand.t,
                                     dst: Operand.t,
                                     size: Size.t} -> t
        val instruction_sse_binap : {oper: Instruction.sse_binap,
                                     src: Operand.t,
                                     dst: Operand.t,
                                     size: Size.t} -> t
        val instruction_sse3_binap : {oper: Instruction.sse3_binap,
                                     src: Operand.t,
                                     dst: Operand.t,
                                     size: Size.t} -> t
        val instruction_sse_ibinap : {oper: Instruction.sse_ibinap,
                                     src: Operand.t,
                                     dst: Operand.t,
                                     size: Size.t} -> t
        val instruction_sse_movs : {src: Operand.t,
                                    dst: Operand.t,
                                    size: Size.t} -> t
        val instruction_sse_movfp : {instr: Instruction.sse_movfp,
                                    src: Operand.t,
                                    dst: Operand.t,
                                    size: Size.t} -> t
        val instruction_sse_imov : {instr: Instruction.sse_imov,
                                    src: Operand.t,
                                    dst: Operand.t,
                                    size: Size.t} -> t
        val instruction_sse_comis : {src1: Operand.t,
                                     src2: Operand.t,
                                     size: Size.t} -> t
        val instruction_sse_ucomis : {src1: Operand.t,
                                      src2: Operand.t,
                                      size: Size.t} -> t
        val instruction_sse_cvtsfp2sfp : {src: Operand.t,
                                          srcsize: Size.t,
                                          dst: Operand.t,
                                          dstsize: Size.t} -> t
        val instruction_sse_cvtsfp2si : {src: Operand.t,
                                         srcsize: Size.t,
                                         dst: Operand.t,
                                         dstsize: Size.t} -> t
        val instruction_sse_cvtsi2sfp : {src: Operand.t,
                                         srcsize: Size.t,
                                         dst: Operand.t,
                                         dstsize: Size.t} -> t
        val instruction_sse_movd : {src: Operand.t,
                                    srcsize: Size.t,
                                    dst: Operand.t,
                                    dstsize: Size.t} -> t
      end

    structure FrameInfo:
       sig
          datatype t = T of {size: int, 
                             frameLayoutsIndex: int}
       end

    structure Entry:
      sig
        type t

        val cont: {label: Label.t,
                   live: MemLocSet.t,
                   frameInfo: FrameInfo.t} -> t
        val creturn: {dsts: (Operand.t * Size.t) vector,
                      frameInfo: FrameInfo.t option,
                      func: RepType.t CFunction.t,
                      label: Label.t} -> t
        val func: {label: Label.t,
                   live: MemLocSet.t} -> t
        val handler: {frameInfo: FrameInfo.t,
                      label: Label.t,
                      live: MemLocSet.t} -> t
        val jump: {label: Label.t} -> t
        val label: t -> Label.t
      end

    structure Transfer :
      sig
        structure Cases :
          sig
            type 'a t

            val word : (WordX.t * 'a) list -> 'a t
          end

        type t

        val goto : {target: Label.t} -> t
        val iff : {condition: Instruction.condition,
                   truee: Label.t,
                   falsee: Label.t} -> t
        val switch : {test: Operand.t,
                      cases: Label.t Cases.t,
                      default: Label.t} -> t
        val tail : {target: Label.t,
                    live: MemLocSet.t} -> t
        val nontail : {target: Label.t, 
                       live: MemLocSet.t,
                       return: Label.t,
                       handler: Label.t option,
                       size: int} -> t
        val return : {live: MemLocSet.t} -> t 
        val raisee : {live: MemLocSet.t} -> t
        val ccall : {args: (Operand.t * Size.t) list,
                     frameInfo: FrameInfo.t option,
                     func: RepType.t CFunction.t,
                     return: Label.t option} -> t
      end

    structure ProfileLabel :
      sig
        type t
      end

    structure Block :
      sig       
        type t'
        val mkBlock': {entry: Entry.t option,
                       statements: Assembly.t list,
                       transfer: Transfer.t option} -> t'
        val mkProfileBlock': {profileLabel: ProfileLabel.t} -> t'
        val printBlock' : t' -> unit

        type t
        val printBlock : t -> unit

        val compress: t' list -> t list
      end

    structure Chunk :
      sig
        datatype t = T of {data: Assembly.t list, blocks: Block.t list}

      end
  end

functor amd64PseudoCheck(structure S : AMD64) : AMD64_PSEUDO = S
