[org 0x100]
jmp main
;number: dw 100;18000
clrscreen:
    push ax
    push es
    push di

    mov ax,0xb800
    mov es,ax
    mov di,0

    nextPosition:
        mov word [es:di],0x0720
        add di,2
        cmp di,4000
        jne nextPosition
        ;if equal then

    pop di
    pop es
    pop ax
    ret

printNumber:
    push bp
    mov bp,sp 
    push ax
    push bx 
    push cx
    push dx
    push di
    push es
    mov ax,[bp+4];,ip bp value ->above is number address so ....[address]-> value......
    mov bx,10 ;dividing by 10 base 10 {to have remainder consisting of last digit} 
    mov cx,0 ;digits counter
    nextDigit:
        mov dx,0 ;mov dh to 0,it(dl) will save remainder
        div bx ; divide ax by bx (ax/bx) and place quotient in ax and remainder in dl( eax ,dx),there are
        add dl,0x30 ;add 30(ASCII of 0 is 0x30) to  dl to convert into ASCII Value
        push dx ;place dx in stack
        inc cx  ;increase count to 1
        cmp ax,0 ;check it quotient is 0
        jnz nextDigit
    
    mov ax,0xb800
    mov es,ax
    mov di,0
    nextPosition1:
        pop dx
        mov dh,0x07 ;l> 00 in dh so replacing it with style byte ,1 byte for characters ascii value
        mov [es:di],dx ; dx
        add di,2
        loop nextPosition1 ;loop to numbers of digits in cx

    pop es
    pop di
    pop dx 
    pop cx
    pop bx
    pop ax              
    pop bp 
    ret 2 ;as it takes 1 argument through stack so pop 1 word(2bytes) on stack


main:
    call clrscreen
   mov ax,0XfFFF;[number]
    ; push number
    push ax
    ;push word [number]
    call printNumber

mov ah,0x01
int 0x21
mov ax,0x4c00 
int 0x21 


