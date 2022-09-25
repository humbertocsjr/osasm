OutputFrom = 2048
OutputFileNameExt1 = 'p'!'.'
OutputFileNameExt2 = 'g'!'r'

.include ASM\MAIN.S
.include asm\input.s
.include asm\symbols.s 
.include asm\display.s 
.include asm\support.s 
.include asm\equ.s 
.include asm\expr.s 
.include asm\direct.s 
.include asm\output.s 

PlatformMessage:
  .asciz "HUSIS"
