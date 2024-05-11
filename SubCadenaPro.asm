org 100h 
  
.model small
.stack 
.data 

Cadena1 db "Hola Mundo Loco$" 
subCadena db "Hola Mundo$" 
siExiste db "Existe una subcadena  :)$" 
noExiste db "No existe una subcadena :($"

terminarPrograma db 0ah,0dh,0ah,0dh,"Fin del programa$"

.code   

    mov si, 0 ;ponemos si en 0
Comparador: 
    mov al, subCadena[0] ;copiar la primera letra de la palabra a al
    
    ;Si al final de la cadena se encuentra el $, entonces e el final
    cmp Cadena1[si],"$" ;si es el fin de la cadena mandar a final
    jz NoHaySubcadena 
    
    cmp Cadena1[si], al ;comparar si encuentra la primera letra de la cadena
    jne RecorrerPalabra

    mov di, 1 ;poner en 1 di
comprobar:
    mov al, subCadena[di]
    mov bx, di
    cmp Cadena1[si+bx], al ;posicion de la letra coincidente + di, comparar con la cadena
    jne RecorrerPalabra ;si no coincide mandar a RecorrerPalabra

    inc di ;incrementar di para seguir recorriendo cadena 

    cmp subCadena[di],"$" ;si es el fin de la cadena y el programa llego aca quiere decir que la cadena es parte de la palabra
    jz resultado 

    loop comprobar ;bucle para recorrer cadena 

RecorrerPalabra: 
    inc si ;para seguir recorriendo la palabra
    loop Comparador ;bucle principal para recorrer palabra  
    
NoHaySubcadena:
    mov ah, 09h
    lea dx, noExiste
    int 21h 
    jmp final
    
resultado:
    mov dx, offset siExiste ;copiar msg3 a dx
    mov ah, 9 ;preparar ah con 9 para la interrupcion 21h
    int 21h ;mostrar contenido en dx        
    
final:
    mov ah, 09h
    lea dx, terminarPrograma
    int 21h 
    mov ah, 4ch       ; Funcion para terminar el programa
    int 21h  
        

.exit


ret


