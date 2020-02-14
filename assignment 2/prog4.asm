.MODEL small
.STACK 100h
.DATA
	arr DW 8, 7, 5, 4, 1, 2, 9, 3, 4, 8, '$'
	SPC DB ','
.CODE
MAIN PROC
	MOV ax, @data
	MOV ds, ax

	LEA si, arr				; i
	LEA di, arr				; j
	INC di
	INC di					; j = i+1
	MOV cx, 10				; length of array
	DEC cx					; i < n-1

	L1:
		MOV bx, [di]
		CMP bx, '$'
		JE L2
		MOV ax, [si]
		CMP ax, bx			; arr[i] < arr[j]
		JB EXCHANGE			; swap
		INC di
		INC di				; j++
		JMP L1
	
	EXCHANGE:
		MOV [si], bx		; swap arr[i], arr[j]
		MOV [di], ax
		INC di
		INC di				; j++
		JMP L1
	
	L2:
		CMP cx, 0			; if counter reached n-1
		JE L3
		INC si
		INC si				; i++
		MOV di, si			; j = i
		INC di
		INC di				; j = j + 1 = i + 1
		DEC cx				; c--
		JMP L1

	L3:
		LEA si, arr
		JMP PRINT
	
	; printing assuming single digit characters
	PRINT:
		MOV dx, [si]
		CMP dx, '$'
		JE EXIT
		ADD dx, 48
		MOV ah, 02h
		INT 21h
		MOV dh, 0
		MOV dl, SPC
		MOV ah, 02h
		INT 21h

		INC si
		INC si
		JMP PRINT

	EXIT:
		MOV ah, 4ch
		INT 21h
MAIN ENDP
END MAIN