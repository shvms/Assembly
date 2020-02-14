.MODEL small
.STACK 100h
.DATA
    NUM DB 8, -7, 5, 4, 1, 2, 9, 3, 4, 8, '$'
    SML DB 127                                   ; maximum signed 8-bit integer
    N   DB '-'

.CODE
MAIN PROC

    MOV ax, @DATA
    MOV ds, ax

    LEA si, NUM
    MOV bl, SML

    L1:
        MOV cl, [si]
        CMP cl, '$'
        JE L3
        INC si
        CMP cl, bl				; if current value < current smallest
        JL L2
        JMP L1
    
    L2:
        MOV bl, cl				; update current smallest
        JMP L1
    
    L3:
        CMP bl, 0
        JL NEGATE
        JMP EXIT
    
    NEGATE:
        NEG bl
        MOV dl, N
        MOV ah, 02h
        INT 21h
        JMP EXIT

    EXIT:
        MOV SML, bl
        MOV dl, bl
        ADD dl, 48
        MOV ah, 02h
        INT 21h

        MOV ah, 4ch
        INT 21h


MAIN ENDP
END MAIN