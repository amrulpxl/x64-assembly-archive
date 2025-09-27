; Program: Proyek Akhir CRUD/Menu Interaktif (NASM, Windows x64)
default rel

section .data
    menu db "Menu:",0Ah,"1. Tambah Data",0Ah,"2. Lihat Data",0Ah,"3. Hapus Data",0Ah,"4. Keluar",0Ah,"Pilihan Anda: ",0
    pesan_tambah db "Masukkan nama: ",0
    pesan_lihat db "Data saat ini:",0Ah,0
    pesan_hapus db "Data berhasil dihapus.",0Ah,0
    pesan_keluar db "Terima kasih telah menggunakan program.",0Ah,0
    pesan_salah db "Pilihan tidak valid.",0Ah,0
    format_nama db "%s",0Ah,0
    format_input db "%s",0
    max_data dq 10

section .bss
    data_nama resb 10*32
    jumlah_data resq 1
    input resb 32
    pilihan resq 1

section .text
    extern printf
    extern scanf
    extern strcmp
    global main

main:
    sub rsp, 40
menu_ulang:
    mov rcx, menu
    call printf
    mov rcx, 0
    mov rdx, [rel input]
    mov rcx, 32
    xor rax, rax
    lea rdi, [rel input]
    mov rcx, 32
    rep stosb
    lea rcx, [rel format_input]
    lea rdx, [rel input]
    call scanf
    mov al, [rel input]
    sub al, '0'
    cmp al, 1
    je tambah_data
    cmp al, 2
    je lihat_data
    cmp al, 3
    je hapus_data
    cmp al, 4
    je keluar
    mov rcx, pesan_salah
    call printf
    jmp menu_ulang

tambah_data:
    mov rax, [rel jumlah_data]
    cmp rax, [rel max_data]
    jge menu_ulang
    mov rcx, pesan_tambah
    call printf
    lea rcx, [rel format_input]
    lea rdx, [rel input]
    call scanf
    mov rbx, [rel jumlah_data]
    imul rbx, 32
    lea rdi, [rel data_nama]
    add rdi, rbx
    lea rsi, [rel input]
    mov rcx, 32
.copy_nama:
    mov al, [rsi]
    mov [rdi], al
    inc rsi
    inc rdi
    dec rcx
    jnz .copy_nama
    inc qword [rel jumlah_data]
    jmp menu_ulang

lihat_data:
    mov rcx, pesan_lihat
    call printf
    mov rbx, 0
.lihat_loop:
    cmp rbx, [rel jumlah_data]
    jge menu_ulang
    imul rax, rbx, 32
    lea rcx, [rel format_nama]
    lea rdx, [rel data_nama]
    add rdx, rax
    call printf
    inc rbx
    jmp .lihat_loop

hapus_data:
    mov rbx, [rel jumlah_data]
    cmp rbx, 0
    jle menu_ulang
    dec rbx
    mov [rel jumlah_data], rbx
    mov rcx, pesan_hapus
    call printf
    jmp menu_ulang

keluar:
    mov rcx, pesan_keluar
    call printf
    add rsp, 40
    ret
