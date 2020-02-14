.MODEL SMALL
.STACK 100h
.DATA
	msg DB "Shuvam Shah", 10, 13, "$"
	
.CODE
main PROC
	MOV ax, @data
	MOV ds, ax
	
	LEA dx, msg
	MOV ah, 09h
	INT 21h
	
	MOV ah, 4ch
	INT 21h

main ENDP
END main