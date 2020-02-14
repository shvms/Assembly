.MODEL small
.STACK 100h
.DATA
    a DW 10000
    b DW -13420
    N DB '-'

.CODE
MAIN PROC

    MOV ax, @DATA
    MOV ds, ax

    MOV ax, a
    ADD ax, b
    MOV cx, ax
    MOV bh, 0
    MOV bl, 10

    ; printing result
    MOV dh, 0
    MOV dl, '$'
    PUSH dx
    MOV bh, 0
    MOV bl, 10

    L0:
        CMP cx, 0
        JL NEGATE					; negate if negative to make it positive
        JMP L1
    
    NEGATE:
        MOV dl, N
        MOV ah, 02h
        INT 21h
        MOV ax, cx
        NEG ax
        MOV cx, ax
        JMP L1

    L1:								; printing the sum
        MOV ax, cx
        MOV dx, 0
        DIV bx
        MOV cx, ax
        MOV dh, 0
        ADD dl, 48
        PUSH dx
        CMP cl, 0
        JE L2
        JMP L1
    
    L2:
        POP dx
        CMP dl, '$'
        JE EXIT
        MOV ah, 02h
        INT 21h
        JMP L2
    
    EXIT:
        MOV ah, 4ch
        INT 21h

MAIN ENDP
END MAIN