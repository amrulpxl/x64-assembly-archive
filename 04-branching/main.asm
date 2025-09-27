; Program: Branching (NASM, Windows x64)
default rel

section .data
    pesan_gt db "nilai x lebih besar dari y.", 0Ah, 0
    pesan_lt db "nilai x lebih kecil dari y.", 0Ah, 0
    pesan_eq db "nilai x sama dengan y.", 0Ah, 0
    x dq 20
    y dq 10

section .text
    extern printf
    global main

main:
    sub rsp, 40
    mov rax, [x]
    cmp rax, [y]
    jg lebih_besar
    jl lebih_kecil
    je sama

lebih_besar:
    mov rcx, pesan_gt
    call printf
    jmp selesai
lebih_kecil:
    mov rcx, pesan_lt
    call printf
    jmp selesai
sama:
    mov rcx, pesan_eq
    call printf
selesai:
    add rsp, 40
    ret
