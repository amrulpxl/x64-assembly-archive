; Program: Array (NASM, Windows x64)
default rel

section .data
    pesan db "%d", 0Ah, 0
    arr dq 10, 20, 30, 40, 50
    n dq 5

section .bss
    i resq 1

section .text
    extern printf
    global main

main:
    sub rsp, 40
    mov qword [rel i], 0
loop_awal:
    mov rax, [rel i]
    cmp rax, [rel n]
    jge loop_selesai
    mov rcx, pesan
    lea rbx, [rel arr]
    mov rdx, [rbx + rax*8]
    call printf
    inc qword [rel i]
    jmp loop_awal
loop_selesai:
    add rsp, 40
    ret
