; posneg: test if registers are positive or negative.
;     if ( eax >= 0 ) { var1 = 1 } else { var1 = -1 }
;     if ( ebx >= 0 ) { var2 = 1 } else { var2 = -1 }
;     if ( ecx >= 0 ) { var3 = 1 } else { var3 = -1 }
;     if ( edx >= 0 ) { var4 = 1 } else { var4 = -1 } 
; ======
;       var1 @ 0x600000-600004
;       var2 @ 0x600004-600008
;       var3 @ 0x600008-60000c
;       var4 @ 0x60000c-600010
; ======

    mov DWORD PTR [0x600000], -1
    mov DWORD PTR [0x600004], -1
    mov DWORD PTR [0x600008], -1
    mov DWORD PTR [0x60000c], -1

    cmp eax, 0
    jl L1
    mov DWORD PTR [0x600000], 1
L1:
    cmp ebx, 0
    jl L2
    mov DWORD PTR [0x600004], 1
L2:
    cmp ecx, 0
    jl L3
    mov DWORD PTR [0x600008], 1
L3:
    cmp edx, 0
    jl L4
    mov DWORD PTR [0x60000c], 1
L4: