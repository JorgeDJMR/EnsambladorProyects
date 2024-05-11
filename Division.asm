
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.model Small   
   
.data 
        resultado db "El resultado es : ", "$"
        
        num1 db 12
        num2 db 3
        r db ?

.code 
        Programa:
  
        mov al, num1 
        mov bl, num2
        div bl
        

        mov bl,al
        ;Limpio ax
        mov ax, 0000h 
        mov al,bl
        
        ;Configuracion para la multiplicacion
        ;divide los caracteres, como si fuera de manera individual
        AAD 
        
        ;lo que este en ax lo amndare a cx, tambien puedo utilizar bx
        ;Son 30 para la parte alta y 30 para la parte baja
        mov cx,ax
        
        ;Muestra el texto
        mov ah, 09h
        lea dx, resultado
        
        int 21h
        
        ;Muestra el primer caracter ingresado
        mov ah, 02h
        mov dl, ch 
        add dl, 30h
        int 21h
        
        ;Muestra el segundo caracter
        mov ah, 02h
        mov dl, cl 
        add dl, 30h
        int 21h

        ;Termina programa
        mov ax, 4c00h
            int 21h
        end Program

ret




