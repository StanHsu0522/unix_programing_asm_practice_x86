; recur: implement a recursive function

;    r(n) = 0, if n <= 0
;         = 1, if n == 1
;         = 2*r(n-1) + 3*r(n-2), otherwise
   
;    please call r(25) and store the result in RAX
; ======
; ======

; [In the function]
; push rbp
; mov rbp, rsp
; sub rsp, <size you need>
; 
; /＊
; implement of the function
; */
; 
; mov rsp, rbp
; pop rbp
; ret

main:
    mov rcx, 25     ; set parameter
    push rcx        ; push parameter
    call r          ; call r(25)
    pop rcx

    jmp exit

r:
    push rbp        ; reserve caller's RBP (i.e. stack frame pointer)
    mov rbp, rsp
    sub rsp, 0x10       ; reserve 16 bytes space for local variables
                        ; we'll need to store the original parameter and the result of first call

    mov r8, [rbp + 0x10]       ; get parameter 'n'
    mov [rbp - 0x8], r8        ; store parameter 'n' as local variable

    cmp r8, 0
    jle L1
    cmp r8, 1
    je  L2

    sub r8, 1       ; n = n - 1
    push r8         ; push parameter
    call r          ; r(n-1)

    mov rbx, 2
    mul rbx
    mov [rbp - 0x10], rax       ; reserve the result of 2 * r(n-1)

    mov r8, [rbp - 0x8]
    sub r8, 2       ; n = n - 2
    push r8         ; push parameter
    call r          ; r(n-2)

    mov rbx, 3
    mul rbx

    add rax, [rbp - 0x10]       ; return 2*r(n-1) + 3*r(n-2)

    mov rsp, rbp
    pop rbp
    ret

L1:
    mov eax, 0      ; return 0
    
    mov rsp, rbp
    pop rbp
    ret
L2:
    mov eax, 1      ; return 1
    
    mov rsp, rbp
    pop rbp
    ret

exit: