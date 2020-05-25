# x86 ASM Language

All the assambly codes in this repository are based on **x86_64**.

## General Purpose Registers (GPRs)

1. Accumulator **AX**  
        Used in arithmetic operations
2. Counter **CX**  
        Used in shift/rotate instructions and loops.
3. Data **DX**  
        Used in arithmetic operations and I/O operations.
4. Base **BX**  
        Used as a pointer to data (located in segment register DS, when in segmented mode).
5. Stack Pointer **SP**  
        Pointer to the top of the stack.
6. Stack Base Pointer **BP**  
        Used to point to the base of the stack (stack frame).
7. Source Index **SI**  
        Used as a pointer to a source in stream operations.
8. Destination Index **DI**  
        Used as a pointer to a destination in stream operations.

> In x86_64, there are eight additional GPRs (**R8** ~ **R15**).  


All registers can be accessed in **16-bit** and **32-bit** modes:  
```
   8+8 bits                                                               |___AL___|___AH___|
   16 bits                                                                |_______ AX_______|
   32 bits                                            |_________________EAX_________________|
   64 bits    |_____________________________________RAX_____________________________________|
              High                                                                        Low
```

### Instruction Pointer Register

The **RIP** reg contains the address of the next instruction to be executed.
> RIP can only be read through the stack after a `call` instruction.

### Write/Read Register

In [Intel® 64 and IA-32 Architectures Software Developer's Manual](https://www.intel.com.tw/content/www/tw/zh/architecture-and-technology/64-ia-32-architectures-software-developer-vol-1-manual.html), it said

> * 64-bit operands generate a 64-bit result in the destination general-purpose register.
> * 32-bit operands generate a 32-bit result, zero-extended to a 64-bit result in the destination general-purpose register.
> * 8-bit and 16-bit operands generate an 8-bit or 16-bit result. The upper 56 bits or 48 bits (respectively) of the destination general-purpose register are not be modified by the operation. If the result of an 8-bit or 16-bit operation is intended for 64-bit address calculation, explicitly sign-extend the register to the full 64-bits.

Write the partial register (i.e. `EAX`) will zero upper 32 bits of `RAX` register.

```asm
    ; initialize
    mov RBX, 0xffffffffffffffff ; rbx = 0xffffffffffffffff
    mov RAX, 0                  ; rax = 0x0000000000000000

    mov EBX, EAX                ; rbx = 0x0000000000000000
```

But in the 32-bit mode will not have the same result in 64-bit mode.

```asm
    ; initialize
    mov RBX, 0xffffffffffffffff ; rbx = 0xffffffffffffffff
    mov RAX, 0                  ; rax = 0x0000000000000000

    mov BX,  AX                 ; rbx = 0xffffffffffff0000
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
**[PEDA](https://github.com/longld/peda)** (Python Exploit Development Assistance for GDB)

## References

Assembly Language for x86 Processors, 8/e (2019)  
[Tutorialspoint](https://www.tutorialspoint.com/assembly_programming/)
[Intel 64 and IA-32 Architectures Software Developer's Manual (Volume 1)](https://www.intel.com.tw/content/www/tw/zh/architecture-and-technology/64-ia-32-architectures-software-developer-vol-1-manual.html)