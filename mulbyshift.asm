; mulbyshift: multiply val1 by 26 and store the result in val2
; ======
;       val1 @ 0x600000-600004
;       val2 @ 0x600004-600008
; ======

; val = val>>4 + val>>3 + val>>1
; shl ebx,3 + shr ebx,2 = shl ebx,1

mov eax, [0x600000]
mov ebx, [0x600000]
shl eax, 4
shl ebx, 3
add eax, ebx
shr ebx, 2
add eax, ebx
mov [0x600004], eax