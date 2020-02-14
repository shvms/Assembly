.MODEL small
.STACK 100h
.DATA
	str db "hello", 10, 13, '$'
	
.CODE
MAIN PROC

MOV ax, @data
MOV ds, ax

; printing message
LEA dx, str
MOV ah, 09h
INT 21h

; reversing
MOV dh, 0
MOV dl, '$'
PUSH dx
LEA si, str

L1:
	MOV bl, [si]
	CMP bl, '$'
	JE L2
	MOV dh, 0
	MOV dl, [si]
	PUSH dx
	INC si
	JMP L1
	
L2:
	POP dx
	CMP dl, '$'
	JE L3
	
	; printing
	MOV ah, 02h
	INT 21h
	JMP L2

L3: 
	MOV ah, 4ch
	INT 21h

MAIN ENDP
END MAIN