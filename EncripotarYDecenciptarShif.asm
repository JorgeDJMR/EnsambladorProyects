org 100h
.model small
.stack 64

.data

;Mensajes 
numEncriptado db 'Ingresa el nuemero de veces que buscar encriptar: $'  
msj db 'Ingresa la cadena que deceas encriptar: $'
msj2 db 0ah,0dh,'Texto encriptado: $'
msj3 db 0ah,0dh,'Texto desencriptado: $' 

;Variables
cadena db 100 dup('$')
cadenaEn db 100 dup('$')
cadenaDe db 100 dup('$')        

;Programacion del salto de linea
salto db 13,10,13,10,'$' 

;
avanzar db 0

.code   

;;;;Macros;;;;
encriptacion macro letra
    mov cl, avanzar
    ror letra, cl
endm

desencriptacion macro letra
    mov cl, avanzar
    rol letra, cl                                                                                                   

endm

inicio:
mov si, 0
mov ax, @data                           
mov ds, ax 

mov ah, 09h
mov dx, offset numEncriptado
int 21h                                

mov ah, 01h
int 21h     

;Resta para volver el numero normal, sin efectos 
sub al, 30h 
mov avanzar, al 
   
call saltodelinea 

mov ah, 09h
mov dx, offset msj
int 21h
 
Ciclo:
mov ah, 01h
int 21h
cmp al, 0DH
je GenerarNuevaCadena
mov cadena[si], al
inc si
loop Ciclo

GenerarNuevaCadena:
mov si, 0h

CicloMetodo:
mov al, cadena[si]
cmp al, '$'
je GenerarCadena
encriptacion al
mov cadenaEn[si], al
inc si
loop CicloMetodo

GenerarCadena:
mov si, 0h

CicloMetodo2:
mov al, cadenaEn[si]
cmp al, '$'
je ImprimirNuevaCadena
desencriptacion al
mov cadenaDe[si], al
inc si
loop CicloMetodo2 

ImprimirNuevaCadena:
call saltodelinea

mov ah, 09h
mov dx, offset msj2
int 21h
mov dx, offset cadenaEn
int 21h
mov ah, 09h
mov dx, offset msj3
int 21h
mov dx, offset cadenaDe
int 21h
jmp exit

saltodelinea:
mov dx, offset salto
mov ah, 9
int 21h
ret

exit:
mov ax, 4c00h
int 21h
 
ret