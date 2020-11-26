; Reload all party palettes as indexes may have changed
ReloadPartyPalettes:
	ld a, 0
	ld [wPartyPaletteCounter], a
	ld b, SET_PAL_PARTY_MENU
	call RunBGPPaletteCommand
	ld b, SET_PAL_PARTY_POKEMON1
	call RunOBP0PaletteCommand
	ld b, SET_PAL_PARTY_POKEMON2
	call RunOBP1PaletteCommand
	ret

; Load party pokemon palettes, and reset palette registers
EnablePartyPalettes:
	ld a, 0
	ld [wPartyPaletteCounter], a
	callba BGPSetPalNormal
	ld b, SET_PAL_PARTY_MENU
	call RunBGPPaletteCommand
	call OBP0SetPalNormal
	ld b, SET_PAL_PARTY_POKEMON1
	call RunOBP0PaletteCommand
	call OBP1SetPalNormal
	ld b, SET_PAL_PARTY_POKEMON2
	call RunOBP1PaletteCommand
	ret

RunBGPPaletteCommand:
	ld a, [wOnSGB]
	and a
	ret z
	predef_jump UpdateBGPPaletteCommand
	ret

RunOBP0PaletteCommand:
	ld a, [wOnSGB]
	and a
	ret z
	predef_jump UpdateOBP0PaletteCommand
	ret

RunOBP1PaletteCommand:
	ld a, [wOnSGB]
	and a
	ret z
	predef_jump UpdateOBP1PaletteCommand
	ret
	
ResetOverworldPaletteLoaded:
	ld a, 0
	ld [wOverworldPaletteLoaded + 6], a
	ret

LoadOverworldPalettes:
	call LoadOverworldBGPPalette
	call ReloadFadeBGPPalette
	call LoadOverworldOBP0Palette
	call LoadOverworldOBP1Palette
	call ReloadFadeOBPPalette
	ld a, 1
	ld [wOverworldPaletteLoaded + 6], a
	ret
	
UpdateOverworldPalettes:
	ld a, [wOnSGB]
	and a
	ret z
	call UpdateOverworldBGPPalette
	call UpdateOverworldOBP0Palette
	call UpdateOverworldOBP1Palette
	ret

LoadOverworldBGPPalette:
	ld a, [wOnSGB]
	and a
	ret z
	ld a, [wOverworldPaletteLoaded + 6]
	and a
	ret nz
	call UpdateOverworldBGPPalette
	ret

LoadOverworldOBP0Palette:
	ld a, [wOnSGB]
	and a
	ret z
	ld a, [wOverworldPaletteLoaded + 6]
	and a
	ret nz
	call UpdateOverworldOBP0Palette
	ret

LoadOverworldOBP1Palette:
	ld a, [wOnSGB]
	and a
	ret z
	ld a, [wOverworldPaletteLoaded + 6]
	and a
	ret nz
	call UpdateOverworldOBP1Palette
	ret
	
UpdateOverworldBGPPalette:
	ld b, SET_PAL_OVERWORLD
	predef_jump UpdateBGPPaletteCommand
	ret

UpdateOverworldOBP0Palette:
	ld b, SET_PAL_SPRITES
	predef_jump UpdateOBP0PaletteCommand
	ret

UpdateOverworldOBP1Palette:
	ld b, SET_PAL_SPRITES
	predef_jump UpdateOBP1PaletteCommand
	ret

BGPSetPalNormal:
; Reset BGP for the party.
	ld a, %11100100 ; 3210
	ld [rBGP], a
	ret

OBP0SetPalNormal:
; Reset OBP for the party.
	ld a, %11100100 ; 3210
	ld [rOBP0], a
	ret

OBP1SetPalNormal:
; Reset OBP for the party.
	ld a, %11100100 ; 3210
	ld [rOBP1], a
	ret
	
ReloadFadeBGPPalette:
	ld a, [wMapPalOffset] ; tells if wCurMap is dark (requires HM5_FLASH?)
	ld b, a
	ld hl, FadePal4
	ld a, l
	sub b
	ld l, a
	jr nc, .ok
	dec h
.ok
	ld a, [hli]
	ld [rBGP], a
	ld a, [hli]
	;ld [rOBP0], a
	ld a, [hli]
	;ld [rOBP1], a
	call UpdateGBCPal_BGP
	ret

ReloadFadeOBPPalette:
	ld a, [wMapPalOffset] ; tells if wCurMap is dark (requires HM5_FLASH?)
	ld b, a
	ld hl, FadePal4
	ld a, l
	sub b
	ld l, a
	jr nc, .ok
	dec h
.ok
	ld a, [hli]
	;ld [rBGP], a
	ld a, [hli]
	ld [rOBP0], a
	ld a, [hli]
	ld [rOBP1], a
	call UpdateGBCPal_OBP0
	call UpdateGBCPal_OBP1
	ret

IgnoreInputForHalfSecond:
	ld a, 30
	ld [wIgnoreInputCounter], a
	ld hl, wd730
	ld a, [hl]
	or %00100110
	ld [hl], a ; set ignore input bit
	ret

UpdateBGPFade:
	push af
	ld a, [hGBC]
	and a
	jr z, .notGBC
	push bc
	push de
	push hl
	ld a, [rBGP]
	ld b, a
	ld a, [wLastBGP]
	cp b
	jr z, .noChangeInBGP
	callba _UpdateGBCPal_BGP
.noChangeInBGP
	pop hl
	pop de
	pop bc
.notGBC
	pop af
	ret
