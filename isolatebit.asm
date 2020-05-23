; isolatebit:
;     get the value bit-11 ~ bit-5 in AX and store the result in val1
;     (zero-based bit index)
; ======
;       val1 @ 0x600000-600001
;       val2 @ 0x600001-600002
; ======

; +---------------------+
; | 15   11   7    3    |
; +---------------------+
; | 0000 1111 1110 0000 |
; +---------------------+
; 
; push leftmost 4 bits out
; +---------------------+
; | 1111 1110 0000 **** |
; +---------------------+

; and then push rightmost 5 bits out
; +---------------------+
; | **** **** *111 1111 |
; |           ^^^^ ^^^^ |
; +---------------------+
; store lower two bytes only

shl ax, 4
shr ax, 9
mov [0x600000], al