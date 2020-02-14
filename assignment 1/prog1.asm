.MODEL small
.STACK 100h

.DATA
	a db 5			; a = 5
	b db 2			; b = 2
	msg db " ", "$"

.CODE
MAIN PROC
	MOV ax, @data
	MOV ds, ax
	
	MOV dl, a		; MOV contents of a to ax
	ADD dl, b		; ADD contents of b to ax
	ADD dl, 48		; for printing decimal
	
	MOV ah, 02h
	INT 21h
	
	LEA dx, msg
	MOV ah, 09h
	INT 21h
	
	MOV dl, a
	SUB dl, b		; SUB contents of b to ax
	ADD dl, 48		; for printing decimal
	MOV ah, 02h
	INT 21h
	
	MOV ah, 4ch
	INT 21h
MAIN ENDP
END MAIN