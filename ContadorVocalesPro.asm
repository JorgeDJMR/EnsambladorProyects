org 100h

.model small
.stack 64
.data
include 'emu8086.inc' 

;Creo una variable queusare para aplicar espacio,enter o salto de linea
funEspacio db 13,10, '$'  

text1 db 0ah,0dh, 'Ingrese una palabra :', '$' 
;Mensajes de las letras
resultado db 0ah,0dh, 'Cantidad de ', '$'
la db 0ah,0dh,'A: ','$'
le db 0ah,0dh,'E: ','$'
li db 0ah,0dh,'I: ','$'
lo db 0ah,0dh,'O: ','$'
lu db 0ah,0dh,'U: ','$'

;Valor de las letras al comienzo
numLetras db 100 dup('$')
a db 0
e db 0
i db 0
o db 0
u db 0       


.code
    ;comieza el codigo mostrando un texto
    mov si, 0
    mov ax, @data
    mov ds, ax
    mov ah, 09
    mov dx, offset text1
    int 21h

call saltodelinea  

;Se encarga de captar las letras y checar cuando das enter
CapuradorDeLetras:
;Captura por pantalla el digito
    mov ah, 01h
    int 21h
    ;compara
    cmp al, 0DH
    je Asignador
    ;guarda en arreglo palabra lo que esta en al
    mov numLetras[si],al
    inc si  
    ;Se repetira hasta que se cumpla la condicion del cmp
    jmp CapuradorDeLetras

Asignador:
    mov si, 0h  ;Carga el valor 0 en si
    call saltodelinea
    
    ;Carga la direccin de memoria de una cadena llamada Palabra en el registro SI usando la instrucción mov si, offset Palabra.
    mov cx, si
    mov si, offset numLetras

;Compara el texto que ingreamos  y va incrementando el contador
funComparador:
    mov al, [si]
    cmp al, 0
    je imprimirDatos
    
    ;mayusculas
    cmp al, 'A'
    je incA
    cmp al, 'E'
    je incE
    cmp al, 'I'
    je incI    
    cmp al, 'O'
    je incO         
    cmp al, 'U'
    je incU
    
    ;Minusculas
    cmp al, 'a'
    je incA
    cmp al, 'e'
    je incE
    cmp al, 'i'
    je incI
    cmp al, 'o'
    je incO
    cmp al, 'u'
    je incU

    inc si
    jmp funComparador

incA:
    inc a
    inc si
    jmp funComparador

incE:
    inc e
    inc si
    jmp funComparador

incI:
    inc i
    inc si
    jmp funComparador

incO:
    inc o
    inc si
    jmp funComparador

incU:
    inc u
    inc si
    jmp funComparador

imprimirDatos:
    call saltodelinea
    mov ah,09
    mov dx,offset resultado
    int 21h

    add a, 30h
    mov ah, 09
    mov dx, offset la
    int 21h
    mov ah, 02
    mov dl, [a]
    int 21h

    add e, 30h
    mov ah, 09
    mov dx, offset le
    int 21h
    mov ah, 02
    mov dl, [e]
    int 21h

    add i, 30h
    mov ah, 09
    mov dx, offset li
    int 21h
    mov ah, 02
    mov dl, [i]
    int 21h

    add o, 30h
    mov ah, 09
    mov dx, offset lo
    int 21h
    mov ah, 02
    mov dl, [o]
    int 21h

    add u, 30h
    mov ah, 09
    mov dx, offset lu
    int 21h
    mov ah, 02
    mov dl, [u]
    int 21h

    jmp exit

saltodelinea:
    mov dx, offset funEspacio
    mov ah, 9
    int 21h
    ret

exit:
    mov ax, 4c00h
    int 21h
      
ends


