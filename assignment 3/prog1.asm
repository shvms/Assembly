.MODEL small
.STACK 100h
.DATA
	S DB "hElLo$"
	lowc DB -32
.CODE
MAIN PROC
	MOV ax, @data
	MOV ds, ax

	MOV bl, lowc
	LEA si, S

	L1:
		MOV dl, [si]
		CMP dl, '$'
		JE EXIT

		CMP dl, 97
		JL NOTLOWER

		ADD dl, bl		; make it upper
		MOV ah, 02h
		INT 21h

		INC si
		JMP L1

	NOTLOWER:
		MOV ah, 02h
		INT 21h
		INC si
		JMP L1

	EXIT:
		MOV ah, 4ch
		INT 21h
MAIN ENDP
END MAIN