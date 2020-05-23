; ul+lu: convert the alphabet in CH from upper to lower or from lower to upper
; ======
; ======

; According to the ASCII code,
; 'a' (lowercase) is 97 in dec, and
; 'A' (uppercase) is 65 in dec.
;
; convert ch to uppercase
; if not out of alphabet scope (i.e. 65~122 dec)
;   done
; else
;   convert back to lowercase (i.e. ch = ch + 32 + 32)

    sub ch, 32
    cmp ch, 65
    jnl EXIT
L2:
    add ch, 32 * 2
EXIT: