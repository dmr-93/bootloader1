BITS 16
ORG 0x7c00

start:
    ; Imprime "."
    mov ah, 0x0e
    mov al, '.'
    int 0x10

    ; Carrega o segundo estágio no endereço 0x7e00 (7c00+512)
    mov ah, 0x02       ; função para ler setor
    mov al, 1          ; ler 1 setor (512 bytes)
    mov ch, 0          ; cilindro 0
    mov cl, 2          ; setor 2
    mov dh, 0          ; cabeça 0
    mov dl, 0x0        ; floppy 0x0 ou drive 0x80
    mov bx, 0x7e00     ; endereço onde carregar
    int 0x13

    ; Salta para o segundo estágio
    jmp 0x0000:0x7e00 ; jmp 0x07e00

; Preencher o restante com 0
times 510-($-$$) db 0
dw 0xaa55
