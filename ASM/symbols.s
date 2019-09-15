;symbols.asm
;
;This file contains the symbol tables for the assembler.
;
MatchKeyword:
  lodsb
  movb  bl,al
  xorb  bh,bh

MatchKeyword1:
  mov  bp,si
  mov  di, #InputWord
  lodsb
  cmpb  al,#0
  jz   SymbolNotFound
  movb  cl,al
  xorb  ch,ch
  mov  dx,cx
  rep
  cmpsb
  jnz  NotThisSymbol
  cmpb -1[di],#0
  jz   ThisSymbol
  cmpb [di],#0
  jnz  NotThisSymbol
ThisSymbol:
  clc
  ret

NotThisSymbol:
  mov si,bp
  add si,dx
  add si,bx                             ;Number of bytes to skip
  inc si                                ;One more for the length
  jmps MatchKeyword1
SymbolNotFound:
  stc
  ret

;The pseudo instructions that are accepted by the assembler are
;    .align n            align on multiple of n bytes
;    .ascii str          assemble a string
;    .asciz str          assemble a zero terminated string
;    .bss                What follows goes to the bss segment
;    .byte n             Assemble one or more bytes
;    .data               What follows goes to the data segment
;    .define sym         Export Sym from the file
;    .errnz n            Force error if n is nonzero
;    .even               Align to an even address
;    .extern sym         Declare sym external
;    .globl sym          Same as Extern
;    .long n             Assemble n as a long
;    .org adr            Set Address within current segment
;    .short n            Assemble n as a short
;    .space n            Skip n bytes
;    .text               What follows goes to the text segment
;    .word n             Assemble n as a word
;    .zerow n            Assemble n words of zeros
;    .include filename   Include the specified file
;    .mark               Save current position on symtable
;    .release            Restore saved position to symtable

Directives:
  .byte 2
;0fddwi.byte f,s  .ascii j0fddwi.word j
  .byte 6
  .ascii ".align"
  .word ProcAlign
  .byte 6
  .ascii ".ascii"
  .word ProcAscii
  .byte 6
  .ascii ".asciz"
  .word ProcAsciz
  .byte 4
  .ascii ".bss"
  .word NotImplemented
  .byte 5
  .ascii ".byte"
  .word ProcByte
  .byte 5
  .ascii ".data"
  .word NotImplemented
  .byte 7
  .ascii ".define"
  .word NotImplemented
  .byte 6
  .ascii ".errnz"
  .word ProcErrnz
  .byte 5
  .ascii ".even"
  .word ProcEven
  .byte 7
  .ascii ".extern"
  .word NotImplemented
  .byte 6
  .ascii ".globl"
  .word NotImplemented
  .byte 8
  .ascii ".include"
  .word ProcInclude
  .byte 5
  .ascii ".long"
  .word ProcWord
  .byte 4
  .ascii ".org"
  .word ProcOrg
  .byte 6
  .ascii ".short"
  .word ProcWord
  .byte 6
  .ascii ".space"
  .word ProcSpace
  .byte 5
  .ascii ".text"
  .word NotImplemented
  .byte 5
  .ascii ".word"
  .word ProcWord
  .byte 6
  .ascii ".zerow"
  .word ProcZeroWords
;  .byte 5
;  .ascii ".mark"
;  .word ProcMark
;  .byte 8
;  .ascii ".release"
;  .word ProcRelease
  .byte 0


Instructions:
  .byte 4
