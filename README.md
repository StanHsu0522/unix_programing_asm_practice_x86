# x86 ASM Language

All the assambly codes in this repository are based on **x86_64**.



## Register Group

### General-Purpose Registers (GPRs)

1. Accumulator `AX`  
        Used in arithmetic operations
2. Counter `CX`  
        Used in shift/rotate instructions and loops.
3. Data `DX`  
        Used in arithmetic operations and I/O operations.
4. Base `BX`  
        Used as a pointer to data (located in segment register DS, when in segmented mode).
5. Stack Pointer `SP`  
        Pointer to the top of the stack.
6. Stack Base Pointer `BP`  
        Used to point to the base of the stack (stack frame).
7. Source Index `SI`  
        Used as a pointer to a source in stream operations.
8. Destination Index `DI`  
        Used as a pointer to a destination in stream operations.

> In x86_64, there are eight additional GPRs (`R8D`-`R15D`/`R8`-`R15`).  


In 64-bit mode, all these registers can be accessed at the **8-bit (byte)**, **16-bit (word)**, **32-bit (dword)** and **64-bit (qword)** level:  
```
                                                              |___AL___|___AH___|   8+8 bits
                                                              |_______ AX_______|   16 bits 
                                          |_________________EAX_________________|   32 bits 
  |_____________________________________RAX_____________________________________|   64 bits 
  (High)                                                                    (Low)
```

#### Access Register

