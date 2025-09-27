; Program: Hello World (NASM, Windows x64)
default rel

section .data
    pesan db "Halo, dunia!", 0Ah, 0
    panjang_pesan equ $ - pesan

section .text
    extern printf
    global main

main:
    sub rsp, 40
    lea rcx, [pesan]
    call printf
    add rsp, 40
    ret
