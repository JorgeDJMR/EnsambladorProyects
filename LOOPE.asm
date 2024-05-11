
org 100h

.model small
.stack 100h

.data
    mensaje db "repitiendo", 0ah, 0dh, "$" ;el "0ah,0dh son un salto de linea
    contadorZf db -2,-2,2,1,1  ;el mensaje se repitit

.code
    program:
    mov ax, seg mensaje
    mov ds, ax
    mov cx, 10        ; Inicializar contador a 10
    mov bl,contadorZf ;muevo mi arreglo a bl
repetir:   
    mov ah,09h          ; Funcion para imprimir un numero en pantalla
    lea dx, mensaje        
    int 21h
    
    mov bl,contadorZf[si] ;guardo en el registro bl el valor del arreglo actual
    inc si  ;incremento o avanzo el arreglo en 1          
    add bl, 2; incremento 2 a bl 
           
    loope repetir  ; Continuar el bucle mientras cx>0, zf=1 y pf=1
    
salida:
    mov ah, 4ch       ; Funcion para terminar el programa
    int 21h  
               
               
end Program
ret



