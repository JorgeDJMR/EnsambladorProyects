
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.model small
.stack 100h

.data
    mensaje db "repitiendo", 0ah, 0dh, "$" ;el "0ah,0dh son un salto de linea
    contadorZf db 4,3,2,1  ;para dejar de repetir el mensaje debe de
                           ;llegar al "1" ya que 1-1=0, por lo tanto aqui 
                           ;se decide cuantas veces se repitira

.code
    program:
    mov ax, seg mensaje
    mov ds, ax
    mov cx, 10        ; Inicializar contador a 10, decide las veces de repeticion
    mov bl,contadorZf ;muevo mi arreglo de 4 numeros a bl
repetir:   
    mov ah,09h          ; Funcion para imprimir un numero en pantalla
    lea dx, mensaje        
    int 21h
    
    mov bl,contadorZf[si] ;guardo en el registro bl el valor del arreglo actual
    inc si  ;incremento o avanzo el arreglo en 1          
    sub bl,1; Decrementar contador de la bandera ZF 
           
    loopnz repetir  ; Continuar el bucle mientras cx>0 y zf=0
    
salida:
    mov ah, 4ch       ; Funcion para terminar el programa
    int 21h  
               
               
end Program
ret



