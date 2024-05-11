org 100h

.model small
.stack 64
.data
include 'emu8086.inc'
;Creo los textos para mostrar en pantalla
m1 db 'Ingrese una cadena: $'
m2 db 0ah,0dh,'La nueva cadena sin vocales es: $'   

;Creo la variable donde se guardara la cadena que ingresemos
TextoDado db 100 dup('$')   
;Creo la variable donde se guardara la cadena modificada
Textomodificado db 100 dup('$')

;Variable utilizada para hacer enter o salto de una linea
salto db 13,10,'$'

.code

    mov si, 0
    mov ax, @data
    mov ds, ax

    mov ah, 09h
    mov dx, offset m1
    int 21h

CapturaTexto:
    mov ah, 01h
    int 21h

    cmp al, 0DH
    je modificarCadena

    mov TextoDado[si], al
    inc si
    jmp CapturaTexto

modificarCadena:
    mov si, 0h
    mov di, 0h

Comparador:
    mov al, TextoDado[si]
    cmp al, '$'
    je ImprimirNuevaCadena
    
    ;Mayusculas
    cmp al, 'A'
    je Sies    
    cmp al, 'E'
    je Sies
    cmp al, 'I'
    je Sies    
    cmp al, 'O'
    je Sies    
    cmp al, 'U'
    je Sies        
    
    ;Minusculas
    cmp al, 'a'
    je Sies
    cmp al, 'e'
    je Sies
    cmp al, 'i'
    je Sies
    cmp al, 'o'
    je Sies
    cmp al, 'u'
    je Sies

; Si no es vocal, se agrega a la nueva cadena
    mov Textomodificado[di], al
    inc di

Sies:
    inc si
    jmp Comparador
    
ImprimirNuevaCadena:
    call saltodelinea

    mov ah, 09h
    mov dx, offset m2
    int 21h

    mov dx, offset Textomodificado
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
end




