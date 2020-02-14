.MODEL small
.STACK 100h
.DATA
	P DB 75H
	Q DB 19H
	R DB 16
.CODE
MAIN PROC
	MOV ax, @data
	MOV ds, ax

	MOV dh, 0
	MOV dl, '$'
	PUSH dx

	MOV bl, P
	MOV cl, Q

	CMP bl, cl
	JB EXCHANGE
	JMP BCD_ADD

	EXCHANGE:
		XCHG bl, cl

	BCD_ADD:
		CMP bl, 0
		JE PRINT

		MOV bh, 0

		MOV al, bl
		MOV ah, 0
		DIV R
		MOV bh, ah			; adding last digit by last digit. Hence, remainder
		MOV bl, al			; updating bl after division

		MOV al, cl
		MOV ah, 0
		DIV R
		MOV ch, ah			; adding last digit by last digit
		MOV cl, al			; updating cl after division

		ADD bh, ch			; digit-by-digit addition
		CMP bh, 9h			; bh > 9 => need for adjustment
		JG ADJUST

		MOV dh, 0
		MOV dl, bh
		PUSH dx

		JMP BCD_ADD

	ADJUST:
		ADD bh, 6h			; adjustment
		MOV ah, 0
		MOV al, bh
		DIV R

		MOV dl, ah			; here the representation is 1x. Taking remainder to extract x
		MOV dh, 0
		PUSH dx

		ADD bl, 1			; adding carry
		JMP BCD_ADD

	PRINT:
		POP dx
		CMP dl, '$'
		JE EXIT
		ADD dl, 48
		MOV ah, 02h
		INT 21h
		JMP PRINT

	EXIT:
		MOV ah, 4ch
		INT 21h
MAIN ENDP
END MAIN