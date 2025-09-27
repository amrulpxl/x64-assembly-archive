# 11 - CPU Information

Program ini menampilkan informasi dasar tentang CPU, seperti Vendor, Brand, Jumlah Threads, Jumlah Cores, dan Fitur yang didukung oleh CPU.

## Cara Compile
```bash
nasm -f win64 main.asm -o main.obj
gcc main.obj -o main.exe
```

## Cara Menjalankan
```bash
./main.exe
```

## Output Contoh
```
CPU Vendor : AuthenticAMD
CPU Brand  : AMD Ryzen 5 5600X
Threads    : 12
Cores      : 6
Features   :  SSE SSE2 AVX AVX2 AES
```