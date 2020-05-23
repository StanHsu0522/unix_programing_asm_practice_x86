; bubble: bubble sort for 10 integers
; ======
;       a[0] @ 0x600000-600004
;       a[1] @ 0x600004-600008
;       a[2] @ 0x600008-60000c
;       a[3] @ 0x60000c-600010
;       a[4] @ 0x600010-600014
;       a[5] @ 0x600014-600018
;       a[6] @ 0x600018-60001c
;       a[7] @ 0x60001c-600020
;       a[8] @ 0x600020-600024
;       a[9] @ 0x600024-600028
; ======

    mov ecx, 9
OUTTER:
    mov edx, 0
INNER:
    mov eax, [0x600000 + edx*4]
    mov ebx, [0x600000 + (edx + 1)*4]

    cmp eax, ebx
    jle L1
    
    mov [0x600000 + edx*4], ebx
    mov [0x600000 + (edx + 1)*4], eax
L1:
    inc edx
    cmp edx, ecx
    jl INNER

    dec ecx
    cmp ecx, 0
    jge OUTTER