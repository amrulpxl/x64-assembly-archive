; Program: CPU Info (NASM, Windows x64)
default rel

section .data
    fmt_vendor  db "CPU Vendor : %s", 10, 0
    fmt_brand   db "CPU Brand  : %s", 10, 0
    fmt_thread  db "Threads    : %d", 10, 0
    fmt_core    db "Cores      : %d", 10, 0
    fmt_feature db "Features   : %s", 10, 0

    features:   times 256 db 0
    vendor:     times 13 db 0
    brand:      times 49 db 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    ; cpuid eax=0: vendor
    xor eax, eax
    cpuid
    mov [vendor], ebx
    mov [vendor+4], edx
    mov [vendor+8], ecx

    lea rcx, [fmt_vendor]
    lea rdx, [vendor]
    call printf

    ; cpuid eax=0x80000002..4: brand
    mov eax, 0x80000002
    cpuid
    mov [brand], eax
    mov [brand+4], ebx
    mov [brand+8], ecx
    mov [brand+12], edx

    mov eax, 0x80000003
    cpuid
    mov [brand+16], eax
    mov [brand+20], ebx
    mov [brand+24], ecx
    mov [brand+28], edx

    mov eax, 0x80000004
    cpuid
    mov [brand+32], eax
    mov [brand+36], ebx
    mov [brand+40], ecx
    mov [brand+44], edx

    lea rcx, [fmt_brand]
    lea rdx, [brand]
    call printf

    ; jumlah logical threads
    ; (dari cpuid eax=1: ebx bits 16-23)
    mov eax, 1
    cpuid
    mov ebx, ebx
    shr ebx, 16
    and ebx, 0xFF
    lea rcx, [fmt_thread]
    mov edx, ebx
    call printf

    ; jumlah physical cores
    ; (dari cpuid eax=4: eax bits 26-31) + 1
    mov eax, 4
    xor ecx, ecx
    cpuid
    shr eax, 26
    and eax, 0x3F
    inc eax
    lea rcx, [fmt_core]
    mov edx, eax
    call printf

    ; fitur CPU (sse, sse2, avx, aes)
    ; (dari cpuid eax=1: edx, ecx)
    mov eax, 1
    cpuid
    mov esi, edx
    mov edi, ecx

    lea rbx, [features]

    bt edx, 25
    jc .has_sse
    jmp .check_sse2
.has_sse:
    mov rax, ' SSE'
    mov [rbx], rax
    add rbx, 4
.check_sse2:
    bt edx, 26
    jc .has_sse2
    jmp .check_avx
.has_sse2:
    mov rax, ' SSE2'
    mov [rbx], rax
    add rbx, 5
.check_avx:
    bt ecx, 28
    jc .has_avx
    jmp .check_aes
.has_avx:
    mov rax, ' AVX'
    mov [rbx], rax
    add rbx, 4
.check_aes:
    bt ecx, 25
    jc .has_aes
    jmp .features_done
.has_aes:
    mov rax, ' AES'
    mov [rbx], rax
    add rbx, 4

.features_done:
    mov byte [rbx], 0

    lea rcx, [fmt_feature]
    lea rdx, [features]
    call printf

    ; exit
    mov eax, 0
    pop rbp
    ret
