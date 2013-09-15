functor mkShuffle(S:sig type simd
                        val shuffle:simd*simd*Word8.word -> simd end):SIMD_SHUFFLE =
struct
local
  open Word8
  infix 4 <<
in
(*include this in public sig or no?*)
fun mkShuffleConst(w1:word,w2:word,w3:word,w4:word):word =
    orb(w1 << 0w6,orb(w2 << 0w4,orb(w3 << 0w2,w4 << 0w0)))
end
fun shuffle(s,s',w) =
    case w of
(*(dotimes  (i 256)
    (insert (format "\n | 0w%d => shuffle(s,s',0w%d)" i i )))*)
        0w0 => shuffle(s,s',0w0)
      | 0w1 => shuffle(s,s',0w1)
      | 0w2 => shuffle(s,s',0w2)
      | 0w3 => shuffle(s,s',0w3)
      | 0w4 => shuffle(s,s',0w4)
      | 0w5 => shuffle(s,s',0w5)
      | 0w6 => shuffle(s,s',0w6)
      | 0w7 => shuffle(s,s',0w7)
      | 0w8 => shuffle(s,s',0w8)
      | 0w9 => shuffle(s,s',0w9)
      | 0w10 => shuffle(s,s',0w10)
      | 0w11 => shuffle(s,s',0w11)
      | 0w12 => shuffle(s,s',0w12)
      | 0w13 => shuffle(s,s',0w13)
      | 0w14 => shuffle(s,s',0w14)
      | 0w15 => shuffle(s,s',0w15)
      | 0w16 => shuffle(s,s',0w16)
      | 0w17 => shuffle(s,s',0w17)
      | 0w18 => shuffle(s,s',0w18)
      | 0w19 => shuffle(s,s',0w19)
      | 0w20 => shuffle(s,s',0w20)
      | 0w21 => shuffle(s,s',0w21)
      | 0w22 => shuffle(s,s',0w22)
      | 0w23 => shuffle(s,s',0w23)
      | 0w24 => shuffle(s,s',0w24)
      | 0w25 => shuffle(s,s',0w25)
      | 0w26 => shuffle(s,s',0w26)
      | 0w27 => shuffle(s,s',0w27)
      | 0w28 => shuffle(s,s',0w28)
      | 0w29 => shuffle(s,s',0w29)
      | 0w30 => shuffle(s,s',0w30)
      | 0w31 => shuffle(s,s',0w31)
      | 0w32 => shuffle(s,s',0w32)
      | 0w33 => shuffle(s,s',0w33)
      | 0w34 => shuffle(s,s',0w34)
      | 0w35 => shuffle(s,s',0w35)
      | 0w36 => shuffle(s,s',0w36)
      | 0w37 => shuffle(s,s',0w37)
      | 0w38 => shuffle(s,s',0w38)
      | 0w39 => shuffle(s,s',0w39)
      | 0w40 => shuffle(s,s',0w40)
      | 0w41 => shuffle(s,s',0w41)
      | 0w42 => shuffle(s,s',0w42)
      | 0w43 => shuffle(s,s',0w43)
      | 0w44 => shuffle(s,s',0w44)
      | 0w45 => shuffle(s,s',0w45)
      | 0w46 => shuffle(s,s',0w46)
      | 0w47 => shuffle(s,s',0w47)
      | 0w48 => shuffle(s,s',0w48)
      | 0w49 => shuffle(s,s',0w49)
      | 0w50 => shuffle(s,s',0w50)
      | 0w51 => shuffle(s,s',0w51)
      | 0w52 => shuffle(s,s',0w52)
      | 0w53 => shuffle(s,s',0w53)
      | 0w54 => shuffle(s,s',0w54)
      | 0w55 => shuffle(s,s',0w55)
      | 0w56 => shuffle(s,s',0w56)
      | 0w57 => shuffle(s,s',0w57)
      | 0w58 => shuffle(s,s',0w58)
      | 0w59 => shuffle(s,s',0w59)
      | 0w60 => shuffle(s,s',0w60)
      | 0w61 => shuffle(s,s',0w61)
      | 0w62 => shuffle(s,s',0w62)
      | 0w63 => shuffle(s,s',0w63)
      | 0w64 => shuffle(s,s',0w64)
      | 0w65 => shuffle(s,s',0w65)
      | 0w66 => shuffle(s,s',0w66)
      | 0w67 => shuffle(s,s',0w67)
      | 0w68 => shuffle(s,s',0w68)
      | 0w69 => shuffle(s,s',0w69)
      | 0w70 => shuffle(s,s',0w70)
      | 0w71 => shuffle(s,s',0w71)
      | 0w72 => shuffle(s,s',0w72)
      | 0w73 => shuffle(s,s',0w73)
      | 0w74 => shuffle(s,s',0w74)
      | 0w75 => shuffle(s,s',0w75)
      | 0w76 => shuffle(s,s',0w76)
      | 0w77 => shuffle(s,s',0w77)
      | 0w78 => shuffle(s,s',0w78)
      | 0w79 => shuffle(s,s',0w79)
      | 0w80 => shuffle(s,s',0w80)
      | 0w81 => shuffle(s,s',0w81)
      | 0w82 => shuffle(s,s',0w82)
      | 0w83 => shuffle(s,s',0w83)
      | 0w84 => shuffle(s,s',0w84)
      | 0w85 => shuffle(s,s',0w85)
      | 0w86 => shuffle(s,s',0w86)
      | 0w87 => shuffle(s,s',0w87)
      | 0w88 => shuffle(s,s',0w88)
      | 0w89 => shuffle(s,s',0w89)
      | 0w90 => shuffle(s,s',0w90)
      | 0w91 => shuffle(s,s',0w91)
      | 0w92 => shuffle(s,s',0w92)
      | 0w93 => shuffle(s,s',0w93)
      | 0w94 => shuffle(s,s',0w94)
      | 0w95 => shuffle(s,s',0w95)
      | 0w96 => shuffle(s,s',0w96)
      | 0w97 => shuffle(s,s',0w97)
      | 0w98 => shuffle(s,s',0w98)
      | 0w99 => shuffle(s,s',0w99)
      | 0w100 => shuffle(s,s',0w100)
      | 0w101 => shuffle(s,s',0w101)
      | 0w102 => shuffle(s,s',0w102)
      | 0w103 => shuffle(s,s',0w103)
      | 0w104 => shuffle(s,s',0w104)
      | 0w105 => shuffle(s,s',0w105)
      | 0w106 => shuffle(s,s',0w106)
      | 0w107 => shuffle(s,s',0w107)
      | 0w108 => shuffle(s,s',0w108)
      | 0w109 => shuffle(s,s',0w109)
      | 0w110 => shuffle(s,s',0w110)
      | 0w111 => shuffle(s,s',0w111)
      | 0w112 => shuffle(s,s',0w112)
      | 0w113 => shuffle(s,s',0w113)
      | 0w114 => shuffle(s,s',0w114)
      | 0w115 => shuffle(s,s',0w115)
      | 0w116 => shuffle(s,s',0w116)
      | 0w117 => shuffle(s,s',0w117)
      | 0w118 => shuffle(s,s',0w118)
      | 0w119 => shuffle(s,s',0w119)
      | 0w120 => shuffle(s,s',0w120)
      | 0w121 => shuffle(s,s',0w121)
      | 0w122 => shuffle(s,s',0w122)
      | 0w123 => shuffle(s,s',0w123)
      | 0w124 => shuffle(s,s',0w124)
      | 0w125 => shuffle(s,s',0w125)
      | 0w126 => shuffle(s,s',0w126)
      | 0w127 => shuffle(s,s',0w127)
      | 0w128 => shuffle(s,s',0w128)
      | 0w129 => shuffle(s,s',0w129)
      | 0w130 => shuffle(s,s',0w130)
      | 0w131 => shuffle(s,s',0w131)
      | 0w132 => shuffle(s,s',0w132)
      | 0w133 => shuffle(s,s',0w133)
      | 0w134 => shuffle(s,s',0w134)
      | 0w135 => shuffle(s,s',0w135)
      | 0w136 => shuffle(s,s',0w136)
      | 0w137 => shuffle(s,s',0w137)
      | 0w138 => shuffle(s,s',0w138)
      | 0w139 => shuffle(s,s',0w139)
      | 0w140 => shuffle(s,s',0w140)
      | 0w141 => shuffle(s,s',0w141)
      | 0w142 => shuffle(s,s',0w142)
      | 0w143 => shuffle(s,s',0w143)
      | 0w144 => shuffle(s,s',0w144)
      | 0w145 => shuffle(s,s',0w145)
      | 0w146 => shuffle(s,s',0w146)
      | 0w147 => shuffle(s,s',0w147)
      | 0w148 => shuffle(s,s',0w148)
      | 0w149 => shuffle(s,s',0w149)
      | 0w150 => shuffle(s,s',0w150)
      | 0w151 => shuffle(s,s',0w151)
      | 0w152 => shuffle(s,s',0w152)
      | 0w153 => shuffle(s,s',0w153)
      | 0w154 => shuffle(s,s',0w154)
      | 0w155 => shuffle(s,s',0w155)
      | 0w156 => shuffle(s,s',0w156)
      | 0w157 => shuffle(s,s',0w157)
      | 0w158 => shuffle(s,s',0w158)
      | 0w159 => shuffle(s,s',0w159)
      | 0w160 => shuffle(s,s',0w160)
      | 0w161 => shuffle(s,s',0w161)
      | 0w162 => shuffle(s,s',0w162)
      | 0w163 => shuffle(s,s',0w163)
      | 0w164 => shuffle(s,s',0w164)
      | 0w165 => shuffle(s,s',0w165)
      | 0w166 => shuffle(s,s',0w166)
      | 0w167 => shuffle(s,s',0w167)
      | 0w168 => shuffle(s,s',0w168)
      | 0w169 => shuffle(s,s',0w169)
      | 0w170 => shuffle(s,s',0w170)
      | 0w171 => shuffle(s,s',0w171)
      | 0w172 => shuffle(s,s',0w172)
      | 0w173 => shuffle(s,s',0w173)
      | 0w174 => shuffle(s,s',0w174)
      | 0w175 => shuffle(s,s',0w175)
      | 0w176 => shuffle(s,s',0w176)
      | 0w177 => shuffle(s,s',0w177)
      | 0w178 => shuffle(s,s',0w178)
      | 0w179 => shuffle(s,s',0w179)
      | 0w180 => shuffle(s,s',0w180)
      | 0w181 => shuffle(s,s',0w181)
      | 0w182 => shuffle(s,s',0w182)
      | 0w183 => shuffle(s,s',0w183)
      | 0w184 => shuffle(s,s',0w184)
      | 0w185 => shuffle(s,s',0w185)
      | 0w186 => shuffle(s,s',0w186)
      | 0w187 => shuffle(s,s',0w187)
      | 0w188 => shuffle(s,s',0w188)
      | 0w189 => shuffle(s,s',0w189)
      | 0w190 => shuffle(s,s',0w190)
      | 0w191 => shuffle(s,s',0w191)
      | 0w192 => shuffle(s,s',0w192)
      | 0w193 => shuffle(s,s',0w193)
      | 0w194 => shuffle(s,s',0w194)
      | 0w195 => shuffle(s,s',0w195)
      | 0w196 => shuffle(s,s',0w196)
      | 0w197 => shuffle(s,s',0w197)
      | 0w198 => shuffle(s,s',0w198)
      | 0w199 => shuffle(s,s',0w199)
      | 0w200 => shuffle(s,s',0w200)
      | 0w201 => shuffle(s,s',0w201)
      | 0w202 => shuffle(s,s',0w202)
      | 0w203 => shuffle(s,s',0w203)
      | 0w204 => shuffle(s,s',0w204)
      | 0w205 => shuffle(s,s',0w205)
      | 0w206 => shuffle(s,s',0w206)
      | 0w207 => shuffle(s,s',0w207)
      | 0w208 => shuffle(s,s',0w208)
      | 0w209 => shuffle(s,s',0w209)
      | 0w210 => shuffle(s,s',0w210)
      | 0w211 => shuffle(s,s',0w211)
      | 0w212 => shuffle(s,s',0w212)
      | 0w213 => shuffle(s,s',0w213)
      | 0w214 => shuffle(s,s',0w214)
      | 0w215 => shuffle(s,s',0w215)
      | 0w216 => shuffle(s,s',0w216)
      | 0w217 => shuffle(s,s',0w217)
      | 0w218 => shuffle(s,s',0w218)
      | 0w219 => shuffle(s,s',0w219)
      | 0w220 => shuffle(s,s',0w220)
      | 0w221 => shuffle(s,s',0w221)
      | 0w222 => shuffle(s,s',0w222)
      | 0w223 => shuffle(s,s',0w223)
      | 0w224 => shuffle(s,s',0w224)
      | 0w225 => shuffle(s,s',0w225)
      | 0w226 => shuffle(s,s',0w226)
      | 0w227 => shuffle(s,s',0w227)
      | 0w228 => shuffle(s,s',0w228)
      | 0w229 => shuffle(s,s',0w229)
      | 0w230 => shuffle(s,s',0w230)
      | 0w231 => shuffle(s,s',0w231)
      | 0w232 => shuffle(s,s',0w232)
      | 0w233 => shuffle(s,s',0w233)
      | 0w234 => shuffle(s,s',0w234)
      | 0w235 => shuffle(s,s',0w235)
      | 0w236 => shuffle(s,s',0w236)
      | 0w237 => shuffle(s,s',0w237)
      | 0w238 => shuffle(s,s',0w238)
      | 0w239 => shuffle(s,s',0w239)
      | 0w240 => shuffle(s,s',0w240)
      | 0w241 => shuffle(s,s',0w241)
      | 0w242 => shuffle(s,s',0w242)
      | 0w243 => shuffle(s,s',0w243)
      | 0w244 => shuffle(s,s',0w244)
      | 0w245 => shuffle(s,s',0w245)
      | 0w246 => shuffle(s,s',0w246)
      | 0w247 => shuffle(s,s',0w247)
      | 0w248 => shuffle(s,s',0w248)
      | 0w249 => shuffle(s,s',0w249)
      | 0w250 => shuffle(s,s',0w250)
      | 0w251 => shuffle(s,s',0w251)
      | 0w252 => shuffle(s,s',0w252)
      | 0w253 => shuffle(s,s',0w253)
      | 0w254 => shuffle(s,s',0w254)
      | 0w255 => shuffle(s,s',0w255)
end
structure Shuffle32:SIMD_SHUFFLE = mkShuffle(struct
                                 open Primitive.Simd128_Real32
                                 type simd=simdReal end)
structure Shuffle64:SIMD_SHUFFLE = mkShuffle(struct
                                 open Primitive.Simd128_Real64
                                 type simd=simdReal end)
