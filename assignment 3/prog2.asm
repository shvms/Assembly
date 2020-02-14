.MODEL small
.STACK 100h
.DATA
	str DB "eutopia$"
	NL DB 10, 13, '$'
	msg DB "Vowels: "
.CODE
MAIN PROC
	MOV ax, @data
	MOV ds, ax

	MOV cl, 0				; vowel counter
	LEA si, str

	L1:
		MOV al, [si]

		CMP al, '$'
		JE PRINT

		CMP al, 97			; a
		JE COUNT
		CMP al, 101			; e
		JE COUNT
		CMP al, 105			; i
		JE COUNT
		CMP al, 111			; o
		JE COUNT
		CMP al, 117			; u
		JE COUNT

		INC si
		JMP L1
	
	COUNT:
		INC cl
		INC si
		JMP L1
	
	PRINT:					; assuming single digit count
		MOV dl, cl
		ADD dl, 48
		MOV ah, 02h
		INT 21h
		JMP EXIT

	EXIT:
		MOV ah, 4ch
		INT 21h
MAIN ENDP
END MAIN