.MODEL SMALL
.STACK 100h
.DATA
	msg		db "Enter number: $"
	rad		db 2, 10, 16, 024h
	NL		db 10, 13, "$"
	
.CODE
MAIN PROC

MOV ax, @data
MOV ds, ax

LEA dx, msg
MOV ah, 09h
INT 21h

MOV bl, 0
MOV ch, 10				; for multiplying by 10
INPUT1:
	MOV ah, 01h
	INT 21h
	CMP al, 13
	JE LOOP2
	SUB al, 48			; actual value
	MOV cl, al
	MOV al, bl
	MUL ch
	ADD al, cl
	MOV bl, al
	JMP INPUT1
	
LOOP2:
	MOV cl, bl				; copying for further use
	LEA si, rad
	MOV ch, 0
	
INIT:
	MOV al, cl
	MOV dh, 0
	MOV dl, '$'
	PUSH dx					; pushing terminating character as pop condition
	MOV bl, [si]
	;INC si
	;JMP L1
	
L1:
	MOV ah, 0			; clearing the remainder storing register
	DIV bl
	MOV dl, ah
	MOV dh, 0
	PUSH dx
	CMP al, 0			; if quotient = 0
	JE L2
	JMP L1
	
L2:
	POP dx
	CMP dl, '$'
	JE L3
	CMP dl, 9
	JG HEX
	ADD dl, 48
	MOV ah, 02h
	INT 21h
	JMP L2

HEX:
	ADD dl, 55
	MOV ah, 02h
	INT 21h
	JMP L2

L3:
	LEA dx, NL
	MOV ah, 09h
	INT 21h
	
	INC si
	MOV ch, [si]
	CMP ch, '$'
	JE EXIT
	JMP INIT
	
EXIT:
	MOV ah, 4ch
	INT 21h

MAIN ENDP
END MAIN