; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

.model small
.stack 200h   ;Cantidad de espacio en hexadecimal
.data

;mensajes de texto
msg1 db 10,13,7,"Ingresa el primer numero: ", "$"   
msg2 db 10,13,7,"Ingresa el segundo numero: ", "$"
msg3 db 10,13,7,"Elige la operacion que quieres realizar: Suma=1 resta=2 multi=3 divi=4: ", "$"
msg4 db 10,13,7,"El resultado es: ", "$"  
                                                                                  
                                           
;Serviran para guardar los 3 digitos que se tomaran por pantalla
digito1 db 0
digito2 db 0
digito3 db 0

cond dw 1;condicion

cont1 db 0
cont2 db 0
;numero que digitan en pantalla total
num1 dw ?
num2 dw ?

resultadoFinal dw ?   ;resultado

;opcional, es mio
sumaaaa db 1

.code
    ;carga los datos y muestra el primer mensaje
    mov ax, @data
    mov ds, ax
    
    mov ah, 09h
    lea dx, msg1
    int 21h
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;Captura el primer numero  
    ;Primer caracter
    mov ah, 01h
    int 21h
    sub al, 30h ;Para almacenar solo el digito que tecleamos es necesario aplicarle una resta 
    mov digito1, al    
    
    ;Segundo caracter
    mov ah, 01h
    int 21h
    sub al, 30h
    mov digito2, al 
    
    ;Tercer caracter
    mov ah, 01h
    int 21h
    sub al, 30h
    mov digito3, al   
    
    ;juntar los numeros anteriores, para dividirlos en unidades,decenas y centenas
    
    ;Aqui calulo las decenas y agrego el 3 dijito que tecleste
    mov al, digito2
    mov bl, 10
    mul bl
    add al, digito3
    mov num1, ax
    
    ;Aqui agrego el primer numero que tecleste, siendo aqui donde se producen las centenas
    mov al, digito1
    mov bl, 100
    mul bl
    add ax, num1
    mov num1, ax
    
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;   
    ;Se carga el msg2, para ingleresar el segundo numero
    
    mov ah, 09h
    lea dx, msg2
    int 21h
       
    
    ;Captura el segundo numero
    ;Primer caracter
    mov ah, 01h
    int 21h
    sub al, 30h ;Para almacenar solo el digito que tecleamos es necesario aplicarle una resta 
    mov digito1, al    
    
    ;Segundo caracter
    mov ah, 01h
    int 21h
    sub al, 30h
    mov digito2, al 
    
    ;Tercer caracter
    mov ah, 01h
    int 21h
    sub al, 30h
    mov digito3, al   
      
      
    ;juntar los numeros anteriores, para dividirlos en unidades,decenas y centenas
    
    ;Aqui calulo las decenas y agrego el 3 dijito que tecleste
    mov al, digito2
    mov bl, 10
    mul bl
    add al, digito3
    mov num2, ax
    
    ;Aqui agrego el primer numero que tecleste, siendo aqui donde se producen las centenas
    mov al, digito1
    mov bl, 100
    mul bl
    add ax, num2
    mov num2, ax
    
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;Elige tu operacion
    
    ;Carga el msg3 el cual es un texto para elegir las operaciones, como menu
    mov ah, 09h
    lea dx, msg3
    int 21h 
    
    mov ah,01h  ;Agarra el digito por pantalla
    int 21h
    
    
    ;Se decide que operacion realizar
    cmp al, 31h  ; Si son iguales (ZF=1), saltar a la etiqueta
    jz suma   
    
    cmp al, 32h
    jz resta  
    
    cmp al, 33h
    jz multiplicacion
    
    cmp al, 34h
    jz division
    
    suma:  
    ;Para realizar la operacion se tiene que mover al registro acumulador, por eso lo meto num1 dentro de ax
    mov ax, num1
    add ax, num2 
    mov resultadoFinal, ax
    jmp msgResultado
    endp
    
    resta:
    mov ax, num1
    sub ax, num2 
    mov resultadoFinal, ax
    jmp msgResultado
    endp
    
    multiplicacion:
    mov ax, num1
    mov bx, num2
    mul bx
    mov resultadoFinal, ax
    jmp msgResultado
    endp
    
    division:
    mov ax, num1
    mov dx, 0
    mov bx, num2
    div bx
    mov resultadoFinal, ax
    jmp msgResultado
    endp
    
    ;Se imprimer el msg4, el cual menciona al resultado
    msgResultado:
    mov ah, 09h
    lea dx, msg4
    int 21h
    endp
    
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
    ;Convierto el resultado que esta en hexadecimal a decimal
    ;Para esto utilizo el residuo de una divicion y lo voy metiendo en una pila
    
    ConvertidorDecimal:
        cmp cond, 0 ;Si llego a 0 es por que termino el proceso de divicion
        je imprimirDigitos ;si la condicion llego a 0 despues de dividir, entronces se ira a la etiqueta imprimir
        
        mov ax, resultadoFinal
        mov dx, 0
        mov bx, 10   ;Metemos en bx 10 para aplicar la division y la conversiona  decimal
        div bx
        mov resultadoFinal, ax  ;Se guarda el resultado de la division
        
        push dx;guado el residuo, el cual es el digito que se utilizara para formar el resultado
        
        mov cond, ax;Asigno el valor de ax a la condicion
        
        inc cont1;contamos el numero de digitos en decimal, para saber cuantos son, de esta manera sabre cuantos valores sacar de la pila
        jmp ConvertidorDecimal
     
     imprimirDigitos:
        mov al, cont1
        cmp cont2, al ;Se encarga de imprimir los digitos del resultado
        ;si la condicion se cumple es por que ya se saco de la pila todos los digitos ingresados en ella
        je TerminaPrograma ;En el caso de que los 2 contadores sean iguales termina el proceso
        
        pop ax ;saca un elemento de la pila y lo asigna a AX
        add ax, 30h ; ajuste para que concida con el caracter ascii
        
        ;imprime el valor en pantalla
        mov ah, 02h
        mov dl, al
        int 21h
        
        inc cont2
    
     jmp imprimirDigitos
        
     TerminaPrograma:
        mov ah, 4ch       ; Funcion para terminar el programa
        int 21h  
    
    
end
    
ret




