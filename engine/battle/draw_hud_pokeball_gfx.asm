DrawAllPokeballs:
	call LoadPartyPokeballGfx
	call SetupOwnPartyPokeballs
	ld a, [wBattleState]
	dec a
	ret z ; return if wild pokémon
	jp SetupEnemyPartyPokeballs

DrawEnemyPokeballs:
	call LoadPartyPokeballGfx
	jp SetupEnemyPartyPokeballs

LoadPartyPokeballGfx:
	ld de, PokeballTileGraphics
	ld hl, vSprites + $310
	lb bc, BANK(PokeballTileGraphics), (PokeballTileGraphicsEnd - PokeballTileGraphics) / $10
	jp CopyVideoData

SetupOwnPartyPokeballs:
	call PlacePlayerHUDTiles
	ld hl, wPartyMon1
	ld de, wPartyCount
	call SetupPokeballs
	ld a, $60
	ld hl, wBaseCoordX
	ld [hli], a
	ld [hl], a
	ld a, 8
	ld [wHUDPokeballGfxOffsetX], a
	xor a
	ld [wdef5], a
	ld hl, wOAMBuffer
	jp WritePokeballOAMData

SetupEnemyPartyPokeballs:
	call PlaceEnemyHUDTiles
	ld hl, wEnemyMons
	ld de, wEnemyPartyCount
	call SetupPokeballs
	ld hl, wBaseCoordX
	ld a, $48
	ld [hli], a
	ld [hl], $20
	ld a, -8
	ld [wHUDPokeballGfxOffsetX], a
	ld a, $1
	ld [wdef5], a
	ld hl, wOAMBuffer + PARTY_LENGTH * 4
	jp WritePokeballOAMData

SetupPokeballs:
	ld a, [de]
	push af
	ld de, wBuffer
	ld c, PARTY_LENGTH
	ld a, $34 ; empty pokeball
.emptyloop
	ld [de], a
	inc de
	dec c
	jr nz, .emptyloop
	pop af
	ld de, wBuffer
.monloop
	push af
	call PickPokeball
	inc de
	pop af
	dec a
	jr nz, .monloop
	ret

PickPokeball:
	inc hl
	ld a, [hli]
	and a
	jr nz, .alive
	ld a, [hl]
	and a
	ld b, $33 ; crossed ball (fainted)
	jr z, .done_fainted
.alive
	inc hl
	inc hl
	ld a, [hl] ; status
	and a
	ld b, $32 ; black ball (status)
	jr nz, .done
	dec b ; regular ball
	jr .done
.done_fainted
	inc hl
	inc hl
.done
	ld a, b
	ld [de], a
	ld bc, wPartyMon2 - wPartyMon1Status
	add hl, bc ; next mon struct
	ret

WritePokeballOAMData:
	ld de, wBuffer
	ld c, PARTY_LENGTH
.loop
	ld a, [wBaseCoordY]
	ld [hli], a
	ld a, [wBaseCoordX]
	ld [hli], a
	ld a, [de]
	ld [hli], a
	ld a, [wdef5]
	ld [hli], a
	ld a, [wBaseCoordX]
	ld b, a
	ld a, [wHUDPokeballGfxOffsetX]
	add b
	ld [wBaseCoordX], a
	inc de
	dec c
	jr nz, .loop
	ret

PlacePlayerHUDTiles:
	coord hl, 9, 8
	ld de, $1
	ld [hl], $CA
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $73
	add hl, bc
	ld [hl], $73
	add hl, bc
	ld [hl], $6F
	add hl, de
	ld [hl], $CD
	add hl, de
	ld [hl], $CE
	ld a, 6
.loop
	add hl, de
	ld [hl], $C0
	dec a
	jr nz, .loop
	add hl, de
	ld [hl], $77
	coord hl, 18, 8
	ld [hl], $C9
	add hl, bc
	add hl, bc
	ld [hl], $CC
	ret

PlaceEnemyHUDTiles:
	coord hl, 1, 1
	ld de, $1
	ld [hl], $CA
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], $73
	add hl, bc
	ld a, $74
	ld [hl], a
	add hl, de
	ld [hl], $CB
	ld a, 7
.loop
	add hl, de
	ld [hl], $76
	dec a
	jr nz, .loop
	add hl, de
	ld [hl], $78
	coord hl, 10, 1
	ld [hl], $C9
	add hl, bc
	ld [hl], $CF
	ret

SetupPlayerAndEnemyPokeballs:
	call LoadPartyPokeballGfx
	ld hl, wPartyMons
	ld de, wPartyCount
	call SetupPokeballs
	ld hl, wBaseCoordX
	ld a, $50
	ld [hli], a
	ld [hl], $40
	ld a, 8
	ld [wHUDPokeballGfxOffsetX], a
	xor a
	ld [wdef5], a
	ld hl, wOAMBuffer
	call WritePokeballOAMData
	ld hl, wEnemyMons
	ld de, wEnemyPartyCount
	call SetupPokeballs
	ld hl, wBaseCoordX
	ld a, $50
	ld [hli], a
	ld [hl], $68
	ld a, $1
	ld [wdef5], a
	ld hl, wOAMBuffer + $18
	jp WritePokeballOAMData

; four tiles: pokeball, black pokeball (status ailment), crossed out pokeball (fainted) and pokeball slot (no mon)
PokeballTileGraphics::
	INCBIN "gfx/pokeball.2bpp"
PokeballTileGraphicsEnd:
