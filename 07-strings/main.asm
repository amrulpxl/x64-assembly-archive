; Program: String (NASM, Windows x64)
default rel

section .data
    nama db "Amrul", 0
    pesan_nama db "nama: %s", 0Ah, 0
    pesan_panjang db "panjang nama: %d", 0Ah, 0

section .bss
    len resq 1

section .text
    extern printf
    global main

main:
    sub rsp, 40
    mov rcx, pesan_nama
    lea rdx, [nama]
    call printf

    lea rsi, [nama]
    xor rax, rax
hitung_panjang:
    mov bl, [rsi]
    cmp bl, 0
    je selesai_panjang
    inc rax
    inc rsi
    jmp hitung_panjang
selesai_panjang:
    mov [len], rax
    mov rcx, pesan_panjang
    mov rdx, rax
    call printf
    add rsp, 40
    ret
