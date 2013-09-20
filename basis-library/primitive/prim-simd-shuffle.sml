(*include this in public sig or no?*)
(*(dotimes  (i 4)
    (insert (format "| 0w%d => _prim \"Simd128_Real_shuffle0x%x\": simdReal * simdReal -> simdReal;\n" i i)))*)
(*fun mkShuffleConst(w1:Word8.word,w2:Word8.word,w3:Word8.word,w4:Word8.word):Word8.word =
    orb(w4 << 0w6,orb(w3 << 0w4,orb(w2 << 0w2,w1 << 0w0)))
end*)
signature SIMD_SHUFFLE =
sig 
  type simd
  type shuffleConst
  val primShuffle:Primitive.Word8.word->(simd*simd->simd)
  val mkShuffleConst:shuffleConst->Primitive.Word8.word
end
structure Primitive = 
struct
open Primitive
structure Shuffle32:SIMD_SHUFFLE = 
struct
type simd = Simd128_Real32.simdReal
type simdReal = simd
local
  open Word8
  infix 4 <<?
in
type shuffleConst=Word8.word*Word8.word*Word8.word*Word8.word
fun mkShuffleConst(w1:word,w2:word,w3:word,w4:word):word =
    orb(w4 <<? 0w6,orb(w3 <<? 0w4,orb(w2 <<? 0w2,w1 <<? 0w0)))
end
fun primShuffle(w:Word8.word) =
    case w of
 0w0 => _prim "Simd128_Real32_shuffle0x0": simdReal * simdReal -> simdReal;
