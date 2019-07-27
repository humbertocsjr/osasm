|This procedure is called, in case the assembler found an error, the
|On input
|  BX points to the message to be printed
|
|The procedure print 'asm :', the message, a carriage return and a line feed
|and exits to dos


PanicRecover:
  call PutErrorAndPosition
  call DisplayOtherMessage
  call PutCarriageReturn
  call CommentStarted
  mov  sp,SavedStackPointer
  jmp  Assemble1

Panic:
  call PutErrorAndPosition
  call DisplayOtherMessage
CRAndExitToDos:
  call PutCarriageReturn
  call CloseInputFile
  call CloseOutputFiles
  call RemoveOutputFile
ExitToDos:
  movb  ah,#TerminateFunction
  int  #DosInterrupt

PutPosition:
  push bx
  mov  bx,PresentFileNameOffset
  or   bx,bx
  jnz  NotCommandLine
  call DisplayMessage
  .asciz "Command line"
  jmps DisplayForAllMessages
NotCommandLine:
  call DisplayOtherMessage
  call DisplayMessage
  .asciz ":"
  mov  ax,InputLineNumber
  call DisplayAXInDecimal
DisplayForAllMessages:
  call DisplayMessage
  .asciz ":"
  pop  bx
  ret

PutErrorAndPosition:
  call DisplayMessage
  .asciz "Error:"
  call PutPosition
  ret

PutExpectedMessage:
  call PutErrorAndPosition
  call DisplayMessage
  .asciz "'"
  call DisplayOtherMessage
  call DisplayMessage
  .asciz "'"
  call DisplayMessage
  .asciz " expected"
  jmp  CRAndExitToDos

HeaderMessage1:
  .asciz "Old-School Assembler para "
HeaderMessage2:
  .asciz " "
HeaderMessage3:
  .byte 13
  .byte 10
  .ascii " Copyright (c) 1991-2011, Venkat Iyer"
  .byte 13
  .byte 10
  .ascii " Copyright (c) 2019, Humberto Costa dos Santos Junior"
  .byte 13
  .byte 10
  .byte 13
  .byte 10
  .byte 0

HelpMessage:
  .asciz "Uso - osasm [arquivo]"
NoInputFileMessage:
  .asciz "Nao foi possivel abrir o arquivo"
ErrorReadingInputMessage:
  .asciz "Erro ao ler o arquivo"
BadStartMessage:
  .asciz "Erro de sintaxe, identificador iniciado errado"
IdentLargeMessage:
  .asciz "Identificador muito longo"
InvalidInstrMessage:
  .asciz "Instrucao invalida"
ExtraCharsMessage:
  .asciz "Caracteres extras na Linha"
SymTabOverflowMessage:
  .asciz "Estouro da tabela de simbolos"
RedefinitionMessage:
  .asciz "Simbilo ja definido"
LargeConstMessage:
  .asciz "Constante muito longa"
LargeIdentMessage:
  .asciz "Identificador muito longo"
StrTblOverflowMessage:
  .asciz "Estouro da tabela de strings"
SyntaxErrMessage:
  .asciz "Erro de sintaxe na expressao"
BracketsErrMessage:
  .asciz "Colchetes sem fechamento"
OverFlowMessage:
  .asciz "Estouro na avaliacao da expressao"
SymbolNotDefinedMessage:
  .asciz "Simbolo nao definido"
OutputFileMessage:
  .asciz "Erro ao escrever arquivo de saida"
OutputBigMessage:
  .asciz "Arquivo de saida muito grande"
LargeOperandMessage:
  .asciz "Tamanho do Operando muito grande"
NumOpExpectedMessage:
  .asciz "Operando numerico esperado"
InvalidAddrMode:
  .asciz "Modo de enderecamento invalido"
OperandExpectedMessage:
  .asciz "Mensagem experada do operando"
ImmediateOpsMessage:
  .asciz "Nao permitido operando imediato"
MemoryOperandMessage:
  .asciz "Nao permitido operando de memoria"
JumpErrorMessage:
  .asciz "Pulo relativo fora de alcance"
IncludeFileErrorMessage:
  .asciz "Arquivo incluido nao encontrado"
InvalidOperandMessage:
  .asciz "Operando invalido"
ATVErrorMessage:
  .asciz "Expressao nao pode ser interpretada"
NonZeroMessage:
  .asciz "Expressao interpretada como diferente de zero"
MissingQuoteMessage:
  .asciz "Erro na constante de texto - falta aspas"

CommaMessage:
  .asciz ","
ColonMessage:
  .asciz ":"
QuotesMessage:
  .byte 34		|double quotes
  .byte 0
DisplacementMessage:
  .asciz "deslocamento"
MemOperandMessage:
  .asciz "Operando de Memoria"
RegOperandMessage:
  .asciz "Operando de Registrador"
RegOrMemMessage:
  .asciz "Operando de Registr. ou Memoria"
IncludeFileMessage:
  .asciz " Incluindo arquivo "

InputFileHandle:
  .word 0
InputLineNumber:
  .word 1
OutputFileHandle:
  .word 0
ListFileHandle:
  .word 0
SavedStackPointer:
  .word 0
InputBufferReadPtr:
  .word 0
InputBufferEndPtr:
  .word 0
InputBuffer:
  .zerow   BufferSize / 2
InputWord:
  .zerow   WordSize / 2
BackupWord:
  .zerow  WordSize / 2
