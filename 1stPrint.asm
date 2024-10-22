[org 0x100]
jmp main
message: db 'hello world! :]'
length : dw  15
clrscreen:
    push es    
    push ax
    push di
    mov ax,0xb800
    mov es,ax
    mov di,0 ;top left

    nextPosition:
        mov word [es:di],0x0720
        add di,2
        cmp di,4000
        jne nextPosition ;0-3998

    pop di
    pop ax
    pop es 
    ret

printStr:
    push bp
    mov bp,sp
    push ax
    push bx
    push di
    push es
    push si

    mov ax,0xb800
    mov es,ax
    mov di,0
    mov si,[bp+6];message address
    mov bx,[bp+4];length
    mov ah,0x1B

    nextPos:
        mov al,[si]
        mov [es:di],ax
        add di,2
        add si,1
        dec bx
        jnz nextPos
    pop si
    pop es
    pop di
    pop bx
    pop ax
    pop bp
    ret 4 ;because 2 parameters already present in stack pop ip and then those two
main:
    call clrscreen
    mov ax,message
    push ax
    push word [length]
    call printStr

    mov al,0x01
    int 21h
    mov ax,0x4c00
    int 21h