| 0w1 => _prim "Simd128_Real32_shuffle0x1": simdReal * simdReal -> simdReal;
| 0w2 => _prim "Simd128_Real32_shuffle0x2": simdReal * simdReal -> simdReal;
| 0w3 => _prim "Simd128_Real32_shuffle0x3": simdReal * simdReal -> simdReal;
| 0w4 => _prim "Simd128_Real32_shuffle0x4": simdReal * simdReal -> simdReal;
| 0w5 => _prim "Simd128_Real32_shuffle0x5": simdReal * simdReal -> simdReal;
| 0w6 => _prim "Simd128_Real32_shuffle0x6": simdReal * simdReal -> simdReal;
| 0w7 => _prim "Simd128_Real32_shuffle0x7": simdReal * simdReal -> simdReal;
| 0w8 => _prim "Simd128_Real32_shuffle0x8": simdReal * simdReal -> simdReal;
| 0w9 => _prim "Simd128_Real32_shuffle0x9": simdReal * simdReal -> simdReal;
| 0w10 => _prim "Simd128_Real32_shuffle0xA": simdReal * simdReal -> simdReal;
| 0w11 => _prim "Simd128_Real32_shuffle0xB": simdReal * simdReal -> simdReal;
| 0w12 => _prim "Simd128_Real32_shuffle0xC": simdReal * simdReal -> simdReal;
| 0w13 => _prim "Simd128_Real32_shuffle0xD": simdReal * simdReal -> simdReal;
| 0w14 => _prim "Simd128_Real32_shuffle0xE": simdReal * simdReal -> simdReal;
| 0w15 => _prim "Simd128_Real32_shuffle0xF": simdReal * simdReal -> simdReal;
| 0w16 => _prim "Simd128_Real32_shuffle0x10": simdReal * simdReal -> simdReal;
| 0w17 => _prim "Simd128_Real32_shuffle0x11": simdReal * simdReal -> simdReal;
| 0w18 => _prim "Simd128_Real32_shuffle0x12": simdReal * simdReal -> simdReal;
| 0w19 => _prim "Simd128_Real32_shuffle0x13": simdReal * simdReal -> simdReal;
| 0w20 => _prim "Simd128_Real32_shuffle0x14": simdReal * simdReal -> simdReal;
| 0w21 => _prim "Simd128_Real32_shuffle0x15": simdReal * simdReal -> simdReal;
| 0w22 => _prim "Simd128_Real32_shuffle0x16": simdReal * simdReal -> simdReal;
| 0w23 => _prim "Simd128_Real32_shuffle0x17": simdReal * simdReal -> simdReal;
| 0w24 => _prim "Simd128_Real32_shuffle0x18": simdReal * simdReal -> simdReal;
| 0w25 => _prim "Simd128_Real32_shuffle0x19": simdReal * simdReal -> simdReal;
| 0w26 => _prim "Simd128_Real32_shuffle0x1A": simdReal * simdReal -> simdReal;
| 0w27 => _prim "Simd128_Real32_shuffle0x1B": simdReal * simdReal -> simdReal;
| 0w28 => _prim "Simd128_Real32_shuffle0x1C": simdReal * simdReal -> simdReal;
| 0w29 => _prim "Simd128_Real32_shuffle0x1D": simdReal * simdReal -> simdReal;
| 0w30 => _prim "Simd128_Real32_shuffle0x1E": simdReal * simdReal -> simdReal;
| 0w31 => _prim "Simd128_Real32_shuffle0x1F": simdReal * simdReal -> simdReal;
| 0w32 => _prim "Simd128_Real32_shuffle0x20": simdReal * simdReal -> simdReal;
| 0w33 => _prim "Simd128_Real32_shuffle0x21": simdReal * simdReal -> simdReal;
| 0w34 => _prim "Simd128_Real32_shuffle0x22": simdReal * simdReal -> simdReal;
| 0w35 => _prim "Simd128_Real32_shuffle0x23": simdReal * simdReal -> simdReal;
| 0w36 => _prim "Simd128_Real32_shuffle0x24": simdReal * simdReal -> simdReal;
| 0w37 => _prim "Simd128_Real32_shuffle0x25": simdReal * simdReal -> simdReal;
| 0w38 => _prim "Simd128_Real32_shuffle0x26": simdReal * simdReal -> simdReal;
| 0w39 => _prim "Simd128_Real32_shuffle0x27": simdReal * simdReal -> simdReal;
| 0w40 => _prim "Simd128_Real32_shuffle0x28": simdReal * simdReal -> simdReal;
| 0w41 => _prim "Simd128_Real32_shuffle0x29": simdReal * simdReal -> simdReal;
| 0w42 => _prim "Simd128_Real32_shuffle0x2A": simdReal * simdReal -> simdReal;
| 0w43 => _prim "Simd128_Real32_shuffle0x2B": simdReal * simdReal -> simdReal;
| 0w44 => _prim "Simd128_Real32_shuffle0x2C": simdReal * simdReal -> simdReal;
| 0w45 => _prim "Simd128_Real32_shuffle0x2D": simdReal * simdReal -> simdReal;
| 0w46 => _prim "Simd128_Real32_shuffle0x2E": simdReal * simdReal -> simdReal;
| 0w47 => _prim "Simd128_Real32_shuffle0x2F": simdReal * simdReal -> simdReal;
| 0w48 => _prim "Simd128_Real32_shuffle0x30": simdReal * simdReal -> simdReal;
| 0w49 => _prim "Simd128_Real32_shuffle0x31": simdReal * simdReal -> simdReal;
| 0w50 => _prim "Simd128_Real32_shuffle0x32": simdReal * simdReal -> simdReal;
| 0w51 => _prim "Simd128_Real32_shuffle0x33": simdReal * simdReal -> simdReal;
| 0w52 => _prim "Simd128_Real32_shuffle0x34": simdReal * simdReal -> simdReal;
| 0w53 => _prim "Simd128_Real32_shuffle0x35": simdReal * simdReal -> simdReal;
| 0w54 => _prim "Simd128_Real32_shuffle0x36": simdReal * simdReal -> simdReal;
| 0w55 => _prim "Simd128_Real32_shuffle0x37": simdReal * simdReal -> simdReal;
| 0w56 => _prim "Simd128_Real32_shuffle0x38": simdReal * simdReal -> simdReal;
| 0w57 => _prim "Simd128_Real32_shuffle0x39": simdReal * simdReal -> simdReal;
| 0w58 => _prim "Simd128_Real32_shuffle0x3A": simdReal * simdReal -> simdReal;
| 0w59 => _prim "Simd128_Real32_shuffle0x3B": simdReal * simdReal -> simdReal;
| 0w60 => _prim "Simd128_Real32_shuffle0x3C": simdReal * simdReal -> simdReal;
| 0w61 => _prim "Simd128_Real32_shuffle0x3D": simdReal * simdReal -> simdReal;
| 0w62 => _prim "Simd128_Real32_shuffle0x3E": simdReal * simdReal -> simdReal;
| 0w63 => _prim "Simd128_Real32_shuffle0x3F": simdReal * simdReal -> simdReal;
| 0w64 => _prim "Simd128_Real32_shuffle0x40": simdReal * simdReal -> simdReal;
| 0w65 => _prim "Simd128_Real32_shuffle0x41": simdReal * simdReal -> simdReal;
| 0w66 => _prim "Simd128_Real32_shuffle0x42": simdReal * simdReal -> simdReal;
| 0w67 => _prim "Simd128_Real32_shuffle0x43": simdReal * simdReal -> simdReal;
| 0w68 => _prim "Simd128_Real32_shuffle0x44": simdReal * simdReal -> simdReal;
| 0w69 => _prim "Simd128_Real32_shuffle0x45": simdReal * simdReal -> simdReal;
| 0w70 => _prim "Simd128_Real32_shuffle0x46": simdReal * simdReal -> simdReal;
| 0w71 => _prim "Simd128_Real32_shuffle0x47": simdReal * simdReal -> simdReal;
| 0w72 => _prim "Simd128_Real32_shuffle0x48": simdReal * simdReal -> simdReal;
| 0w73 => _prim "Simd128_Real32_shuffle0x49": simdReal * simdReal -> simdReal;
| 0w74 => _prim "Simd128_Real32_shuffle0x4A": simdReal * simdReal -> simdReal;
| 0w75 => _prim "Simd128_Real32_shuffle0x4B": simdReal * simdReal -> simdReal;
| 0w76 => _prim "Simd128_Real32_shuffle0x4C": simdReal * simdReal -> simdReal;
| 0w77 => _prim "Simd128_Real32_shuffle0x4D": simdReal * simdReal -> simdReal;
| 0w78 => _prim "Simd128_Real32_shuffle0x4E": simdReal * simdReal -> simdReal;
| 0w79 => _prim "Simd128_Real32_shuffle0x4F": simdReal * simdReal -> simdReal;
| 0w80 => _prim "Simd128_Real32_shuffle0x50": simdReal * simdReal -> simdReal;
| 0w81 => _prim "Simd128_Real32_shuffle0x51": simdReal * simdReal -> simdReal;
| 0w82 => _prim "Simd128_Real32_shuffle0x52": simdReal * simdReal -> simdReal;
| 0w83 => _prim "Simd128_Real32_shuffle0x53": simdReal * simdReal -> simdReal;
| 0w84 => _prim "Simd128_Real32_shuffle0x54": simdReal * simdReal -> simdReal;
| 0w85 => _prim "Simd128_Real32_shuffle0x55": simdReal * simdReal -> simdReal;
| 0w86 => _prim "Simd128_Real32_shuffle0x56": simdReal * simdReal -> simdReal;
| 0w87 => _prim "Simd128_Real32_shuffle0x57": simdReal * simdReal -> simdReal;
| 0w88 => _prim "Simd128_Real32_shuffle0x58": simdReal * simdReal -> simdReal;
| 0w89 => _prim "Simd128_Real32_shuffle0x59": simdReal * simdReal -> simdReal;
| 0w90 => _prim "Simd128_Real32_shuffle0x5A": simdReal * simdReal -> simdReal;
| 0w91 => _prim "Simd128_Real32_shuffle0x5B": simdReal * simdReal -> simdReal;
| 0w92 => _prim "Simd128_Real32_shuffle0x5C": simdReal * simdReal -> simdReal;
| 0w93 => _prim "Simd128_Real32_shuffle0x5D": simdReal * simdReal -> simdReal;
| 0w94 => _prim "Simd128_Real32_shuffle0x5E": simdReal * simdReal -> simdReal;
| 0w95 => _prim "Simd128_Real32_shuffle0x5F": simdReal * simdReal -> simdReal;
| 0w96 => _prim "Simd128_Real32_shuffle0x60": simdReal * simdReal -> simdReal;
| 0w97 => _prim "Simd128_Real32_shuffle0x61": simdReal * simdReal -> simdReal;
| 0w98 => _prim "Simd128_Real32_shuffle0x62": simdReal * simdReal -> simdReal;
| 0w99 => _prim "Simd128_Real32_shuffle0x63": simdReal * simdReal -> simdReal;
| 0w100 => _prim "Simd128_Real32_shuffle0x64": simdReal * simdReal -> simdReal;
| 0w101 => _prim "Simd128_Real32_shuffle0x65": simdReal * simdReal -> simdReal;
| 0w102 => _prim "Simd128_Real32_shuffle0x66": simdReal * simdReal -> simdReal;
| 0w103 => _prim "Simd128_Real32_shuffle0x67": simdReal * simdReal -> simdReal;
| 0w104 => _prim "Simd128_Real32_shuffle0x68": simdReal * simdReal -> simdReal;
| 0w105 => _prim "Simd128_Real32_shuffle0x69": simdReal * simdReal -> simdReal;
| 0w106 => _prim "Simd128_Real32_shuffle0x6A": simdReal * simdReal -> simdReal;
| 0w107 => _prim "Simd128_Real32_shuffle0x6B": simdReal * simdReal -> simdReal;
| 0w108 => _prim "Simd128_Real32_shuffle0x6C": simdReal * simdReal -> simdReal;
| 0w109 => _prim "Simd128_Real32_shuffle0x6D": simdReal * simdReal -> simdReal;
| 0w110 => _prim "Simd128_Real32_shuffle0x6E": simdReal * simdReal -> simdReal;
| 0w111 => _prim "Simd128_Real32_shuffle0x6F": simdReal * simdReal -> simdReal;
| 0w112 => _prim "Simd128_Real32_shuffle0x70": simdReal * simdReal -> simdReal;
| 0w113 => _prim "Simd128_Real32_shuffle0x71": simdReal * simdReal -> simdReal;
| 0w114 => _prim "Simd128_Real32_shuffle0x72": simdReal * simdReal -> simdReal;
| 0w115 => _prim "Simd128_Real32_shuffle0x73": simdReal * simdReal -> simdReal;
| 0w116 => _prim "Simd128_Real32_shuffle0x74": simdReal * simdReal -> simdReal;
| 0w117 => _prim "Simd128_Real32_shuffle0x75": simdReal * simdReal -> simdReal;
| 0w118 => _prim "Simd128_Real32_shuffle0x76": simdReal * simdReal -> simdReal;
| 0w119 => _prim "Simd128_Real32_shuffle0x77": simdReal * simdReal -> simdReal;
| 0w120 => _prim "Simd128_Real32_shuffle0x78": simdReal * simdReal -> simdReal;
| 0w121 => _prim "Simd128_Real32_shuffle0x79": simdReal * simdReal -> simdReal;
| 0w122 => _prim "Simd128_Real32_shuffle0x7A": simdReal * simdReal -> simdReal;
| 0w123 => _prim "Simd128_Real32_shuffle0x7B": simdReal * simdReal -> simdReal;
| 0w124 => _prim "Simd128_Real32_shuffle0x7C": simdReal * simdReal -> simdReal;
| 0w125 => _prim "Simd128_Real32_shuffle0x7D": simdReal * simdReal -> simdReal;
| 0w126 => _prim "Simd128_Real32_shuffle0x7E": simdReal * simdReal -> simdReal;
| 0w127 => _prim "Simd128_Real32_shuffle0x7F": simdReal * simdReal -> simdReal;
| 0w128 => _prim "Simd128_Real32_shuffle0x80": simdReal * simdReal -> simdReal;
| 0w129 => _prim "Simd128_Real32_shuffle0x81": simdReal * simdReal -> simdReal;
| 0w130 => _prim "Simd128_Real32_shuffle0x82": simdReal * simdReal -> simdReal;
| 0w131 => _prim "Simd128_Real32_shuffle0x83": simdReal * simdReal -> simdReal;
| 0w132 => _prim "Simd128_Real32_shuffle0x84": simdReal * simdReal -> simdReal;
| 0w133 => _prim "Simd128_Real32_shuffle0x85": simdReal * simdReal -> simdReal;
| 0w134 => _prim "Simd128_Real32_shuffle0x86": simdReal * simdReal -> simdReal;
| 0w135 => _prim "Simd128_Real32_shuffle0x87": simdReal * simdReal -> simdReal;
| 0w136 => _prim "Simd128_Real32_shuffle0x88": simdReal * simdReal -> simdReal;
| 0w137 => _prim "Simd128_Real32_shuffle0x89": simdReal * simdReal -> simdReal;
| 0w138 => _prim "Simd128_Real32_shuffle0x8A": simdReal * simdReal -> simdReal;
| 0w139 => _prim "Simd128_Real32_shuffle0x8B": simdReal * simdReal -> simdReal;
| 0w140 => _prim "Simd128_Real32_shuffle0x8C": simdReal * simdReal -> simdReal;
| 0w141 => _prim "Simd128_Real32_shuffle0x8D": simdReal * simdReal -> simdReal;
| 0w142 => _prim "Simd128_Real32_shuffle0x8E": simdReal * simdReal -> simdReal;
| 0w143 => _prim "Simd128_Real32_shuffle0x8F": simdReal * simdReal -> simdReal;
| 0w144 => _prim "Simd128_Real32_shuffle0x90": simdReal * simdReal -> simdReal;
| 0w145 => _prim "Simd128_Real32_shuffle0x91": simdReal * simdReal -> simdReal;
| 0w146 => _prim "Simd128_Real32_shuffle0x92": simdReal * simdReal -> simdReal;
| 0w147 => _prim "Simd128_Real32_shuffle0x93": simdReal * simdReal -> simdReal;
| 0w148 => _prim "Simd128_Real32_shuffle0x94": simdReal * simdReal -> simdReal;
| 0w149 => _prim "Simd128_Real32_shuffle0x95": simdReal * simdReal -> simdReal;
| 0w150 => _prim "Simd128_Real32_shuffle0x96": simdReal * simdReal -> simdReal;
| 0w151 => _prim "Simd128_Real32_shuffle0x97": simdReal * simdReal -> simdReal;
| 0w152 => _prim "Simd128_Real32_shuffle0x98": simdReal * simdReal -> simdReal;
| 0w153 => _prim "Simd128_Real32_shuffle0x99": simdReal * simdReal -> simdReal;
| 0w154 => _prim "Simd128_Real32_shuffle0x9A": simdReal * simdReal -> simdReal;
| 0w155 => _prim "Simd128_Real32_shuffle0x9B": simdReal * simdReal -> simdReal;
| 0w156 => _prim "Simd128_Real32_shuffle0x9C": simdReal * simdReal -> simdReal;
| 0w157 => _prim "Simd128_Real32_shuffle0x9D": simdReal * simdReal -> simdReal;
| 0w158 => _prim "Simd128_Real32_shuffle0x9E": simdReal * simdReal -> simdReal;
| 0w159 => _prim "Simd128_Real32_shuffle0x9F": simdReal * simdReal -> simdReal;
| 0w160 => _prim "Simd128_Real32_shuffle0xA0": simdReal * simdReal -> simdReal;
| 0w161 => _prim "Simd128_Real32_shuffle0xA1": simdReal * simdReal -> simdReal;
| 0w162 => _prim "Simd128_Real32_shuffle0xA2": simdReal * simdReal -> simdReal;
| 0w163 => _prim "Simd128_Real32_shuffle0xA3": simdReal * simdReal -> simdReal;
| 0w164 => _prim "Simd128_Real32_shuffle0xA4": simdReal * simdReal -> simdReal;
| 0w165 => _prim "Simd128_Real32_shuffle0xA5": simdReal * simdReal -> simdReal;
| 0w166 => _prim "Simd128_Real32_shuffle0xA6": simdReal * simdReal -> simdReal;
| 0w167 => _prim "Simd128_Real32_shuffle0xA7": simdReal * simdReal -> simdReal;
| 0w168 => _prim "Simd128_Real32_shuffle0xA8": simdReal * simdReal -> simdReal;
| 0w169 => _prim "Simd128_Real32_shuffle0xA9": simdReal * simdReal -> simdReal;
| 0w170 => _prim "Simd128_Real32_shuffle0xAA": simdReal * simdReal -> simdReal;
| 0w171 => _prim "Simd128_Real32_shuffle0xAB": simdReal * simdReal -> simdReal;
| 0w172 => _prim "Simd128_Real32_shuffle0xAC": simdReal * simdReal -> simdReal;
| 0w173 => _prim "Simd128_Real32_shuffle0xAD": simdReal * simdReal -> simdReal;
| 0w174 => _prim "Simd128_Real32_shuffle0xAE": simdReal * simdReal -> simdReal;
| 0w175 => _prim "Simd128_Real32_shuffle0xAF": simdReal * simdReal -> simdReal;
| 0w176 => _prim "Simd128_Real32_shuffle0xB0": simdReal * simdReal -> simdReal;
| 0w177 => _prim "Simd128_Real32_shuffle0xB1": simdReal * simdReal -> simdReal;
| 0w178 => _prim "Simd128_Real32_shuffle0xB2": simdReal * simdReal -> simdReal;
| 0w179 => _prim "Simd128_Real32_shuffle0xB3": simdReal * simdReal -> simdReal;
| 0w180 => _prim "Simd128_Real32_shuffle0xB4": simdReal * simdReal -> simdReal;
| 0w181 => _prim "Simd128_Real32_shuffle0xB5": simdReal * simdReal -> simdReal;
| 0w182 => _prim "Simd128_Real32_shuffle0xB6": simdReal * simdReal -> simdReal;
| 0w183 => _prim "Simd128_Real32_shuffle0xB7": simdReal * simdReal -> simdReal;
| 0w184 => _prim "Simd128_Real32_shuffle0xB8": simdReal * simdReal -> simdReal;
| 0w185 => _prim "Simd128_Real32_shuffle0xB9": simdReal * simdReal -> simdReal;
| 0w186 => _prim "Simd128_Real32_shuffle0xBA": simdReal * simdReal -> simdReal;
| 0w187 => _prim "Simd128_Real32_shuffle0xBB": simdReal * simdReal -> simdReal;
| 0w188 => _prim "Simd128_Real32_shuffle0xBC": simdReal * simdReal -> simdReal;
| 0w189 => _prim "Simd128_Real32_shuffle0xBD": simdReal * simdReal -> simdReal;
| 0w190 => _prim "Simd128_Real32_shuffle0xBE": simdReal * simdReal -> simdReal;
| 0w191 => _prim "Simd128_Real32_shuffle0xBF": simdReal * simdReal -> simdReal;
| 0w192 => _prim "Simd128_Real32_shuffle0xC0": simdReal * simdReal -> simdReal;
| 0w193 => _prim "Simd128_Real32_shuffle0xC1": simdReal * simdReal -> simdReal;
| 0w194 => _prim "Simd128_Real32_shuffle0xC2": simdReal * simdReal -> simdReal;
| 0w195 => _prim "Simd128_Real32_shuffle0xC3": simdReal * simdReal -> simdReal;
| 0w196 => _prim "Simd128_Real32_shuffle0xC4": simdReal * simdReal -> simdReal;
| 0w197 => _prim "Simd128_Real32_shuffle0xC5": simdReal * simdReal -> simdReal;
| 0w198 => _prim "Simd128_Real32_shuffle0xC6": simdReal * simdReal -> simdReal;
| 0w199 => _prim "Simd128_Real32_shuffle0xC7": simdReal * simdReal -> simdReal;
| 0w200 => _prim "Simd128_Real32_shuffle0xC8": simdReal * simdReal -> simdReal;
| 0w201 => _prim "Simd128_Real32_shuffle0xC9": simdReal * simdReal -> simdReal;
| 0w202 => _prim "Simd128_Real32_shuffle0xCA": simdReal * simdReal -> simdReal;
| 0w203 => _prim "Simd128_Real32_shuffle0xCB": simdReal * simdReal -> simdReal;
| 0w204 => _prim "Simd128_Real32_shuffle0xCC": simdReal * simdReal -> simdReal;
| 0w205 => _prim "Simd128_Real32_shuffle0xCD": simdReal * simdReal -> simdReal;
| 0w206 => _prim "Simd128_Real32_shuffle0xCE": simdReal * simdReal -> simdReal;
| 0w207 => _prim "Simd128_Real32_shuffle0xCF": simdReal * simdReal -> simdReal;
| 0w208 => _prim "Simd128_Real32_shuffle0xD0": simdReal * simdReal -> simdReal;
| 0w209 => _prim "Simd128_Real32_shuffle0xD1": simdReal * simdReal -> simdReal;
| 0w210 => _prim "Simd128_Real32_shuffle0xD2": simdReal * simdReal -> simdReal;
| 0w211 => _prim "Simd128_Real32_shuffle0xD3": simdReal * simdReal -> simdReal;
| 0w212 => _prim "Simd128_Real32_shuffle0xD4": simdReal * simdReal -> simdReal;
| 0w213 => _prim "Simd128_Real32_shuffle0xD5": simdReal * simdReal -> simdReal;
| 0w214 => _prim "Simd128_Real32_shuffle0xD6": simdReal * simdReal -> simdReal;
| 0w215 => _prim "Simd128_Real32_shuffle0xD7": simdReal * simdReal -> simdReal;
| 0w216 => _prim "Simd128_Real32_shuffle0xD8": simdReal * simdReal -> simdReal;
| 0w217 => _prim "Simd128_Real32_shuffle0xD9": simdReal * simdReal -> simdReal;
| 0w218 => _prim "Simd128_Real32_shuffle0xDA": simdReal * simdReal -> simdReal;
| 0w219 => _prim "Simd128_Real32_shuffle0xDB": simdReal * simdReal -> simdReal;
| 0w220 => _prim "Simd128_Real32_shuffle0xDC": simdReal * simdReal -> simdReal;
| 0w221 => _prim "Simd128_Real32_shuffle0xDD": simdReal * simdReal -> simdReal;
| 0w222 => _prim "Simd128_Real32_shuffle0xDE": simdReal * simdReal -> simdReal;
| 0w223 => _prim "Simd128_Real32_shuffle0xDF": simdReal * simdReal -> simdReal;
| 0w224 => _prim "Simd128_Real32_shuffle0xE0": simdReal * simdReal -> simdReal;
| 0w225 => _prim "Simd128_Real32_shuffle0xE1": simdReal * simdReal -> simdReal;
| 0w226 => _prim "Simd128_Real32_shuffle0xE2": simdReal * simdReal -> simdReal;
| 0w227 => _prim "Simd128_Real32_shuffle0xE3": simdReal * simdReal -> simdReal;
| 0w228 => _prim "Simd128_Real32_shuffle0xE4": simdReal * simdReal -> simdReal;
| 0w229 => _prim "Simd128_Real32_shuffle0xE5": simdReal * simdReal -> simdReal;
| 0w230 => _prim "Simd128_Real32_shuffle0xE6": simdReal * simdReal -> simdReal;
| 0w231 => _prim "Simd128_Real32_shuffle0xE7": simdReal * simdReal -> simdReal;
| 0w232 => _prim "Simd128_Real32_shuffle0xE8": simdReal * simdReal -> simdReal;
| 0w233 => _prim "Simd128_Real32_shuffle0xE9": simdReal * simdReal -> simdReal;
| 0w234 => _prim "Simd128_Real32_shuffle0xEA": simdReal * simdReal -> simdReal;
| 0w235 => _prim "Simd128_Real32_shuffle0xEB": simdReal * simdReal -> simdReal;
| 0w236 => _prim "Simd128_Real32_shuffle0xEC": simdReal * simdReal -> simdReal;
| 0w237 => _prim "Simd128_Real32_shuffle0xED": simdReal * simdReal -> simdReal;
| 0w238 => _prim "Simd128_Real32_shuffle0xEE": simdReal * simdReal -> simdReal;
| 0w239 => _prim "Simd128_Real32_shuffle0xEF": simdReal * simdReal -> simdReal;
| 0w240 => _prim "Simd128_Real32_shuffle0xF0": simdReal * simdReal -> simdReal;
| 0w241 => _prim "Simd128_Real32_shuffle0xF1": simdReal * simdReal -> simdReal;
| 0w242 => _prim "Simd128_Real32_shuffle0xF2": simdReal * simdReal -> simdReal;
| 0w243 => _prim "Simd128_Real32_shuffle0xF3": simdReal * simdReal -> simdReal;
| 0w244 => _prim "Simd128_Real32_shuffle0xF4": simdReal * simdReal -> simdReal;
| 0w245 => _prim "Simd128_Real32_shuffle0xF5": simdReal * simdReal -> simdReal;
| 0w246 => _prim "Simd128_Real32_shuffle0xF6": simdReal * simdReal -> simdReal;
| 0w247 => _prim "Simd128_Real32_shuffle0xF7": simdReal * simdReal -> simdReal;
| 0w248 => _prim "Simd128_Real32_shuffle0xF8": simdReal * simdReal -> simdReal;
| 0w249 => _prim "Simd128_Real32_shuffle0xF9": simdReal * simdReal -> simdReal;
| 0w250 => _prim "Simd128_Real32_shuffle0xFA": simdReal * simdReal -> simdReal;
| 0w251 => _prim "Simd128_Real32_shuffle0xFB": simdReal * simdReal -> simdReal;
| 0w252 => _prim "Simd128_Real32_shuffle0xFC": simdReal * simdReal -> simdReal;
| 0w253 => _prim "Simd128_Real32_shuffle0xFD": simdReal * simdReal -> simdReal;
| 0w254 => _prim "Simd128_Real32_shuffle0xFE": simdReal * simdReal -> simdReal;
| 0w255 => _prim "Simd128_Real32_shuffle0xFF": simdReal * simdReal -> simdReal;
end
structure Shuffle32_avx:SIMD_SHUFFLE = 
struct
type simd = Simd256_Real32.simdReal
type simdReal = simd
local
  open Word8
  infix 4 <<?
