; loop15:
;     str1 is a string contains 15 lowercase and uppercase alphbets.
;     implement a loop to convert all alplabets to lowercase,
;     and store the result in str2.
; ======
;       str1 @ 0x600000-600010
;       str2 @ 0x600010-600020
; ======

; for str1[0]:str1[14]
;     if uppercase
;         convert to lowercase

    mov ecx, 0
LOOP:
    mov al, [0x600000 + ecx]
    cmp al, 97
    jge L1
    add al, 32
L1:
    mov [0x600010 + ecx], al
    
    inc ecx
    cmp ecx, 15
    jl LOOP