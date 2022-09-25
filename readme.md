# Old-School Assembler

Minix Assembler compatible for DOS

# Variants

- OSASMCOM - Generate .com file. ORG 0x100
- OSASMSYS - Generate .sys file. ORG 0x0
- OSASMPRG - Generate .prg file. ORG 0x800

# Usage

Call osasm variant with file name without extension.

```sh
osasmcom file
```

# Macros

- .zerob size - Insert zero bytes in output file
- .zerow size - Insert zero words in output file
- .include file - Import external .s file
- .byte value - Insert one byte in output file
- .word value - Insert one word in output file
- .ascii "string" - Insert one string in output file
- .asciz "string" - Insert one string with ASCIZ ending in output file
