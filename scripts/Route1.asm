Route1_Script:
	call EnableAutoTextBoxDrawing
	ret

Route1_TextPointers:
	dw Route1Text1
	dw Route1Text2
	dw Route1Text3

Route1Text1:
	TX_ASM
	callba Func_f1ad2
	jp TextScriptEnd

Route1Text2:
	TX_ASM
	callba Func_f1b0f
	jp TextScriptEnd

Route1Text3:
	TX_ASM
	callba Func_f1b1b
	jp TextScriptEnd
