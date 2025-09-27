; Program: File I/O (NASM, Windows x64)
default rel

section .data
    format db "%s", 0
    nama_file db "hitam.txt", 0
    pesan_tulis db "file berhasil ditulis.", 0Ah, 0
    pesan_baca db "isi file: %s", 0Ah, 0
    isi db "halo dari orang hitam!", 0

section .bss
    buffer resb 64

section .text
    extern printf
    extern fopen
    extern fprintf
    extern fclose
    extern fgets
    global main

main:
    sub rsp, 40
    lea rcx, [rel nama_file]      ; RCX = nama file
    lea rdx, [rel mode_write]     ; RDX = mode tulis
    call fopen                    ; FILE * di RAX
    mov rbx, rax                  ; simpan FILE *
    test rbx, rbx
    jz gagal
    mov rcx, rbx                  ; RCX = FILE *
    lea rdx, [rel format]         ; RDX = format "%s"
    lea r8, [rel isi]             ; R8 = string
    call fprintf
    mov rcx, rbx                  ; RCX = FILE *
    call fclose
    mov rcx, pesan_tulis
    call printf

    lea rcx, [rel nama_file]      ; RCX = nama file
    lea rdx, [rel mode_read]      ; RDX = mode baca
    call fopen                    ; FILE * di RAX
    mov rbx, rax
    test rbx, rbx
    jz gagal
    lea rcx, [rel buffer]         ; RCX = buffer
    mov rdx, 64                   ; RDX = size
    mov r8, rbx                   ; R8 = FILE *
    call fgets
    mov rcx, pesan_baca           ; RCX = format
    lea rdx, [rel buffer]         ; RDX = buffer
    call printf
    mov rcx, rbx                  ; RCX = FILE *
    call fclose
    jmp selesai

mode_write db "w", 0
mode_read db "r", 0
gagal:
    mov rcx, pesan_tulis
    call printf
selesai:
    add rsp, 40
    ret
