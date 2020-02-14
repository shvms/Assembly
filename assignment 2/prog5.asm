.MODEL small
.STACK 100h
.DATA
	a DD 97000h
	b DD 85000h
	arr DD 3 dup(?)
	rad DW 16
.CODE
MAIN PROC
	MOV ax, @data
	MOV ds, ax

	LES ax, a			; loading extra in extra segment
	MOV dx, es

	LES bx, b			; loading extra in extra segment
	MOV cx, es

	ADD ax, bx
	ADC dx, cx			; adding with carry

	LEA si, arr
	MOV [si], ax		; putting ax in arr
	INC si
	INC si
	MOV [si], dx		; putting dx in arr
	LEA si, arr

	MOV bx, rad			; radix
	MOV dx, '$'
	PUSH dx
	MOV cx, 1			; counter

	PRINT:
		MOV ax, [si]		; moving [si] to ax for operations

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
	
	HEX:					; invoke if dx > 9 to print digits A-F
		ADD dx, 55
		MOV ah, 02h
		INT 21h
		JMP PRINT_POP


	EXIT:
		MOV ah, 4ch
		INT 21h
MAIN ENDP
END MAIN