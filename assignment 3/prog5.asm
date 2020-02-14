.MODEL small
.STACK 100h
.DATA
	msg1 DB "Wait for 10s...", 10, 13, '$'
	msg2 DB "Line printed after 10s", '$'
.CODE
MAIN PROC
	MOV ax, @data
	MOV ds, ax

	MOV CX, 0098H						; 10s = 10^7 microseconds. In hexadecimal = 989680H
	MOV DX, 9680H						; CX:DX augmented register

	MOV ah, 86h							; DOS interrupt to generate CX:DX microseconds bios wait
	INT 15h
	
	LEA dx, msg2
	MOV ah, 09h
	INT 21h

	EXIT:
		MOV ah, 4ch
		INT 21h
MAIN ENDP
END MAIN