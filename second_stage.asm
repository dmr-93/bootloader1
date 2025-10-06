BITS 16
ORG 0x7e00

start:
    ; Imprime "."
    mov ah, 0x0e
    mov al, '.'
    int 0x10

    hlt
