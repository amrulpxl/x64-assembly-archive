; Program: Aritmatika (NASM, Windows x64)
default rel

section .data
    pesan_tambah db "penjumlahan: %d", 0Ah, 0
    pesan_kurang db "pengurangan: %d", 0Ah, 0
    pesan_kali db "perkalian: %d", 0Ah, 0
    pesan_bagi db "pembagian: %d", 0Ah, 0
    a dq 10
    b dq 5

section .text
    extern printf
    global main

main:
    sub rsp, 40
    mov rax, [a]
    add rax, [b]
    mov rcx, pesan_tambah
    mov rdx, rax
    call printf

    mov rax, [a]
    sub rax, [b]
    mov rcx, pesan_kurang
    mov rdx, rax
    call printf

    mov rax, [a]
    imul rax, [b]
    mov rcx, pesan_kali
    mov rdx, rax
    call printf

    mov rax, [a]
    cqo
    idiv qword [b]
    mov rcx, pesan_bagi
    mov rdx, rax
    call printf

    add rsp, 40
    ret
