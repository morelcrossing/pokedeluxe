; Celadon Dept. Store 2F (1)
CeladonMart2Clerk1Text::
	TX_MART GREAT_BALL,SUPER_POTION,REVIVE,SUPER_REPEL,ANTIDOTE,BURN_HEAL,ICE_HEAL,AWAKENING,PARLYZ_HEAL

; Celadon Dept. Store 2F (2)
CeladonMart2Clerk2Text::
	TX_MART TM_32,TM_33,TM_02,TM_07,TM_37,TM_01,TM_05,TM_09,TM_17

CeladonMart2F_Script:
	jp EnableAutoTextBoxDrawing

CeladonMart2F_TextPointers:
	dw CeladonMart2Clerk1Text
	dw CeladonMart2Clerk2Text
	dw CeladonMart2Text3
	dw CeladonMart2Text4
	dw CeladonMart2Text5

CeladonMart2Text3:
	TX_FAR _CeladonMart2Text3
	db "@"

CeladonMart2Text4:
	TX_FAR _CeladonMart2Text4
	db "@"

CeladonMart2Text5:
	TX_FAR _CeladonMart2Text5
	db "@"
