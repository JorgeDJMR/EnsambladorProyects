
org 100h
.model Small 
.data  
        Saludo db 13,10, "Hola Mundo","$"
        despedida db 13,10, "Salida exitosa", "$"  
.code 
        Programa:
 
        
        ;Muestra el primer texto

        mov cx,10 ;asigno el numero de veces de repeticion
        
        repetir:
            mov ax, seg Saludo
            mov ds,ax ;preparo la direccion
            
            ;muestro el mensaje
            mov ah,09h
            lea dx,Saludo
            int 21h
            
            ;checo si el contador llego a cero para terminar el programa
            cmp cx,0 
            je salida    
            loop repetir
        
        
        salida:
            ;MUESTRO MENSAJE DE DESPEDIDA
            mov ah,09h
            lea dx,despedida
            int 21h
            mov ax, 4c00h
            int 21h
            
            end Program
         
     


ret




