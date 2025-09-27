; Program: Variabel (NASM, Windows x64)
default rel

section .data
    pesan_x db "nilai variabel x adalah: %d", 0Ah, 0
    pesan_y db "nilai variabel y adalah: %d", 0Ah, 0
    x dq 10
    y dq 25

section .text
    extern printf
    global main

main:
    sub rsp, 40
    mov rcx, pesan_x
    mov rdx, [x]
    call printf

    mov rcx, pesan_y
    mov rdx, [y]
    call printf
    add rsp, 40
    ret
