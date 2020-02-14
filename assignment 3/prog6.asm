.MODEL small
.STACK 100h
.DATA
	FILE			db "file36.txt", 0				; folders must be present initially
	MSG				db "Pied Piper"					; msg to be written
	SUCCESS_C		db "File created successfully.", 10, 13, '$'
	SUCCESS_W		db "Written in file successfully.$", 10, 13, '$'
	CREATION_ERR	db "Couldn't create file.", 10, 13, '$'
	WRITING_ERR		db "Couldn't write in file.", 10, 13, '$'
.CODE
MAIN PROC
	MOV ax, @data
	MOV ds, ax

	MOV ah, 3ch								; AX = 3C00H - For creating/truncating file
	LEA dx, FILE
	MOV cl, 0								; normal file
	INT 21h

	JC CREATION_ERR_BLOCK					; successfully created if carry not set otherwise print error message
	MOV bx, ax								; moving file handle to bx
	LEA dx, SUCCESS_C
	MOV ah, 09h
	INT 21h

	LEA dx, MSG								; message to be witten
	MOV cx, 10
	MOV ah, 40h								; AX = 4000H - For writing to file. File handler at BX
	INT 21h

	JC WRITING_ERR_BLOCK					; successfully written if carry not set otherwise print error message
	LEA dx, SUCCESS_W
	MOV ah, 09h
	INT 21h
	JMP EXIT

	CREATION_ERR_BLOCK:
		LEA dx, CREATION_ERR
		MOV ah, 09h
		INT 21h
		JMP EXIT
	
	WRITING_ERR_BLOCK:
		LEA dx, WRITING_ERR
		MOV ah, 09h
		INT 21h
		JMP EXIT

	EXIT:
		MOV ah, 4ch
		INT 21h
MAIN ENDP
END MAIN