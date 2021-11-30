; Fuchsia
FuchsiaCashierText::
	TX_MART ULTRA_BALL,GREAT_BALL,HYPER_POTION,REVIVE,FULL_HEAL,SUPER_REPEL
	
	TX_MART GREAT_BALL,HYPER_POTION,SUPER_POTION,FULL_HEAL,REVIVE

FuchsiaMart_Script:
	call EnableAutoTextBoxDrawing
	ret

FuchsiaMart_TextPointers:
	dw FuchsiaCashierText
	dw FuchsiaMartText2
	dw FuchsiaMartText3

FuchsiaMartText2:
	TX_FAR _FuchsiaMartText2
	db "@"

FuchsiaMartText3:
	TX_FAR _FuchsiaMartText3
	db "@"
