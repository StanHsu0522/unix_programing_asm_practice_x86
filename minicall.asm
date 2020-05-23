; minicall: implement a minimal function call in the emulator
; ===== THE CODE
;     call   a
;     jmp    exit

; a:  ; function a - read ret-addr in rax
;     pop    rax
;     push   rax
;     ret
; exit:
; ======
; ======

main:
    call   a
    jmp    exit

a:  ; function a - read ret-addr in rax
    push rbp
    mov rbp, rsp
    

    mov rsp, rbp
    pop rbp

    pop rax
    push rax

    ret
exit: