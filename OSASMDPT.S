.include ASM\MAIN.S
.include LANG\PTBR.S
.include asm\input.s
.include asm\symbols.s 
.include asm\display.s 
.include asm\support.s 
.include asm\equ.s 
.include asm\expr.s 
.include asm\direct.s 
.include asm\output.s 

PlatformMessage:
  .asciz "DOS"
VersionMessage:
  .asciz "v 1.11 [PT-BR]"

EndOfCode:
