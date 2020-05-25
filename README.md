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
  High                                                                        Low
                                                              |___AL___|___AH___|   8+8 bits
                                                              |_______ AX_______|   16 bits 
                                          |_________________EAX_________________|   32 bits 
  |_____________________________________RAX_____________________________________|   64 bits 
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
        1. Carry flag `CF` (bit 0): Set if an arithmetic operation generates a carry or a borrow out of the most-significant bit of the result; cleared otherwise.  
        2. Parity flag `PF` (bit 2): Set if the least-significant byte of the result contains an even number of 1 bits; cleared otherwise.  
        3. Auxiliary Carry flag `AF` (bit 4)  
        4. Zero flag `ZF` (bit 6): Set if the result is zero; cleared otherwise.  
        5. Sign flag `SF` (bit 7): Set equal to the most-significant bit of the result, which is the sign bit of a signed integer. (0 indicates a positive value and 1 indicates a negative value.)  
        6. Overflow flag `OF` (bit 11): Set if the integer result is too large a positive number or too small a negative number to fit in the destination operand; cleared otherwise.  
* Control Flags  

* System Flags  

> In 64-bit mode, `EFLAGS` is extended to 64 bits and called `RFLAGS`. 
> The upper 32 bits of RFLAGS register is reserved. The lower 32 bits of RFLAGS is the same as EFLAGS.

### Instruction Pointer Register

The `EIP` register contains the offset in the current code segment for the next instruction to be executed.

> The `EIP` register cannot be accessed directly by software.
> `EIP` can only be read through the stack after a `call` instruction.
> In 64-bit mode, `RIP` is the instruction pointer.





## Assembly Instructions

### Data Movement

```asm
    mov dst, src
```

### Simple Arithmetic



### Shift & Rotate



### Mutiplication & Division







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