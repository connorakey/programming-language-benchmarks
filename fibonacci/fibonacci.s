# x86-64 Assembly (AT&T syntax)
# fibonacci(n) - calculates nth fibonacci number
# Input: %rdi (n)
# Output: %rax (result)

.global fibonacci
fibonacci:
    # Initialize a = 0, b = 1
    mov $0, %rax    # a
    mov $1, %rcx    # b
    mov $0, %rdx    # i
    
.loop:
    # Check if i >= n
    cmp %rdi, %rdx
    jge .done
    
    # temp = a, a = b, b += temp
    mov %rax, %r8   # temp = a
    mov %rcx, %rax  # a = b
    add %r8, %rcx   # b += temp
    
    # i++
    inc %rdx
    jmp .loop
    
.done:
    ret

.global main
main:
    mov $100000, %rdi
    call fibonacci
    
    # Print the result using printf
    mov %rax, %rsi          # result as second argument
    lea .format(%rip), %rdi # format string as first argument
    xor %rax, %rax          # no vector registers used
    call printf
    
    # Flush stdout
    mov $0, %rdi            # stdout file descriptor
    call fflush
    ret

.section .rodata
.format:
    .string "%ld\n"
