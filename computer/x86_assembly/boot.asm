[org 0x7c00]
mov ax, 3
int 0x10

xchg bx, bx

mov ax, 0
mov ss, ax
mov sp, 0x7c00

mov bx, 3
mov al, 'A'

call blink
halt:
    jmp halt

blink:
        push es
        push dx

        mov dx, 0xb800
        mov es, dx

        shl bx, 1
        mov dl, [es:bx]
        cmp dl, ' '
    jnz .set_spaces
    .set_char:
        mov [es:bx], al
        jmp .done
    .set_spaces:
        mov byte [es:bx], ' '
    .done:
        shr bx, 1
    
        pop dx
        pop es
    ret

times 510 - ($ - $$) db 0
db 0x55, 0xaa

