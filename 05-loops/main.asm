; Program: Loop (NASM, Windows x64)
default rel

section .data
    pesan db "%d", 0Ah, 0

section .bss
    i resq 1

section .text
    extern printf
    global main

main:
    sub rsp, 40
    mov qword [i], 1
loop_awal:
    mov rax, [i]
    cmp rax, 6
    jge loop_selesai
    mov rcx, pesan
    mov rdx, rax
    call printf
    inc qword [i]
    jmp loop_awal
loop_selesai:
    add rsp, 40
    ret
