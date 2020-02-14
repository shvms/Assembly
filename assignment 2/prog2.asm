.MODEL small
.STACK 100h
.DATA
	a DW 2094h
	b DW 4640h
	arr DW 3 dup(?)
	rad DW 16				; radix 16
.CODE
MAIN PROC
	MOV ax, @data
	MOV ds, ax

	MOV ax, a
	MOV bx, b
	MUL bx					; two 16-bits number multiplied. [dx : ax]
	
	LEA si, arr
	MOV [si], ax				; pushing ax to first half
	INC si
	INC si					; incrementing two times because 16 bits = 2 bytes
	MOV [si], dx

	LEA si, arr				; resetting si

	; initialising stack
	MOV dh, 0
	MOV dl, '$'
	PUSH dx

	MOV bx, rad
	MOV cx, 1				; counter
	
	PRINT:
		MOV ax, [si]			; moving [si] to ax for operations

	PRINT_PUSH:
		MOV dx, 0
		DIV bx				; remainder on dx and quotient on ax
		
		PUSH dx
		CMP ax, 0
		JE NEXT
		JMP PRINT_PUSH
	
	NEXT:
		CMP cx, 2			; if PRINT looped two 2 times or not?
		JE PRINT_POP
		INC si
		INC si
		INC cx
		JMP PRINT

	PRINT_POP:
		POP dx
		CMP dx, '$'
		JE EXIT
		CMP dx, 9			; for printing digits A-F
		JG HEX
		ADD dx, 48
		MOV ah, 02h
		INT 21h
		JMP PRINT_POP
	
	HEX:
		ADD dx, 55
		MOV ah, 02h
		INT 21h
		JMP PRINT_POP

	EXIT:
		MOV ah, 4ch
		INT 21h
MAIN ENDP
END MAIN