.MODEL small
.STACK 100h
.DATA
	; values taken such that resultant matrix has single digit elements
	; for simiplicity of multiplication
	ar DB 3,1,1,1,1,2,1,2,1					; matrix A row-wise
	bc DB 1,2,1,1,1,2,1,1,1					; matrix B column-wise
.CODE
MAIN PROC
	MOV ax, @data
	MOV ds, ax

	MOV bp, 0								; resultant matrix counter

	INIT1:
		LEA si, ar							; counter of ar
		LEA di, bc							; counter of bc
		JMP INIT2

	INIT2:
		MOV dl, 0							; variable to store each element
		MOV bx, 0							; offset counter of 3
		MOV cx, 3							; loop counter
		JMP MULTIPLY

	MULTIPLY:
		MOV al, [si][bx]					; row element
		IMUL BYTE PTR [di][bx]				; multiplied column element
		ADD dl, al							; accumulated at dl
		INC bx
		LOOP MULTIPLY
		JMP SAVE_UPDATE

	SAVE_UPDATE:
		ADD dl, 48							; printing the value
		MOV ah, 02h
		INT 21h
		MOV dl, ' '							; printing space after each value
		MOV ah, 02h
		INT 21h
		
		INC bp								; variable to track number of variables printed
		CMP bp, 9							; all elements done then exit
		JE EXIT
		CMP bp, 3							; if 3 or 6 elements done, then increment si by 3 places and print a new line
		JE UPDATE_SI
		CMP bp, 6
		JE UPDATE_SI
		
		INC di								; increment di by 3 places to go to next column
		INC di
		INC di
		JMP INIT2

	UPDATE_SI:
		LEA di, bc							; reset di to point to initial value for calculation of new row of resultant
		INC si								; incrementing si by 3 places for same reason
		INC si
		INC si
		
		MOV dl, 10							; printing new line
		MOV ah, 02h
		INT 21h

		MOV dl, 13							; carriage return
		MOV ah, 02h
		INT 21h

		JMP INIT2
	
	EXIT:
		MOV ah, 4ch
		INT 21h
MAIN ENDP
END MAIN