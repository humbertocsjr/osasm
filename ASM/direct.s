;    .ascii str          assemble a string

QuoteExpected:
  mov  bx,#QuotesMessage
  call PutExpectedMessage

ProcAscii:
  call IgnoreSpaces
  call GetChar
  jc   QuoteExpected
  cmpb  al,#'"'
  jnz  QuoteExpected
MoreStringChars:
  call GetChar
  jc   QuoteExpected
  cmpb  al,#'"'
  jz   EndOfString
  cmpb  al,#LF
  jz   QuoteExpected
  call OutputByte
  jmps MoreStringChars
EndOfString:
  ret
    
;    .asciz str          assemble a zero terminated string

ProcAsciz:
  call ProcAscii
  xorb  al,al
  call OutputByte
  ret

;    .align n            align on multiple of n bytes

ProcAlign:
  call GetATNumber
  mov  bx,ax
  mov  ax,LocationCounter
  xor  dx,dx
  div  bx
  or   dx,dx
  jnz  AlignNeed
  ret

AlignNeed:
  sub  bx,dx
  mov  ax,LocationCounter
  add  ax,bx
  jmp OrgEnd
  


;    .bss                What follows goes to the bss segment

;    .byte n             Assemble one or more bytes

ProcByte:
  call GetATNumber
  orb   ch,ch
  jz   ByteEvaluated
  xor  ax,ax  
ByteEvaluated:
  call CheckForSize
  call OutputByte
  ret

;    .data               What follows goes to the data segment

;    .define sym         Export Sym from the file

;    .errnz n            Force error if n is nonzero

ProcErrnz:
  call GetATNumber
  jc   ATVError
  or   ax,ax
  jnz  AssertError
  ret

AssertError:
  mov  bx,#NonZeroMessage
  call PanicRecover
  
;    .even               Align to an even address

ProcEven:
  mov  ax,LocationCounter
  testb al,#1
  jz   EvenEnd
  inc  ax
  jmps OrgEnd
EvenEnd:
  ret

;    .extern sym         Declare sym external
;    .globl sym          Same as Extern

;    .org adr            Set Address within current segment

ProcOrg:
  call GetATNumber
OrgEnd:
  mov  LocationCounter,ax
  add  ax,#OutputStart
  mov  PresentOutputOffset,ax
  call CheckOutputOverflow
  ret
  
;    .space n            Skip n bytes

ProcSpace:
  call GetATNumber
  mov  cx,ax
  xor ax, ax
MoreSpaces:
  call OutputByte
  loop MoreSpaces
  ret

;    .text               What follows goes to the text segment

;    .long n             Assemble n as a long
;    .short n            Assemble n as a short
;    .word n             Assemble n as a word

ProcWord:
  call GetATNumber
  call OutputWord
  ret

;    .zerow n            Assemble n words of zeros

ATVError:
  mov  bx,#ATVErrorMessage
  call PanicRecover
  
GetATNumber:
  mov  bx,#0
  call GetOperand
  mov  ax,bx
  cmpb  cl,#Disp
  jnz  ATVError
  orb   ch,ch
  jnz  NotEvaled
  stc
  ret
NotEvaled:
  clc
  ret

ProcZeroWords:
  call GetATNumber
  mov  cx,ax
  xor  ax,ax
MoreZeroWords:
  call OutputWord
  loop MoreZeroWords
  ret

ProcZeroBytes:
  call GetATNumber
  mov  cx,ax
  xor  ax,ax
MoreZeroBytess:
  call OutputByte
  loop MoreZeroBytess
  ret

; .include  filename  include the specified filename

ProcInclude:
  call GetTokenFileName
  push SavedStackPointer
  push InputFileHandle
  push InputLineNumber
  push InputBufferReadPtr
  push InputBufferEndPtr
  mov  si,#InputBuffer
  mov  cx,#BufferSize/2
pushloop:
  lodsw
  push ax
  loop pushloop
  push PresentFileNameOffset	;Must be last to be pushed - popped on failure
  mov  di,StringSpace
  mov  PresentFileNameOffset,di
  mov  si,#InputWord
IncludeMoreChars:
  lodsb
  stosb
  orb   al,al
  jnz  IncludeMoreChars
  call CheckStringTableOverflow
  mov  StringSpace,di
  call OpenInputFile
  jc   IncludeFileError
  call Assemble
  call CloseInputFile
  pop  PresentFileNameOffset
  mov  di,#InputBuffer + BufferSize - 2
  mov  cx,#BufferSize/2
  std
poploop:
  pop  ax
  stosw
  loop poploop
  cld
  pop  InputBufferEndPtr
  pop  InputBufferReadPtr
  pop  InputLineNumber
  pop  InputFileHandle
  pop  SavedStackPointer
  ret
  
GetTokenFileName:
  mov  di,#InputWord
  call IgnoreSpaces
MoreFileNameChars:
  call GetChar
  jc   IncludeFileError
  cmpb  al,#LF
  jz   EndOfFileNameCRLF
  cmpb  al,#CR
  jz   EndOfFileNameCRLF
  cmpb  al,#' '
  jz   EndOfFileName
  stosb
  jmps MoreFileNameChars
EndOfFileNameCRLF:
  dec InputBufferReadPtr
EndOfFileName:
  xorb al,al
  stosb
  mov bx, #IncludeFileMessage
  call DisplayOtherMessage
  mov bx, #InputWord
  call DisplayOtherMessage
  call DisplayMessage
  .byte 13
  .byte 10
  .byte 0
  ret

IncludeFileError:
  pop  PresentFileNameOffset	;The only thing destroyed as yet
  mov  bx,#IncludeFileErrorMessage
  call PanicRecover

;.mark

MarkedSymTable:
  .word 0
MarkedStrTable:
  .word 0

ProcMark:
  push ax
  mov ax, LastFilledSymbol
  mov MarkedSymTable, ax
  mov ax, StringSpace
  mov MarkedStrTable, ax
  pop ax
  ret

ProcRelease:
  push ax
  push cx
  push di
  mov ax, MarkedSymTable
  mov LastFilledSymbol, ax
  mov ax, MarkedStrTable
  mov StringSpace, ax

  mov di, MarkedSymTable
ProcReleaseLoop:
  mov ax, #0
  stosw
  cmp di, #SymTabEnd
  jz ProcReleaseLoop

  pop di
  pop cx
  pop ax
  ret
