[org 0x7c00]
mov ax, 3
int 0x10

xchg bx, bx

; mov ax, 0x1111
; mov bx, 0x1111
; mov cx, 0x1111

mov ax, 0xb800
mov es, ax

mov ax, 0
mov ds, ax

mov si, message
mov di, 0

mov al, [ds:si]
mov [es:di], al
mov cx, (message_end - message)

; mov byte[0], 'h'
; mov byte[2], 'e'
; mov byte[4], 'l'
; mov byte[6], 'l'
; mov byte[8], 'o'
; mov byte[10], ','
; mov byte[12], 'w'
; mov byte[14], 'r'
; mov byte[16], 'o'
; mov byte[18], 'l'
; mov byte[20], 'd'

loop1:
    mov al, [ds:si]
    mov [es:di], al

    add si, 1
    add di, 2
    loop loop1
halt:
    jmp halt

message:
    db "hello,world", 0
message_end:

times 510 - ($ - $$) db 0
db 0x55, 0xaa












CRT_ADDR_REG equ 0x3D4
CRT_DATA_REG equ 0x3D5

CRT_CURSOR_HIGH equ 0x0E
CRT_CURSOR_LOW equ 0x0f
xchg bx, bx

mov ax, 0
mov ss, ax
mov sp, 0x7c00



; mov word [0x80 * 4], print
; mov word [0x80 * 4 + 2], 0

; int 0x80
; mov cx, 25
; loop1:
;     call 0:print
;     loop loop1

halt:
    jmp halt

print:
    ;将别人的寄存器值保存起来
    push ax 
    push es
    push di

    mov ax, 0xb800
    mov es, ax
    mov di, [video]
    mov byte [es:di], "."
    add word [video], 2

    ;还原寄存器里的值
    pop di
    pop es
    pop ax
    retf

video:
    dw 0x0

get_curson:
    push dx

    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_HIGH
    out dx, al

    mov dx, CRT_DATA_REG
    in al, dx
    shl ax, 8

    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_LOW
    out dx, al

    mov dx, CRT_DATA_REG
    in al, dx
    pop dx

    ret

set_curson:

    push dx
    push bx

    mov bx, ax

    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_LOW
    out dx, al

    mov dx, CRT_DATA_REG
    mov al, bl
    out dx, al

    mov dx, CRT_ADDR_REG
    mov al, CRT_CURSOR_HIGH
    out dx, al

    mov dx, CRT_DATA_REG
    mov al, bh
    out dx, al

    pop bx 
    pop dx

    ret 
