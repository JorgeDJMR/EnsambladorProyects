
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.model small
.stack 100h

.data
    mensaje db "repitiendo", 0ah, 0dh, "$" ;el "0ah,0dh son un salto de linea
    contadorZf db 1,1,1,1,1  ;numero de veces que se repetira el mensaje

.code
    program:
    mov ax, seg mensaje
    mov ds, ax
    mov cx, 10        ; Inicializar contador a 10
    mov bl,contadorZf ;muevo mi arreglo de 4 numeros a bl
repetir:   
    mov ah,09h          ; Funcion para imprimir un numero en pantalla
    lea dx, mensaje        
    int 21h
    
    mov bl,contadorZf[si] ;guardo en el registro bl el valor del arreglo actual
    inc si  ;incremento o avanzo el arreglo en 1          
    sub bl ,1; Decrementar contador de la bandera ZF 
           
    loopz repetir  ; Continuar el bucle mientras cx>0 y zf=1
    
salida:
    mov ah, 4ch       ; Funcion para terminar el programa
    int 21h  
               
               
end Program
ret




