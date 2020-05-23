; dispbin:
;     given a number in AX, store the corresponding bit string in str1.
;     for example, if AX = 0x1234, the result should be:
;     str1 = 0001001000111000
; ======
;       str1 @ 0x600000-600016
; ======

    mov ecx, 0
LOOP:
    shl ax, 1       ; the leftest bit will be pushed into CF
    jc L1           ; jump if CF==1
    mov BYTE PTR [0x600000 + ecx], 48       ; ascii code 48 represents '0'
    jmp L3
L1:
    mov BYTE PTR [0x600000 + ecx], 49       ; ascii code 49 represents '1'
L3:
    inc ecx
    cmp ecx, 16
    jl LOOP