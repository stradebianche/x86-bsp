;
; Simple Master Boot Record file
;
; References:
;    [1] https://stackoverflow.com/questions/10168743/which-variable-size-to-use-db-dw-dd-with-x86-assembly
;    [2] https://www.cs.virginia.edu/~evans/cs216/guides/x86.html
;
[org 0x7c00]

; Simple print
mov ah, 0x0e
mov al, 'H'
int 0x10
mov al, 'i'
int 0x10
mov al, '!'
int 0x10
mov al, 0x0d
int 0x10
mov al, 0x0a
int 0x10

; Print with addressing, just testing
;mov ah, 0x0e

;mov al, str_loading
;int 0x10

;mov al, [str_loading_os]
;int 0x10

;mov bx, str_loading
;add bx, 0x7c00
;mov al, [bx]
;int 0x10

mov bx, str_loading_os
call println

; Infinite loop
loop:
    jmp loop

; void println(char * str);
println:
    mov al, [bx]
    cmp al, 0
    je println_ret
    mov ah, 0x0e
    int 0x10
    add bx, 1
    jmp println
  println_ret:
    mov al, 0x0d
    int 0x10
    mov al, 0x0a
    int 0x10
    ret

; data
str_loading_os:
    db 'Loading OS...',0

; Fill with 510 zeros minus the size of the previous code:
;  NASM supports two special tokens in expressions, allowing calculations to 
;  involve the current assembly position: the $ and $$ tokens. $ evaluates to the
;  assembly position at the beginning of the line containing the expression; so 
;  you can code an infinite loop using JMP $. $$ evaluates to the beginning of 
;  the current section; so you can tell how far into the section you are by using
;  ($−$$).
;  DB - Declare a byte
;  times - ?
times 510-($-$$) db 0

; Magic number, DW - Declare a 2-byte value (with no label)
dw 0xaa55