;0fddwi.byte f,s  .ascii j0fddwi.word j0fddwi.byte f,s  .byte j
  .byte 3
  .ascii "aaa"
  .word NothingElse
  .byte 55
  .byte 0
  .byte 3
  .ascii "aad"
  .word NothingElse
  .byte 213
  .byte 10
  .byte 3
  .ascii "aam"
  .word NothingElse
  .byte 214
  .byte 10
  .byte 3
  .ascii "aas"
  .word NothingElse
  .byte 63
  .byte 0
  .byte 3
  .ascii "adc"
  .word AddType
  .byte 21
  .byte 17
  .byte 5
  .ascii "adcb"
  .byte 0
  .word AddType
  .byte 20
  .byte 16
  .byte 3
  .ascii "add"
  .word AddType
  .byte 5
  .byte 1
  .byte 5
  .ascii "addb"
  .byte 0
  .word AddType
  .byte 4
  .byte 0
  .byte 3
  .ascii "and"
  .word AddType
  .byte 37
  .byte 33
  .byte 5
  .ascii "andb"
  .byte 0
  .word AddType
  .byte 36
  .byte 32
  .byte 4
  .ascii "call"
  .word JmpCallType
  .byte 232
  .byte 16
  .byte 5
  .ascii "callf"
  .word JmpCallFarType
  .byte 0154
  .byte 24
  .byte 3
  .ascii "cbw"
  .word NothingElse
  .byte 152
  .byte 0
  .byte 3
  .ascii "clc"
  .word NothingElse
  .byte 248
  .byte 0
  .byte 3
  .ascii "cld"
  .word NothingElse
  .byte 252
  .byte 0
  .byte 3
  .ascii "cli"
  .word NothingElse
  .byte 250
  .byte 0
  .byte 3
  .ascii "cmc"
  .word NothingElse
  .byte 245
  .byte 0
  .byte 3
  .ascii "cmp"
  .word AddType
  .byte 61
  .byte 57
  .byte 5
  .ascii "cmpb"
  .byte 0
  .word AddType
  .byte 60
  .byte 56
  .byte 5
  .ascii "cmpsb"
  .word NothingElse
  .byte 166
  .byte 0
  .byte 5
  .ascii "cmpsw"
  .word NothingElse
  .byte 167
  .byte 0
  .byte 3
  .ascii "cwd"
  .word NothingElse
  .byte 153
  .byte 0
  .byte 3
  .ascii "daa"
  .word NothingElse
  .byte 39
  .byte 0
  .byte 3
  .ascii "das"
  .word NothingElse
  .byte 47
  .byte 0
  .byte 3
  .ascii "dec"
  .word IncDecType
  .byte 72
  .byte 8
  .byte 5
  .ascii "decb"
  .byte 0
  .word RegOrMem
  .byte 254
  .byte 8
  .byte 3
  .ascii "div"
  .word DivMulRegMem
  .byte 247
  .byte 48
  .byte 5
  .ascii "divb"
  .byte 0
  .word DivMulRegMem
  .byte 246
  .byte 48
  .byte 3
  .ascii "esc"
  .word NothingElse
  .byte 216
  .byte 0
  .byte 3
  .ascii "hlt"
  .word NothingElse
  .byte 244
  .byte 0
  .byte 4
  .ascii "idiv"
  .word DivMulRegMem
  .byte 247
  .byte 56
  .byte 6
  .ascii "idivb"
  .byte 0
  .word DivMulRegMem
  .byte 246
  .byte 56
  .byte 4
  .ascii "imul"
  .word DivMulRegMem
  .byte 247
  .byte 40
  .byte 6
  .ascii "imulb"
  .byte 0
  .word DivMulRegMem
  .byte 246
  .byte 40
  .byte 2
  .ascii "in"
  .word InOutPort
  .byte 229
  .byte 0
  .byte 4
  .ascii "inb"
  .byte 0
  .word InOutPort
  .byte 228
  .byte 0
  .byte 3
  .ascii "inc"
  .word IncDecType
  .byte 64
  .byte 0
  .byte 5
  .ascii "incb"
  .byte 0
  .word RegOrMem
  .byte 254
  .byte 0
  .byte 3
  .ascii "int"
  .word OneByteOnly
  .byte 205
  .byte 0
  .byte 4
  .ascii "int3"
  .word NothingElse
  .byte 204
  .byte 0
  .byte 4
  .ascii "into"
  .word NothingElse
  .byte 206
  .byte 0
  .byte 4
  .ascii "iret"
  .word NothingElse
  .byte 207
  .byte 0
  .byte 2
  .ascii "ja"
  .word OneRelativeLabel
  .byte 119
  .byte 0
  .byte 3
  .ascii "jae"
  .word OneRelativeLabel
  .byte 115
  .byte 0
  .byte 2
  .ascii "jb"
  .word OneRelativeLabel
  .byte 114
  .byte 0
  .byte 2
  .ascii "jc"
  .word OneRelativeLabel
  .byte 114
  .byte 0
  .byte 4
  .ascii "jcxz"
  .word OneRelativeLabel
  .byte 227
  .byte 0
  .byte 2
  .ascii "je"
  .word OneRelativeLabel
  .byte 116
  .byte 0
  .byte 2
  .ascii "jg"
  .word OneRelativeLabel
  .byte 127
  .byte 0
  .byte 3
  .ascii "jge"
  .word OneRelativeLabel
  .byte 125
  .byte 0
  .byte 2
  .ascii "jl"
  .word OneRelativeLabel
  .byte 124
  .byte 0
  .byte 3
  .ascii "jle"
  .word OneRelativeLabel
  .byte 126
  .byte 0
  .byte 3
  .ascii "jmp"
  .word JmpCallType
  .byte 233
  .byte 32
  .byte 4
  .ascii "jmpf"
  .word JmpCallFarType
  .byte 234
  .byte 40
  .byte 4
  .ascii "jmps"
  .word OneRelativeLabel
  .byte 235
  .byte 0
  .byte 3
  .ascii "jna"
  .word OneRelativeLabel
  .byte 118
  .byte 0
  .byte 3
  .ascii "jnb"
  .word OneRelativeLabel
  .byte 115
  .byte 0
  .byte 3
  .ascii "jnc"
  .word OneRelativeLabel
  .byte 115
  .byte 0
  .byte 3
  .ascii "jne"
  .word OneRelativeLabel
  .byte 117
  .byte 0
  .byte 3
  .ascii "jnz"
  .word OneRelativeLabel
  .byte 117
  .byte 0
  .byte 3
  .ascii "jno"
  .word OneRelativeLabel
  .byte 113
  .byte 0
  .byte 3
  .ascii "jnp"
  .word OneRelativeLabel
  .byte 123
  .byte 0
  .byte 3
  .ascii "jns"
  .word OneRelativeLabel
  .byte 121
  .byte 0
  .byte 2
  .ascii "jo"
  .word OneRelativeLabel
  .byte 112
  .byte 0
  .byte 2
  .ascii "jp"
  .word OneRelativeLabel
  .byte 122
  .byte 0
  .byte 2
  .ascii "js"
  .word OneRelativeLabel
  .byte 120
  .byte 0
  .byte 2
  .ascii "jz"
  .word OneRelativeLabel
  .byte 116
  .byte 0
  .byte 4
  .ascii "lahf"
  .word NothingElse
  .byte 159
  .byte 0
  .byte 3
  .ascii "lds"
  .word RegisterMemory
  .byte 197
  .byte 0
  .byte 3
  .ascii "lea"
  .word RegisterMemory
  .byte 0141
  .byte 0
  .byte 3
  .ascii "les"
  .word RegisterMemory
  .byte 196
  .byte 0
  .byte 4
  .ascii "lock"
  .word NothingElse
  .byte 240
  .byte 0
  .byte 5
  .ascii "lodsb"
  .word NothingElse
  .byte 172
  .byte 0
  .byte 5
  .ascii "lodsw"
  .word NothingElse
  .byte 173
  .byte 0
  .byte 4
  .ascii "loop"
  .word OneRelativeLabel
  .byte 226
  .byte 0
  .byte 5
  .ascii "loopz"
  .word OneRelativeLabel
  .byte 225
  .byte 0
  .byte 6
  .ascii "loopnz"
  .word OneRelativeLabel
  .byte 224
  .byte 0
  .byte 3
  .ascii "mov"
  .word MovType
  .byte 1
  .byte 0
  .byte 5
  .ascii "movb"
  .byte 0
  .word MovType
  .byte 0
  .byte 0
  .byte 5
  .ascii "movsb"
  .word NothingElse
  .byte 164
  .byte 0
  .byte 5
  .ascii "movsw"
  .word NothingElse
  .byte 165
  .byte 0
  .byte 3
  .ascii "mul"
  .word DivMulRegMem
  .byte 247
  .byte 32
  .byte 5
  .ascii "mulb"
  .byte 0
  .word DivMulRegMem
  .byte 246
  .byte 32
  .byte 3
  .ascii "neg"
  .word RegOrMem
  .byte 247
  .byte 24
  .byte 5
  .ascii "negb"
  .byte 0
  .word RegOrMem
  .byte 246
  .byte 24
  .byte 3
  .ascii "nop"
  .word NothingElse
  .byte 0144
  .byte 0
  .byte 3
  .ascii "not"
  .word RegOrMem
  .byte 247
  .byte 16
  .byte 5
  .ascii "notb"
  .byte 0
  .word RegOrMem
  .byte 246
  .byte 16
  .byte 2
  .ascii "or"
  .word AddType
  .byte 13
  .byte 9
  .byte 4
  .ascii "orb"
  .byte 0
  .word AddType
  .byte 12
  .byte 8
  .byte 3
  .ascii "out"
  .word InOutPort
  .byte 231
  .byte 0
  .byte 5
  .ascii "outb"
  .byte 0
  .word InOutPort
  .byte 230
  .byte 0
  .byte 3
  .ascii "pop"
  .word PushPopType
  .byte 143
  .byte 9
  .byte 4
  .ascii "popf"
  .word NothingElse
  .byte 157
  .byte 0
  .byte 4
  .ascii "push"
  .word PushPopType
  .byte 255
  .byte 48
  .byte 5
  .ascii "pushf"
  .word NothingElse
  .byte 156
  .byte 0
  .byte 3
  .ascii "rcl"
  .word ShiftRotate
  .byte 209
  .byte 16
  .byte 5
  .ascii "rclb"
  .byte 0
  .word ShiftRotate
  .byte 208
  .byte 16
  .byte 3
  .ascii "rcr"
  .word ShiftRotate
  .byte 209
  .byte 24
  .byte 5
  .ascii "rcrb"
  .byte 0
  .word ShiftRotate
  .byte 208
  .byte 24
  .byte 3
  .ascii "rep"
  .word NothingElse
  .byte 243
  .byte 0
  .byte 4
  .ascii "repz"
  .word NothingElse
  .byte 243
  .byte 0
  .byte 5
  .ascii "repnz"
  .word NothingElse
  .byte 242
  .byte 0
  .byte 3
  .ascii "ret"
  .word ReturnType
  .byte 195
  .byte 194
  .byte 4
  .ascii "retf"
  .word ReturnType
  .byte 203
  .byte 202
  .byte 3
  .ascii "rol"
  .word ShiftRotate
  .byte 209
  .byte 0
  .byte 5
  .ascii "rolb"
  .byte 0
  .word ShiftRotate
  .byte 208
  .byte 0
  .byte 3
  .ascii "ror"
  .word ShiftRotate
  .byte 209
  .byte 8
  .byte 5
  .ascii "rorb"
  .byte 0
  .word ShiftRotate
  .byte 208
  .byte 8
  .byte 4
  .ascii "sahf"
  .word NothingElse
  .byte 158
  .byte 0
  .byte 3
  .ascii "sal"
  .word ShiftRotate
  .byte 209
  .byte 32
  .byte 5
  .ascii "salb"
  .byte 0
  .word ShiftRotate
  .byte 208
  .byte 32
  .byte 3
  .ascii "sar"
  .word ShiftRotate
  .byte 209
  .byte 56
  .byte 5
  .ascii "sarb"
  .byte 0
  .word ShiftRotate
  .byte 208
  .byte 56
  .byte 3
  .ascii "sbb"
  .word AddType
  .byte 29
  .byte 25
  .byte 5
  .ascii "sbbb"
  .byte 0
  .word AddType
  .byte 28
  .byte 24
  .byte 5
  .ascii "scasb"
  .word NothingElse
  .byte 174
  .byte 0
  .byte 5
  .ascii "scasw"
  .word NothingElse
  .byte 175
  .byte 0
  .byte 3
  .ascii "seg"
  .word SegmentRegister
  .byte 38
  .byte 0
  .byte 3
  .ascii "shl"
  .word ShiftRotate
  .byte 209
  .byte 32
  .byte 5
  .ascii "shlb"
  .byte 0
  .word ShiftRotate
  .byte 208
  .byte 32
  .byte 3
  .ascii "shr"
  .word ShiftRotate
  .byte 209
  .byte 40
  .byte 5
  .ascii "shrb"
  .byte 0
  .word ShiftRotate
  .byte 208
  .byte 40
  .byte 3
  .ascii "stc"
  .word NothingElse
  .byte 249
  .byte 0
  .byte 3
  .ascii "std"
  .word NothingElse
  .byte 253
  .byte 0
  .byte 3
  .ascii "sti"
  .word NothingElse
  .byte 251
  .byte 0
  .byte 5
  .ascii "stosb"
  .word NothingElse
  .byte 170
  .byte 0
  .byte 5
  .ascii "stosw"
  .word NothingElse
  .byte 171
  .byte 0
  .byte 3
  .ascii "sub"
  .word AddType
  .byte 45
  .byte 41
  .byte 5
  .ascii "subb"
  .byte 0
  .word AddType
  .byte 44
  .byte 40
  .byte 4
  .ascii "test"
  .word AddType
  .byte 199
  .byte 133
  .byte 6
  .ascii "testb"
  .byte 0
  .word AddType
  .byte 199
  .byte 132
  .byte 4
  .ascii "wait"
  .word NothingElse
  .byte 0155
  .byte 0
  .byte 4
  .ascii "xchg"
  .word XchgType
  .byte 199
  .byte 135
  .byte 6
  .ascii "xchgb"
  .byte 0
  .word XchgType
  .byte 199
  .byte 134
  .byte 4
  .ascii "xlat"
  .word NothingElse
  .byte 215
  .byte 0
  .byte 3
  .ascii "xor"
  .word AddType
  .byte 53
  .byte 49
  .byte 5
  .ascii "xorb"
  .byte 0
  .word AddType
  .byte 52
  .byte 48
  .byte 0


