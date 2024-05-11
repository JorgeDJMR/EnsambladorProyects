
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
.MODEL SMALL
.STACK 100h

.DATA
cadena1 DB 'HolaMundo',0
cadena2 DB 'HolaMundo',0
msg_iguales DB 'Las cadenas son iguales',13,10,'$'
msg_no_iguales DB 'Las cadenas no son iguales',13,10,'$'

.CODE
.STARTUP

MOV SI, OFFSET cadena1 ; apunta a la primera cadena
MOV DI, OFFSET cadena2 ; apunta a la segunda cadena

repetir:
    ;cargar un byte de datos desde la memoria apuntada por SI (source index) en el registro AL 
    ;(accumulator) y, a continuacion, incrementar o decrementar SI en funcion del valor de la bandera DF (direction flag).
    LODSB ; recorre cadena, carga el byte en AL y mueve SI al siguiente byte
    CMP AL, [DI] ; compara el byte en AL con el byte en DI
    JNE diferentes ; si los bytes son diferentes, salta a diferentes
    CMP AL, 0 ; si AL es cero, hemos llegado al final de la cadena
    JE iguales ; si no es cero, continúa comparando los siguientes bytes

    INC DI ; mueve DI al siguiente byte

    JMP repetir ; vuelve al inicio del ciclo

iguales:
    ; Aqui se ejecuta el codigo si las cadenas son iguales
    MOV DX, OFFSET msg_iguales ; carga la direccion del mensaje en DX
    MOV AH, 09h ; muestra el mensaje
    INT 21h

    MOV AH, 4Ch ; regresa al DOS
    INT 21h

diferentes:
    ; Aqui se ejecuta el codigo si las cadenas son diferentes
    MOV DX, OFFSET msg_no_iguales ; carga la direccion del mensaje en DX
    MOV AH, 09h ; muestra el mensaje
    INT 21h

    MOV AH, 4Ch ; regresa al DOS
    INT 21h

.EXIT

ret




