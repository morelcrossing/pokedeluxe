; Cinnabar
CinnabarCashierText::
	TX_MART ULTRA_BALL,GREAT_BALL,HYPER_POTION,MAX_REPEL,ESCAPE_ROPE,FULL_HEAL,REVIVE

CinnabarMart_Script:
	jp EnableAutoTextBoxDrawing

CinnabarMart_TextPointers:
	dw CinnabarCashierText
	dw CinnabarMartText2
	dw CinnabarMartText3

CinnabarMartText2:
	TX_FAR _CinnabarMartText2
	db "@"

CinnabarMartText3:
	TX_FAR _CinnabarMartText3
	db "@"
