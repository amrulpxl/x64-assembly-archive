; Program: Fungsi (NASM, Windows x64)
default rel

section .data
    pesan db "hasil penjumlahan %d + %d adalah: %d", 0Ah, 0
    a dq 7
    b dq 8

section .text
    extern printf
    global main

main:
    sub rsp, 40
    mov rdx, [a]
    mov r8, [b]
    call tambah
    mov rcx, pesan
    mov rdx, [a]
    mov r8, [b]
    mov r9, rax
    call printf
    add rsp, 40
    ret

tambah:
    mov rax, rdx
    add rax, r8
    ret
