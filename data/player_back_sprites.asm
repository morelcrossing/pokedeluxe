PlayerBackSpritesPointerTable:
	; SPRITE_P_RED
	dw RedPicBack
	db $fa ; byte count
	db BANK(RedPicBack)

	; SPRITE_P_BLUE
	dw BluePicBack
	db $fa ; byte count
	db BANK(BluePicBack)
	
	; SPRITE_P_ROCKET
	dw RocketPicBack
	db $fa ; byte count
	db BANK(RocketPicBack)
