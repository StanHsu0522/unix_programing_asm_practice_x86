# x86 ASM Language

### Reference

Assembly Language for x86 Processors, 8/e (2019)  
[Tutorialspoint](https://www.tutorialspoint.com/assembly_programming/)


### Architecture

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

    > In x86_64, there are eight more GPRs (**R8** ~ **R15**).  


All registers can be accessed in **16-bit** and **32-bit** modes:  
```
   8+8 bits   |___AL___|___AH___|
   16 bits    |_______AX________|
   32 bits    |_________________EAX_________________|
   64 bits    |_____________________________________RAX_____________________________________|
```

### Instruction Pointer Register

The **RIP** reg contains the address of the next instruction to be executed.
> RIP can only be read through the stack after a `call` instruction.

### Write/Read Register

Write to AX will overwrite all the register value.
In the other hand, we can only read the lower part of register.
```asm
    mov  RAX, 0xffffffff    ; RAX = 0xffffffff
    mov  EBX, EAX           ; RBX = 0x0000ffff
    mov  AX,  0x1           ; RAX = 0x00000001
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