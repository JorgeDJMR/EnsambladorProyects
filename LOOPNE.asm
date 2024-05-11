org 100h

.model small
.stack 100h

.data
    mensaje db "repitiendo", 0ah, 0dh, "$" ;el "0ah,0dh son un salto de linea
    contadorZf db 1,2,3,4,5              

.code
    program:
    mov ax, seg mensaje
    mov ds, ax
    mov cx, 10        ; Inicializar contador a 10, decide las veces de repeticion
    mov bl,contadorZf ;muevo mi arreglo a bl
repetir:   
    mov ah,09h          ; Funcion para imprimir un numero en pantalla
    lea dx, mensaje        
    int 21h
    
    mov bl,contadorZf[si] ;guardo en el registro bl el valor del arreglo actual
    inc si  ;incremento o avanzo el arreglo en 1          
    add bl,5; resto 1 a bl
           
    loopne repetir  ; Continuar el bucle mientras cx>0, zf=0 y pf=0
    
salida:
    mov ah, 4ch       ; Funcion para terminar el programa
    int 21h  
               
               
end Program
ret