in
type shuffleConst=Word8.word*Word8.word*Word8.word*Word8.word
fun mkShuffleConst(w1:word,w2:word,w3:word,w4:word):word =
    orb(w1 <<? 0w6,orb(w2 <<? 0w4,orb(w3 <<? 0w2,w4 <<? 0w0)))
end
fun primShuffle(w:Word8.word) =
    fn (x,y) => x
end
structure Shuffle64:SIMD_SHUFFLE = 
struct
type simd = Simd128_Real64.simdReal
type simdReal = simd
local
  open Word8
  infix 4 <<?
in
type shuffleConst=Word8.word*Word8.word
fun mkShuffleConst(w1:Word8.word,w2:Word8.word):Word8.word =
    orb(w1 <<? 0w7,w2 <<? 0w6)
end
fun primShuffle(w:Word8.word) =
    case w of
  0w0 => _prim "Simd128_Real64_shuffle0x0": simdReal * simdReal -> simdReal;
| 0w1 => _prim "Simd128_Real64_shuffle0x1": simdReal * simdReal -> simdReal;
| 0w2 => _prim "Simd128_Real64_shuffle0x2": simdReal * simdReal -> simdReal;
| 0w3 => _prim "Simd128_Real64_shuffle0x3": simdReal * simdReal -> simdReal;
| _ =>  _prim "Simd128_Real64_shuffle0x0": simdReal * simdReal -> simdReal;
end 
structure Shuffle64_avx:SIMD_SHUFFLE =
struct
type simd = Simd256_Real64.simdReal
type simdReal = simd
local
  open Word8
  infix 4 <<?
in
type shuffleConst=Word8.word*Word8.word
fun mkShuffleConst(w1:Word8.word,w2:Word8.word):Word8.word =
    orb(w1 <<? 0w7,w2 <<? 0w6)
end
fun primShuffle(w:Word8.word) =
    fn (x,y) => x
end 
end
