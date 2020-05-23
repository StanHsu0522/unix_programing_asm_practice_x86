# x86 ASM Language

### Reference

Assembly Language for x86 Processors, 8/e (2019)

[Tutorialspoint](https://www.tutorialspoint.com/assembly_programming/)


### Architecture

All the assambly codes in this repository are based on **x86_64**.



## General Purpose Registers (GPRs)

1. Accumulator register **AX**  
    Used in arithmetic operations
2. Counter register **CX**  
    Used in shift/rotate instructions and loops.
3. Data register **DX**  
    Used in arithmetic operations and I/O operations.
4. Base register **BX**  
    Used as a pointer to data (located in segment register DS, when in segmented mode).
5. Stack Pointer register **SP**  
    Pointer to the top of the stack.
6. Stack Base Pointer register **BP**  
    Used to point to the base of the stack.
7. Source Index register **SI**  
    Used as a pointer to a source in stream operations.
8. Destination Index register **DI**  
    Used as a pointer to a destination in stream operations.


In 64-bit, there are 8 more GPRs (i.e. R8 ~ R15).

All registers can be accessed in 8-bit, 16-bit, 32-bit and 64-bit modes.


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