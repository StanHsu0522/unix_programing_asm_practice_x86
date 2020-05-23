; tolower: convert the single character in val1 to uppercase and store in val2
; ======
;       val1 @ 0x600000-600001
;       val2 @ 0x600001-600002
; ======

; According to the ASCII code,
; 'a' (lowercase) is 97 in dec, and
; 'A' (uppercase) is 65 in dec.

mov al, [0x600000]
sub al, 32
mov [0x600001], al