In [Intel® Developer's Manual](https://www.intel.com.tw/content/www/tw/zh/architecture-and-technology/64-ia-32-architectures-software-developer-vol-1-manual.html), it said:

> * 64-bit operands generate a 64-bit result in the destination general-purpose register.
> * 32-bit operands generate a 32-bit result, zero-extended to a 64-bit result in the destination general-purpose register.
> * 8-bit and 16-bit operands generate an 8-bit or 16-bit result. The upper 56 bits or 48 bits (respectively) of the destination general-purpose register are not be modified by the operation. If the result of an 8-bit or 16-bit operation is intended for 64-bit address calculation, explicitly sign-extend the register to the full 64-bits.

Write the partial register (i.e. `EAX`) will **zero** upper 32 bits of `RAX` register:

```asm
    ; initialize
    mov RBX, 0xffffffffffffffff ; rbx = 0xffffffffffffffff
    mov RAX, 0                  ; rax = 0x0000000000000000

    mov EBX, EAX                ; rbx = 0x0000000000000000
```

But, in 32-bit mode will not have the same result in 64-bit mode:

```asm
    ; initialize
    mov RBX, 0xffffffffffffffff ; rbx = 0xffffffffffffffff
    mov RAX, 0                  ; rax = 0x0000000000000000

    mov BX,  AX                 ; rbx = 0xffffffffffff0000
```

```asm
    mov r8, 0xffffffffffffffff
    mov eax, r8d
```

### Segment Registers

1. Code Segment `CS`  
        It stores starting address of the code segment.
2. Data Segment `DS`  
        It stores the starting address of the data segment.
3. Stack Segment `SS`  
        It contains data and return addresses of subroutines. It stores the starting address of the stack.

### EFLAGS Register

The 32-bit EFLAGS register contains a group of status flags, a control flag, and a group of system flags.  

* Status Flags  
    1. Carry flag `CF` (bit 0)  
        Set if an arithmetic operation generates a carry or a borrow out of the most-significant bit of the result; cleared otherwise.  
    2. Parity flag `PF` (bit 2)  
        Set if the least-significant byte of the result contains an even number of 1 bits; cleared otherwise.  
    3. Auxiliary Carry flag `AF` (bit 4)  
    4. Zero flag `ZF` (bit 6)  
        Set if the result is zero; cleared otherwise.  
    5. Sign flag `SF` (bit 7)  
        Set equal to the most-significant bit of the result, which is the sign bit of a signed integer. (0 indicates a positive value and 1 indicates a negative value.)  
    6. Overflow flag `OF` (bit 11)  
        Set if the integer result is **too large** a positive number or **too small** a negative number to fit in the destination operand; cleared otherwise.  
* Control Flags  
    ...   
    (omited)  
    ...  

* System Flags  
    ...  
    (omited)  
    ...  

> In 64-bit mode, `EFLAGS` is extended to 64 bits and called `RFLAGS`.  
> The upper 32 bits of `RFLAGS` register is reserved. The lower 32 bits of `RFLAGS` is the same as `EFLAGS`.

### Instruction Pointer Register

The `EIP` register contains the offset in the current code segment for the next instruction to be executed.

> The `EIP` register cannot be accessed directly by software.
> `EIP` can only be read through the stack after a `call` instruction.
> In 64-bit mode, `RIP` is the instruction pointer.





## General-Purpose Instructions

### Data Transfer Instructions

```asm
    MOV    dst, src    ; move data from src to dst
    XCHG   dst, src    ; exchange
    MOVZX  dst, src    ; move and sign extend
    MOVSX  dst, src    ; move and zero extend
```

```asm
    MOV eax, [ebx + ecx*4 + 4]  ; can be *1, *2, *4, *8
    MOV eax, [0x600000]         ; This will dereference with 0x600000 as a memory address
                                ; and mov from 0x600000-0x600004 since eax is 4-byte wide.
```

### Binary Arithmetic Instructions

```asm
    ADD   dst, src    ; add
    SUB   dst, src    ; substract
    MUL   dst, src    ; unsigned multiply
    IMUL  dst, src    ; signed multiply
    DIV   dst, src    ; unsigned divide
    IDIV  dst, src    ; signed divide
    INC   dst, src    ; increment
    DEC   dst, src    ; decrement
    NEG   dst         ; NOT dst
                      ; INC dst

    CMP   dst, src    ; compare
```

```asm
    INC  [0x600000]             ; This is invalid.
    INC  DWORD PTR [0x600000]   ; PTR is required on MASM/gas, 
                                ; but cannot be used on yasm/nasm.
```

### Logical Instructions

```asm
    AND  dst, src
    OR   dst, src
    XOR  dst, src
    NOT  dst, src
```

```asm
    XOR  src, src       ; clear the content
    AND  ax, 0x1110     ; isolate 15-4 bits (zero based)
```

### Shift & Rotate Instructions

```asm
    SHR  dst, imm    ; shift logical right
    SHL  dst, imm
    SAR  dst, imm    ; shift arithmetic right
    SAL  dst, imm

    ROR  dst, imm    ; rotate right
    ROL  dst, imm
    RCR  dst, imm    ; rotate through carry right
    RCL  dst, imm 
```

```asm
    SHL eax, 1      ; eax = eax * 2
    SHL eax, 2      ; eax = eax * 4

    SAL dst, imm    ; SHL dst, imm



            (CF)     3  2  1  0   
            +--+  +--+--+--+--+   
    SHL     |  |  |  |  |  |  |  0
            +--+  +--+--+--+--+
             ⇐ ⇐ ⇐ ⇐ ⇐ ⇐ ⇐ ⇐ ⇐ ⇐ ⇐


                 3  2  1  0  (CF)
              +--+--+--+--+  +--+
    SHR     0 |  |  |  |  |  |  |
              +--+--+--+--+  +--+
            ⇒ ⇒ ⇒ ⇒ ⇒ ⇒ ⇒ ⇒ ⇒ ⇒  


                  3  2  1  0  (CF)
               +--+--+--+--+  +--+
    SAR     ⇑⇒⇒|  |  |  |  |  |  |
            ⇑  +--+--+--+--+  +--+
            ⇑   ⇓⇒ ⇒ ⇒ ⇒ ⇒ ⇒ ⇒ ⇒  
            ⇐⇐⇐⇐⇐                 
```

### Mutiplication & Division Instructions

```asm
    ; Multiplication
    MOV eax, 2
    MOV ebx, 3
    MUL ebx         ; edx:eax = eax * ebx
                    ; edx = 0x0, eax = 0x6

    ; Division      ; dividend = divisor * quotient + remainder
    DIV ebx         ; edx:eax = ebx * eax' + edx'
                    ; product in eax'
                    ; remainder in edx'
                    ; edx = 0x0, eax = 0x2
```

```asm
    ; Signed
    MOV eax, -2
    MOV ebx, 3
    IMUL ebx        ; rax = 0xfffffffa, edx = 0xffffffff
    IDIV ebx        ; rax = 0xfffffffe, edx = 0x0
```

## Procedure Call

### Stack

* `RSP`/`ESP` points to the top of the stack
* Stack grows from higher addresses to lower addresses

```asm
    PUSH rax        ; esp = esp - sizeof(rax)
                    ; [esp] = rax
```

```asm
    POP rax         ; rax = [esp]
                    ; esp = esp + sizeof(rax)
```

### Function Calls

```asm
    main:
        CALL myFunc
        ...
    myFunc:
        MOV eax, ebx
        RET             ; pop rip
```

> CALL 
> * Push return address into the stack  
> * Set RIP to be the entry point of the target function  
> * Parameters can be passed by using registers or the stack

> RET  
> * Pop return address to rip  
> * Cannot `POP rip` yourself because destination cannot be `rip`  

### Calling Convention

Calling convention is language/architecture dependent

* Where is the return address?
* How parameters are passes? (before making a call)
* How parameters are cleared? (after returning from a call)
* How return value are received?

> Intel x86  
> 1. cdecl: C/C++  
> Caller pushes parameters to the stack, ***from right to left***  
> ***Caller*** is responsible to remove parameters from the stack  
> 2. stdcall: Windows API  
> Caller pushes parameters to the stack, ***from right to left***  
> ***Callee*** is responsible  to remove parameters from the stack  
>  
>       Return value is stored in `EAX`

> Intel x86_64  
> Registers can be used to pass function call parameters  
> 1. System V AMD64  
> The first six are passed by using registers `RDI`, `RSI`, `RDX`, `RCX`, `R8`, `R9`  
> The rest are pushed onto stack from right to left  
> 2. Microsoft x64  
> The first four are passed by using registers `RCX`, `RDX`, `R8`, `R9`  
> The rest are pushed onto stack from right to left  
>  
>       Return value is stored in `RAX`  
>       Stack parameters are always removed by the caller  

### Stack Frame

The stack frame, also known as activation record is the collection of all data on the stack associated with one subprogram call.  

The stack frame generally includes the following components:
* The return address
* Parameters passed on the stack
* Local variables
* Saved copies of any registers modified by the subprogram that need to be restored

#### Frame Pointer

* `RBP` is the ***frame pointer*** of the current function call  
* It's the baseline to access ***parameters*** and ***local variables***
* * For x86, all the parameters are stored in the stack
* * For x86_64, parameters after the seventh are stored in the stack (SysV) 

```c
    int a(int x, int y, int z) {
        return x+y+z;
    }

    int main() {
        return a(1, 2, 3);
    }
```

```asm
    ; example assambly for above c language code

    main:
        mov     rax, 3
        push    rax
        mov     rax, 2
        push    rax
        mov     rax, 1
        push    rax
        
        call    a               ; when return from a(), we can get return 
                                ; value from rax
        add     esp, 0xc        ; caller removes parameters
        jmp     exit
    a:
        push    rbp
        mov     rbp, rsp

        mov     rax, [rbp + 0x10]       ; parameter x
        add     rax, [rbp + 0x18]       ; parameter y
        add     rax, [rbp + 0x20]       ; parameter z

        leave       ; mov rsp, rbp
                    ; pop rbp
        ret

    exit:
```

```asm
    func:
        PUSH rbp        ; reserve caller's stack frame pointer
        MOV rbp, rsp    ; set this function's stack frame pointer
        ; ...
        ; (function implementation)
        ; ...
        MOV rsp, rbp    ; clean up current stack frame
        POP rbp         ; restore caller's stack frame pointer
        RET
```

## Tools

Additional compiler (gcc) options:
* **-m32**: output Intel x86 object codes
* **-masm=intel**: Use Intel syntax instead of AT&T syntax
* **-fno-stack-protector**: disable stack protector

Assambler (yasm):  
```bash
    $ yasm -f elf32     // Output x86 object codes
    $ yasm -f elf64     // Output x86_64 object codes
```

Linker (ld):  
```bash
    $ ld -m elf_i386        // Link with x86 object codes
    $ ld -m elf_x86_64      // Link with x86_64 object codes
```

Debugger (gdb-peda):  
[PEDA](https://github.com/longld/peda) (Python Exploit Development Assistance for GDB)





## References

Assembly Language for x86 Processors, 8/e (2019)  
[Tutorialspoint](https://www.tutorialspoint.com/assembly_programming/)  
[Intel 64 and IA-32 Architectures Software Developer's Manual (Volume 1)](https://www.intel.com.tw/content/www/tw/zh/architecture-and-technology/64-ia-32-architectures-software-developer-vol-1-manual.html)  