;End of symbols.asm


AddressingModes:
  .byte 1
;0fddwi.byte f,s  .ascii j0fddwi.byte j
  .byte 5
  .ascii "bx_si"
  .byte 00
  .byte 5
  .ascii "bx_di"
  .byte 01
  .byte 5
  .ascii "bp_si"
  .byte 02
  .byte 5
  .ascii "bp_di"
  .byte 03
  .byte 2
  .ascii "si"
  .byte 04
  .byte 2
  .ascii "di"
  .byte 05
  .byte 2
  .ascii "bp"
  .byte 06
  .byte 2
  .ascii "bx"
  .byte 07
  .byte 0

BigRegisters:
  .byte 1

  .byte 2
  .ascii "ax"
  .byte 0
  .byte 2
  .ascii "cx"
  .byte 1
  .byte 2
  .ascii "dx"
  .byte 2
  .byte 2
  .ascii "bx"
  .byte 3
  .byte 2
  .ascii "sp"
  .byte 4
  .byte 2
  .ascii "bp"
  .byte 5
  .byte 2
  .ascii "si"
  .byte 6
  .byte 2
  .ascii "di"
  .byte 7

  .byte 0


SmallRegisters:
  .byte 1

  .byte 2
  .ascii "al"
  .byte 0
  .byte 2
  .ascii "cl"
  .byte 1
  .byte 2
  .ascii "dl"
  .byte 2
  .byte 2
  .ascii "bl"
  .byte 3
  .byte 2
  .ascii "ah"
  .byte 4
  .byte 2
  .ascii "ch"
  .byte 5
  .byte 2
  .ascii "dh"
  .byte 6
  .byte 2
  .ascii "bh"
  .byte 7

  .byte 0

SegmentRegisters:
  .byte 1
  
  .byte 2
  .ascii "es"
  .byte 0
  .byte 2
  .ascii "cs"
  .byte 1
  .byte 2
  .ascii "ss"
  .byte 2
  .byte 2
  .ascii "ds"
  .byte 3

  .byte 0


