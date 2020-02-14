.MODEL SMALL
.STACK 100h
.DATA
	msg db "Enter name: ", 10, 13, '$'
	str db 30 dup('$')

.CODE
MAIN PROC

MOV ax, @data
MOV ds, ax

; printing message
LEA dx, msg
MOV ah, 09h
INT 21h

; input
LEA di, str
L1:
	MOV ah, 01h
	INT 21h
	CMP al, 13
	JE L2
	MOV [di], al
	INC di
	JMP L1

L2:
	; printing
	MOV al, 24h
	MOV [di], al
	LEA dx, str
	MOV ah, 09h
	INT 21h

MOV ah, 4ch			; terminate
INT 21h

MAIN ENDP
END MAIN