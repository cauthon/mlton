MLTON_CODEGEN_STATIC_INLINE
Simd128_Real32_t
Simd128_Real32_shuffle
  (Simd128_Real32_t s1,Simd128_Real32_t s2,const Word8_t imm){
switch (imm){
    case 0:
      return _mm_shuffle_ps (s1,s2,0);
    case 1:
      return _mm_shuffle_ps (s1,s2,1);
    case 2:
      return _mm_shuffle_ps (s1,s2,2);
    case 3:
      return _mm_shuffle_ps (s1,s2,3);
    case 4:
      return _mm_shuffle_ps (s1,s2,4);
    case 5:
      return _mm_shuffle_ps (s1,s2,5);
    case 6:
      return _mm_shuffle_ps (s1,s2,6);
    case 7:
      return _mm_shuffle_ps (s1,s2,7);
    case 8:
      return _mm_shuffle_ps (s1,s2,8);
    case 9:
      return _mm_shuffle_ps (s1,s2,9);
    case 10:
      return _mm_shuffle_ps (s1,s2,10);
    case 11:
      return _mm_shuffle_ps (s1,s2,11);
    case 12:
      return _mm_shuffle_ps (s1,s2,12);
    case 13:
      return _mm_shuffle_ps (s1,s2,13);
    case 14:
      return _mm_shuffle_ps (s1,s2,14);
    case 15:
      return _mm_shuffle_ps (s1,s2,15);
    case 16:
      return _mm_shuffle_ps (s1,s2,16);
    case 17:
      return _mm_shuffle_ps (s1,s2,17);
    case 18:
      return _mm_shuffle_ps (s1,s2,18);
    case 19:
      return _mm_shuffle_ps (s1,s2,19);
    case 20:
      return _mm_shuffle_ps (s1,s2,20);
    case 21:
      return _mm_shuffle_ps (s1,s2,21);
    case 22:
      return _mm_shuffle_ps (s1,s2,22);
    case 23:
      return _mm_shuffle_ps (s1,s2,23);
    case 24:
      return _mm_shuffle_ps (s1,s2,24);
    case 25:
      return _mm_shuffle_ps (s1,s2,25);
    case 26:
      return _mm_shuffle_ps (s1,s2,26);
    case 27:
      return _mm_shuffle_ps (s1,s2,27);
    case 28:
      return _mm_shuffle_ps (s1,s2,28);
    case 29:
      return _mm_shuffle_ps (s1,s2,29);
    case 30:
      return _mm_shuffle_ps (s1,s2,30);
    case 31:
      return _mm_shuffle_ps (s1,s2,31);
    case 32:
      return _mm_shuffle_ps (s1,s2,32);
    case 33:
      return _mm_shuffle_ps (s1,s2,33);
    case 34:
      return _mm_shuffle_ps (s1,s2,34);
    case 35:
      return _mm_shuffle_ps (s1,s2,35);
    case 36:
      return _mm_shuffle_ps (s1,s2,36);
    case 37:
      return _mm_shuffle_ps (s1,s2,37);
    case 38:
      return _mm_shuffle_ps (s1,s2,38);
    case 39:
      return _mm_shuffle_ps (s1,s2,39);
    case 40:
      return _mm_shuffle_ps (s1,s2,40);
    case 41:
      return _mm_shuffle_ps (s1,s2,41);
    case 42:
      return _mm_shuffle_ps (s1,s2,42);
    case 43:
      return _mm_shuffle_ps (s1,s2,43);
    case 44:
      return _mm_shuffle_ps (s1,s2,44);
    case 45:
      return _mm_shuffle_ps (s1,s2,45);
    case 46:
      return _mm_shuffle_ps (s1,s2,46);
    case 47:
      return _mm_shuffle_ps (s1,s2,47);
    case 48:
      return _mm_shuffle_ps (s1,s2,48);
    case 49:
      return _mm_shuffle_ps (s1,s2,49);
    case 50:
      return _mm_shuffle_ps (s1,s2,50);
    case 51:
      return _mm_shuffle_ps (s1,s2,51);
    case 52:
      return _mm_shuffle_ps (s1,s2,52);
    case 53:
      return _mm_shuffle_ps (s1,s2,53);
    case 54:
      return _mm_shuffle_ps (s1,s2,54);
    case 55:
      return _mm_shuffle_ps (s1,s2,55);
    case 56:
      return _mm_shuffle_ps (s1,s2,56);
    case 57:
      return _mm_shuffle_ps (s1,s2,57);
    case 58:
      return _mm_shuffle_ps (s1,s2,58);
    case 59:
      return _mm_shuffle_ps (s1,s2,59);
    case 60:
      return _mm_shuffle_ps (s1,s2,60);
    case 61:
      return _mm_shuffle_ps (s1,s2,61);
    case 62:
      return _mm_shuffle_ps (s1,s2,62);
    case 63:
      return _mm_shuffle_ps (s1,s2,63);
    case 64:
      return _mm_shuffle_ps (s1,s2,64);
    case 65:
      return _mm_shuffle_ps (s1,s2,65);
    case 66:
      return _mm_shuffle_ps (s1,s2,66);
    case 67:
      return _mm_shuffle_ps (s1,s2,67);
    case 68:
      return _mm_shuffle_ps (s1,s2,68);
    case 69:
      return _mm_shuffle_ps (s1,s2,69);
    case 70:
      return _mm_shuffle_ps (s1,s2,70);
    case 71:
      return _mm_shuffle_ps (s1,s2,71);
    case 72:
      return _mm_shuffle_ps (s1,s2,72);
    case 73:
      return _mm_shuffle_ps (s1,s2,73);
    case 74:
      return _mm_shuffle_ps (s1,s2,74);
    case 75:
      return _mm_shuffle_ps (s1,s2,75);
    case 76:
      return _mm_shuffle_ps (s1,s2,76);
    case 77:
      return _mm_shuffle_ps (s1,s2,77);
    case 78:
      return _mm_shuffle_ps (s1,s2,78);
    case 79:
      return _mm_shuffle_ps (s1,s2,79);
    case 80:
      return _mm_shuffle_ps (s1,s2,80);
    case 81:
      return _mm_shuffle_ps (s1,s2,81);
    case 82:
      return _mm_shuffle_ps (s1,s2,82);
    case 83:
      return _mm_shuffle_ps (s1,s2,83);
    case 84:
      return _mm_shuffle_ps (s1,s2,84);
    case 85:
      return _mm_shuffle_ps (s1,s2,85);
    case 86:
      return _mm_shuffle_ps (s1,s2,86);
    case 87:
      return _mm_shuffle_ps (s1,s2,87);
    case 88:
      return _mm_shuffle_ps (s1,s2,88);
    case 89:
      return _mm_shuffle_ps (s1,s2,89);
    case 90:
      return _mm_shuffle_ps (s1,s2,90);
    case 91:
      return _mm_shuffle_ps (s1,s2,91);
    case 92:
      return _mm_shuffle_ps (s1,s2,92);
    case 93:
      return _mm_shuffle_ps (s1,s2,93);
    case 94:
      return _mm_shuffle_ps (s1,s2,94);
    case 95:
      return _mm_shuffle_ps (s1,s2,95);
    case 96:
      return _mm_shuffle_ps (s1,s2,96);
    case 97:
      return _mm_shuffle_ps (s1,s2,97);
    case 98:
      return _mm_shuffle_ps (s1,s2,98);
    case 99:
      return _mm_shuffle_ps (s1,s2,99);
    case 100:
      return _mm_shuffle_ps (s1,s2,100);
    case 101:
      return _mm_shuffle_ps (s1,s2,101);
    case 102:
      return _mm_shuffle_ps (s1,s2,102);
    case 103:
      return _mm_shuffle_ps (s1,s2,103);
    case 104:
      return _mm_shuffle_ps (s1,s2,104);
    case 105:
      return _mm_shuffle_ps (s1,s2,105);
    case 106:
      return _mm_shuffle_ps (s1,s2,106);
    case 107:
      return _mm_shuffle_ps (s1,s2,107);
    case 108:
      return _mm_shuffle_ps (s1,s2,108);
    case 109:
      return _mm_shuffle_ps (s1,s2,109);
    case 110:
      return _mm_shuffle_ps (s1,s2,110);
    case 111:
      return _mm_shuffle_ps (s1,s2,111);
    case 112:
      return _mm_shuffle_ps (s1,s2,112);
    case 113:
      return _mm_shuffle_ps (s1,s2,113);
    case 114:
      return _mm_shuffle_ps (s1,s2,114);
    case 115:
      return _mm_shuffle_ps (s1,s2,115);
    case 116:
      return _mm_shuffle_ps (s1,s2,116);
    case 117:
      return _mm_shuffle_ps (s1,s2,117);
    case 118:
      return _mm_shuffle_ps (s1,s2,118);
    case 119:
      return _mm_shuffle_ps (s1,s2,119);
    case 120:
      return _mm_shuffle_ps (s1,s2,120);
    case 121:
      return _mm_shuffle_ps (s1,s2,121);
    case 122:
      return _mm_shuffle_ps (s1,s2,122);
    case 123:
      return _mm_shuffle_ps (s1,s2,123);
    case 124:
      return _mm_shuffle_ps (s1,s2,124);
    case 125:
      return _mm_shuffle_ps (s1,s2,125);
    case 126:
      return _mm_shuffle_ps (s1,s2,126);
    case 127:
      return _mm_shuffle_ps (s1,s2,127);
    case 128:
      return _mm_shuffle_ps (s1,s2,128);
    case 129:
      return _mm_shuffle_ps (s1,s2,129);
    case 130:
      return _mm_shuffle_ps (s1,s2,130);
    case 131:
      return _mm_shuffle_ps (s1,s2,131);
    case 132:
      return _mm_shuffle_ps (s1,s2,132);
    case 133:
      return _mm_shuffle_ps (s1,s2,133);
    case 134:
      return _mm_shuffle_ps (s1,s2,134);
    case 135:
      return _mm_shuffle_ps (s1,s2,135);
    case 136:
      return _mm_shuffle_ps (s1,s2,136);
    case 137:
      return _mm_shuffle_ps (s1,s2,137);
    case 138:
      return _mm_shuffle_ps (s1,s2,138);
    case 139:
      return _mm_shuffle_ps (s1,s2,139);
    case 140:
      return _mm_shuffle_ps (s1,s2,140);
    case 141:
      return _mm_shuffle_ps (s1,s2,141);
    case 142:
      return _mm_shuffle_ps (s1,s2,142);
    case 143:
      return _mm_shuffle_ps (s1,s2,143);
    case 144:
      return _mm_shuffle_ps (s1,s2,144);
    case 145:
      return _mm_shuffle_ps (s1,s2,145);
    case 146:
      return _mm_shuffle_ps (s1,s2,146);
    case 147:
      return _mm_shuffle_ps (s1,s2,147);
    case 148:
      return _mm_shuffle_ps (s1,s2,148);
    case 149:
      return _mm_shuffle_ps (s1,s2,149);
    case 150:
      return _mm_shuffle_ps (s1,s2,150);
    case 151:
      return _mm_shuffle_ps (s1,s2,151);
    case 152:
      return _mm_shuffle_ps (s1,s2,152);
    case 153:
      return _mm_shuffle_ps (s1,s2,153);
    case 154:
      return _mm_shuffle_ps (s1,s2,154);
    case 155:
      return _mm_shuffle_ps (s1,s2,155);
    case 156:
      return _mm_shuffle_ps (s1,s2,156);
    case 157:
      return _mm_shuffle_ps (s1,s2,157);
    case 158:
      return _mm_shuffle_ps (s1,s2,158);
    case 159:
      return _mm_shuffle_ps (s1,s2,159);
    case 160:
      return _mm_shuffle_ps (s1,s2,160);
    case 161:
      return _mm_shuffle_ps (s1,s2,161);
    case 162:
      return _mm_shuffle_ps (s1,s2,162);
    case 163:
      return _mm_shuffle_ps (s1,s2,163);
    case 164:
      return _mm_shuffle_ps (s1,s2,164);
    case 165:
      return _mm_shuffle_ps (s1,s2,165);
    case 166:
      return _mm_shuffle_ps (s1,s2,166);
    case 167:
      return _mm_shuffle_ps (s1,s2,167);
    case 168:
      return _mm_shuffle_ps (s1,s2,168);
    case 169:
      return _mm_shuffle_ps (s1,s2,169);
    case 170:
      return _mm_shuffle_ps (s1,s2,170);
    case 171:
      return _mm_shuffle_ps (s1,s2,171);
    case 172:
      return _mm_shuffle_ps (s1,s2,172);
    case 173:
      return _mm_shuffle_ps (s1,s2,173);
    case 174:
      return _mm_shuffle_ps (s1,s2,174);
    case 175:
      return _mm_shuffle_ps (s1,s2,175);
    case 176:
      return _mm_shuffle_ps (s1,s2,176);
    case 177:
      return _mm_shuffle_ps (s1,s2,177);
    case 178:
      return _mm_shuffle_ps (s1,s2,178);
    case 179:
      return _mm_shuffle_ps (s1,s2,179);
    case 180:
      return _mm_shuffle_ps (s1,s2,180);
    case 181:
      return _mm_shuffle_ps (s1,s2,181);
    case 182:
      return _mm_shuffle_ps (s1,s2,182);
    case 183:
      return _mm_shuffle_ps (s1,s2,183);
    case 184:
      return _mm_shuffle_ps (s1,s2,184);
    case 185:
      return _mm_shuffle_ps (s1,s2,185);
    case 186:
      return _mm_shuffle_ps (s1,s2,186);
    case 187:
      return _mm_shuffle_ps (s1,s2,187);
    case 188:
      return _mm_shuffle_ps (s1,s2,188);
    case 189:
      return _mm_shuffle_ps (s1,s2,189);
    case 190:
      return _mm_shuffle_ps (s1,s2,190);
    case 191:
      return _mm_shuffle_ps (s1,s2,191);
    case 192:
      return _mm_shuffle_ps (s1,s2,192);
    case 193:
      return _mm_shuffle_ps (s1,s2,193);
    case 194:
      return _mm_shuffle_ps (s1,s2,194);
    case 195:
      return _mm_shuffle_ps (s1,s2,195);
    case 196:
      return _mm_shuffle_ps (s1,s2,196);
    case 197:
      return _mm_shuffle_ps (s1,s2,197);
    case 198:
      return _mm_shuffle_ps (s1,s2,198);
    case 199:
      return _mm_shuffle_ps (s1,s2,199);
    case 200:
      return _mm_shuffle_ps (s1,s2,200);
    case 201:
      return _mm_shuffle_ps (s1,s2,201);
    case 202:
      return _mm_shuffle_ps (s1,s2,202);
    case 203:
      return _mm_shuffle_ps (s1,s2,203);
    case 204:
      return _mm_shuffle_ps (s1,s2,204);
    case 205:
      return _mm_shuffle_ps (s1,s2,205);
    case 206:
      return _mm_shuffle_ps (s1,s2,206);
    case 207:
      return _mm_shuffle_ps (s1,s2,207);
    case 208:
      return _mm_shuffle_ps (s1,s2,208);
    case 209:
      return _mm_shuffle_ps (s1,s2,209);
    case 210:
      return _mm_shuffle_ps (s1,s2,210);
    case 211:
      return _mm_shuffle_ps (s1,s2,211);
    case 212:
      return _mm_shuffle_ps (s1,s2,212);
    case 213:
      return _mm_shuffle_ps (s1,s2,213);
    case 214:
      return _mm_shuffle_ps (s1,s2,214);
    case 215:
      return _mm_shuffle_ps (s1,s2,215);
    case 216:
      return _mm_shuffle_ps (s1,s2,216);
    case 217:
      return _mm_shuffle_ps (s1,s2,217);
    case 218:
      return _mm_shuffle_ps (s1,s2,218);
    case 219:
      return _mm_shuffle_ps (s1,s2,219);
    case 220:
      return _mm_shuffle_ps (s1,s2,220);
    case 221:
      return _mm_shuffle_ps (s1,s2,221);
    case 222:
      return _mm_shuffle_ps (s1,s2,222);
    case 223:
      return _mm_shuffle_ps (s1,s2,223);
    case 224:
      return _mm_shuffle_ps (s1,s2,224);
    case 225:
      return _mm_shuffle_ps (s1,s2,225);
    case 226:
      return _mm_shuffle_ps (s1,s2,226);
    case 227:
      return _mm_shuffle_ps (s1,s2,227);
    case 228:
      return _mm_shuffle_ps (s1,s2,228);
    case 229:
      return _mm_shuffle_ps (s1,s2,229);
    case 230:
      return _mm_shuffle_ps (s1,s2,230);
    case 231:
      return _mm_shuffle_ps (s1,s2,231);
    case 232:
      return _mm_shuffle_ps (s1,s2,232);
    case 233:
      return _mm_shuffle_ps (s1,s2,233);
    case 234:
      return _mm_shuffle_ps (s1,s2,234);
    case 235:
      return _mm_shuffle_ps (s1,s2,235);
    case 236:
      return _mm_shuffle_ps (s1,s2,236);
    case 237:
      return _mm_shuffle_ps (s1,s2,237);
    case 238:
      return _mm_shuffle_ps (s1,s2,238);
    case 239:
      return _mm_shuffle_ps (s1,s2,239);
    case 240:
      return _mm_shuffle_ps (s1,s2,240);
    case 241:
      return _mm_shuffle_ps (s1,s2,241);
    case 242:
      return _mm_shuffle_ps (s1,s2,242);
    case 243:
      return _mm_shuffle_ps (s1,s2,243);
    case 244:
      return _mm_shuffle_ps (s1,s2,244);
    case 245:
      return _mm_shuffle_ps (s1,s2,245);
    case 246:
      return _mm_shuffle_ps (s1,s2,246);
    case 247:
      return _mm_shuffle_ps (s1,s2,247);
    case 248:
      return _mm_shuffle_ps (s1,s2,248);
    case 249:
      return _mm_shuffle_ps (s1,s2,249);
    case 250:
      return _mm_shuffle_ps (s1,s2,250);
    case 251:
      return _mm_shuffle_ps (s1,s2,251);
    case 252:
      return _mm_shuffle_ps (s1,s2,252);
    case 253:
      return _mm_shuffle_ps (s1,s2,253);
    case 254:
      return _mm_shuffle_ps (s1,s2,254);
    case 255:
      return _mm_shuffle_ps (s1,s2,255);
 }
}
MLTON_CODEGEN_STATIC_INLINE
Simd128_Real64_t
Simd128_Real64_shuffle
  (Simd128_Real64_t s1,Simd128_Real64_t s2,const Word8_t imm){
  switch(imm){
    case 0:                                             
      return _mm_shuffle_pd (s1,s2,0);
    case 1:                                             
      return _mm_shuffle_pd (s1,s2,1);
    case 2:                                             
      return _mm_shuffle_pd (s1,s2,2);
    case 3:                                             
      return _mm_shuffle_pd (s1,s2,3);
  }
}
