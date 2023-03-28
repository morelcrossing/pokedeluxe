PlayerSpriteSheetPointerTable:
	; SPRITE_P_RED
	dw PlayerRedSprite
	db $c0 ; byte count
	db BANK(PlayerRedSprite)

	; SPRITE_P_BLUE
	dw PlayerBlueSprite
	db $c0 ; byte count
	db BANK(PlayerBlueSprite)
	
	; SPRITE_P_ROCKET
	dw PlayerRocketSprite
	db $c0 ; byte count
	db BANK(PlayerRocketSprite)
