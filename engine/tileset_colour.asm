INCLUDE "data/tileset_palettes.asm"

TilesetPalettePointers:
	dw TilesetPalette_Overworld

LoadCurrentTilesetPalette::
	ld bc, $60
	ld hl, TilesetPalette_Overworld
	ld de, TILESET_PALETTE_DATA
	call CopyData
	ret

CopyMapViewBGMap0::
	ld de, vBGMap0
	call CopyMapViewToVRAM
	ret
	
CopyMapViewBGMap1:
	ld de, vBGMap1
	call CopyMapViewToVRAM
	ret

; copy current map view to VRAM
CopyMapViewToVRAM:
	ld hl, wTileMap
	ld b, 18
.vramCopyLoop
	ld c, 20
.vramCopyInnerLoop
	ld a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, .vramCopyInnerLoop
	
	push hl
	ld a, $01
	ld [rVBK], a
	
	ld a, [hl]
	ld hl, TILESET_PALETTE_DATA
	ld l, a
	ld a, [hl]
	ld [de], a
	
	xor a
	ld [rVBK], a
	pop hl
	
	ld a, [hli]
	ld [de], a
	inc e
	
	dec c
	jr nz, .vramCopyInnerLoop
	ld a, 32 - 20 ; total vram map width in tiles - screen width in tiles
	add e
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
	dec b
	jr nz, .vramCopyLoop
	ei
	ret

; This function redraws a BG row of height 2 or a BG column of width 2.
; One of its main uses is redrawing the row or column that will be exposed upon
; scrolling the BG when the player takes a step. Redrawing only the exposed
; row or column is more efficient than redrawing the entire screen.
; However, this function is also called repeatedly to redraw the whole screen
; when necessary. It is also used in trade animation and elevator code.
RedrawOverworldRowOrColumn::
	ld a, [hRedrawRowOrColumnMode]
	and a
	ret z
	ld b, a
	xor a
	ld [hRedrawRowOrColumnMode], a
	dec b
	jr nz, .redrawRow
.redrawColumn
	ld hl, wRedrawRowOrColumnSrcTiles
	ld a, [hRedrawRowOrColumnDest]
	ld e, a
	ld a, [hRedrawRowOrColumnDest + 1]
	ld d, a
	ld c, SCREEN_HEIGHT
.loop1Pal1
	ld a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, .loop1Pal1
	
	ld a, $01
	ld [rVBK], a
	
	push hl
	ld a, [hl]
	ld hl, TILESET_PALETTE_DATA
	ld l, a
	ld a, [hl]
	ld [de], a
	inc de
	pop hl
.loop1Pal2
	ld a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, .loop1Pal2
	
	push hl
	inc hl
	ld a, [hl]
	ld hl, TILESET_PALETTE_DATA
	ld l, a
	ld a, [hl]
	ld [de], a
	dec de
	pop hl
	
	xor a
	ld [rVBK], a
.loop1Tile
	ld a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, .loop1Tile
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, BG_MAP_WIDTH - 1
	add e
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
; the following 4 lines wrap us from bottom to top if necessary
	ld a, d
	and $03
	or $98
	ld d, a
	dec c
	jr nz, .loop1Pal1
	xor a
	ld [hRedrawRowOrColumnMode], a
	ret
.redrawRow
	ld hl, wRedrawRowOrColumnSrcTiles
	ld a, [hRedrawRowOrColumnDest]
	ld e, a
	ld a, [hRedrawRowOrColumnDest + 1]
	ld d, a
	push de
	call .DrawHalf ; draw upper half
	pop de
	ld a, BG_MAP_WIDTH ; width of VRAM background map
	add e
	ld e, a
	; fall through and draw lower half

.DrawHalf
	ld c, SCREEN_WIDTH / 2
.loop2Pal1
	ld a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, .loop2Pal1
	
	ld a, $01
	ld [rVBK], a
	
	push hl
	ld a, [hl]
	ld hl, TILESET_PALETTE_DATA
	ld l, a
	ld a, [hl]
	ld [de], a
	inc de
	pop hl
.loop2Pal2
	ld a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, .loop2Pal2
	push hl
	inc hl
	ld a, [hl]
	ld hl, TILESET_PALETTE_DATA
	ld l, a
	ld a, [hl]
	ld [de], a
	dec de
	pop hl
	
	xor a
	ld [rVBK], a
.loop2Tile
	ld a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, .loop2Tile
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, e
	inc a
; the following 6 lines wrap us from the right edge to the left edge if necessary
	and $1f
	ld b, a
	ld a, e
	and $e0
	or b
	ld e, a
	dec c
	jr nz, .loop2Pal1
	ret

TransferBgRowsNew::
	rept $0A
	pop de
	
	call WaitUntilVblank
	push de
	pop de
	ld a, e
	ldi [hl], a
	
	call WaitUntilVblank
	push de
	pop de
	ld a, d
	ldi [hl], a
	endr
	
	add sp, -20
	ld a, l
	sub 20
	ld l, a
	ld a, h
	sbc 0
	ld h, a
	ld a, $01
	ld [rVBK], a
	
	;rept $0A
	;pop de
	;call WaitUntilVblank de being changed is causing the stack value to be overwritten
	;push de
	;ld d, $d0
	;ld a, [de]
	;ldi [hl], a
	;pop de
	;call CheckPaletteID
	;push de
	
	;pop de
	;call WaitUntilVblank
	;push de
	;ld e, d
	;ld d, $d0
	;ld a, [de]
	;ldi [hl], a
	;pop de
	;call CheckPaletteID
	;push de
	;add sp, 2
	;endr
	
	
	
	
	
	rept $0A
	pop de
	call LoadTilePalette
	push de
	add sp, 2
	endr
	
	
	
	
	xor a
	ld [rVBK], a
	
	dec hl
	ld a, 32 - (20 - 1)
	add l
	ld l, a
	jr nc, .ok
	inc h
.ok
	dec b
	jp nz, TransferBgRowsNew

	ld a, [H_SPTEMP]
	ld l, a
	ld a, [H_SPTEMP + 1]
	ld h, a
	ld sp, hl
	ret
	
WaitUntilVblank:
	ld a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, WaitUntilVblank
	ret

CheckPaletteID:
	ld a, e
	cp $60
	jr nc, .notMapTile
	ld d, $d0
	ld a, [de]
	ldi [hl], a
	ret
.notMapTile
	ld a, $06
	ldi [hl], a
	ret

LoadTilePalette:
	ld c, d
	ld d, $d0
.waitPalVBlank1
	ld a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, .waitPalVBlank1

	;pop de
	;call WaitUntilVblank
	;push de
	;ld d, $d0
	;ld a, [de]
	;ldi [hl], a
	;pop de
	;call CheckPaletteID
	;push de
	
	
	ld a, e
	cp $60
	jr nc, .notMapTile1
	ld a, [de]
	ldi [hl], a
	jr .waitPalVBlank2
.notMapTile1
	ld a, $06
	ldi [hl], a
.waitPalVBlank2
	ld a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, .waitPalVBlank2
	
	;pop de
	;call WaitUntilVblank
	;push de
	
	
	ld a, e
	ld e, c
	ld c, a
	;ld d, $d0
	;ld a, [de]
	;ldi [hl], a
	
	;pop de
	;call CheckPaletteID
	;push de
	
	ld a, e
	cp $60
	jr nc, .notMapTile2
	ld a, [de]
	jr .finishTiles
.notMapTile2
	ld a, $06
.finishTiles
	ldi [hl], a
	ld d, e
	ld e, c
	ret
