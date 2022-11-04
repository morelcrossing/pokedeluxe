LoadFilemenuPalette:
	ld b, SET_PAL_PARTY_MENU
	call RunBGPPaletteCommand
	ld b, SET_PAL_PARTY_MENU2
	call RunBGP2PaletteCommand
	ret

; Reload all party OBP palettes as indexes may have changed
ReloadPartyMonPalettes:
	ld a, 0
	ld [wPartyPaletteCounter], a
	ld b, SET_PAL_PARTY_POKEMON1
	call RunOBP0PaletteCommand
	ld b, SET_PAL_PARTY_POKEMON2
	call RunOBP1PaletteCommand
	ret

ReloadPartyBGP:
	ld b, SET_PAL_PARTY_MENU
	call RunBGPPaletteCommand
	ld b, SET_PAL_PARTY_MENU2
	call RunBGP2PaletteCommand
	ret

; Load party pokemon palettes, and reset palette registers
EnablePartyPalettes:
	ld a, 0
	ld [wPartyPaletteCounter], a
	ld a, [wPartyBGPLoaded]
	cp 0
	jr z, .loadBGP
.loadOBP
	call OBP0SetPalNormal
	ld b, SET_PAL_PARTY_POKEMON1
	call RunOBP0PaletteCommand
	call OBP1SetPalNormal
	ld b, SET_PAL_PARTY_POKEMON2
	call RunOBP1PaletteCommand
	ret
.loadBGP
	call BGPSetPalNormal
	ld b, SET_PAL_PARTY_MENU
	ld a, $02
	ld [wShowOverworld], a
	call RunBGPPaletteCommand
	ld b, SET_PAL_PARTY_MENU2
	call RunBGP2PaletteCommand
	jr .loadOBP

RunBGPPaletteCommand:
	ld a, [wOnSGB]
	and a
	ret z
	predef_jump UpdateBGPPaletteCommand
	ret
	
RunBGP2PaletteCommand:
	ld a, [wOnSGB]
	and a
	ret z
	predef_jump UpdateBGP2PaletteCommand
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
	ld [wOverworldPaletteLoaded], a
	ret

LoadOverworldPalettes:
	call ReloadFadeBGPPalette
	call LoadOverworldBGPPalette
	call LoadOverworldBGP2Palette
	call LoadOverworldOBP0Palette
	call LoadOverworldOBP1Palette
	call ReloadFadeOBPPalette
	ld a, 1
	ld [wOverworldPaletteLoaded], a
	ret
	
UpdateOverworldPalettes:
	ld a, [wOnSGB]
	and a
	ret z
	call UpdateOverworldBGPPalette
	call UpdateOverworldBGP2Palette
	call UpdateOverworldOBP0Palette
	call UpdateOverworldOBP1Palette
	ret

LoadOverworldBGPPalette:
	ld a, [wOnSGB]
	and a
	ret z
	ld a, [wOverworldPaletteLoaded]
	and a
	ret nz
	call UpdateOverworldBGPPalette
	ret

LoadOverworldBGP2Palette:
	ld a, [wOnSGB]
	and a
	ret z
	ld a, [wOverworldPaletteLoaded]
	and a
	ret nz
	call UpdateOverworldBGP2Palette
	ret

LoadOverworldOBP0Palette:
	ld a, [wOnSGB]
	and a
	ret z
	ld a, [wOverworldPaletteLoaded]
	and a
	ret nz
	call UpdateOverworldOBP0Palette
	ret

LoadOverworldOBP1Palette:
	ld a, [wOnSGB]
	and a
	ret z
	ld a, [wOverworldPaletteLoaded]
	and a
	ret nz
	call UpdateOverworldOBP1Palette
	ret
	
UpdateOverworldBGPPalette:
	ld b, SET_PAL_OVERWORLD_COLOUR1
	predef_jump UpdateBGPPaletteCommand
	ret

UpdateOverworldBGP2Palette:
	ld b, SET_PAL_OVERWORLD_COLOUR2
	predef_jump UpdateBGP2PaletteCommand
	ret

UpdateOverworldOBP0Palette:
	ld b, SET_PAL_SPRITES
	predef_jump UpdateOBP0PaletteCommand
	ret

UpdateOverworldOBP1Palette:
	ld b, SET_PAL_SPRITES
	predef_jump UpdateOBP1PaletteCommand
	ret

UpdateBattleBGP2Palette:
	ld b, SET_PAL_PARTY_MENU2
	predef_jump UpdateBGP2PaletteCommand
	ret

BGPSetPalNormal:
; Reset BGP for the party.
	ld a, 1
	ld [wPartyBGPLoaded], a
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

HandlePartyMenuInputPokemonSelection:
	ld a, [H_DOWNARROWBLINKCNT1]
	push af
	ld a, [H_DOWNARROWBLINKCNT2]
	push af ; save existing values on stack
	xor a
	ld [H_DOWNARROWBLINKCNT1], a ; blinking down arrow timing value 1
	ld a, 6
	ld [H_DOWNARROWBLINKCNT2], a ; blinking down arrow timing value 2
.loop1
	xor a
	ld [wAnimCounter], a ; counter for pokemon shaking animation
	callba PlacePartyMenuCursor
	call Delay3
.loop2
	push hl
	ld a, [wPartyMenuAnimMonEnabled]
	and a ; is it a pokemon selection menu?
	jr z, .getJoypadState
	callba AnimatePartyMon ; shake mini sprite of selected pokemon
.getJoypadState
	pop hl
	call JoypadLowSensitivity
	ld a, [hJoy5]
	and a ; was a key pressed?
	jr nz, .keyPressed
	push hl
	coord hl, 18, 11 ; coordinates of blinking down arrow in some menus
	call HandleDownArrowBlinkTiming ; blink down arrow (if any)
	pop hl
	ld a, [wMenuJoypadPollCount]
	dec a
	jr z, .giveUpWaiting
	jr .loop2
.giveUpWaiting
; if a key wasn't pressed within the specified number of checks
	pop af
	ld [H_DOWNARROWBLINKCNT2], a
	pop af
	ld [H_DOWNARROWBLINKCNT1], a ; restore previous values
	xor a
	ld [wMenuWrappingEnabled], a ; disable menu wrapping
	ret
.keyPressed
	xor a
	ld [wCheckFor180DegreeTurn], a
	ld a, [hJoy5]
	ld b, a
	bit 0, a ; pressed A key?
	jr nz, .checkOtherKeys
	bit 6, a ; pressed Up key?
	jr z, .checkIfDownPressed
.upPressed
	ld a, [wCurrentMenuItem] ; selected menu item
	and a ; already at the top of the menu?
	jr z, .alreadyAtTop
.notAtTop
	dec a
	ld [wCurrentMenuItem], a ; move selected menu item up one space
	jr .checkOtherKeys
.alreadyAtTop
	ld a, [wMenuWrappingEnabled]
	and a ; is wrapping around enabled?
	jr z, .noWrappingAround
	ld a, [wMaxMenuItem]
	ld [wCurrentMenuItem], a ; wrap to the bottom of the menu
	jr .checkOtherKeys
.checkIfDownPressed
	bit 7, a
	jr z, .checkOtherKeys
.downPressed
	ld a, [wCurrentMenuItem]
	inc a
	ld c, a
	ld a, [wMaxMenuItem]
	cp c
	jr nc, .notAtBottom
.alreadyAtBottom
	ld a, [wMenuWrappingEnabled]
	and a ; is wrapping around enabled?
	jr z, .noWrappingAround
	ld c, $00 ; wrap from bottom to top
.notAtBottom
	ld a, c
	ld [wCurrentMenuItem], a
.checkOtherKeys
	ld a, [wMenuWatchedKeys]
	and b ; does the menu care about any of the pressed keys?
	jp z, .loop1
.checkIfAButtonOrBButtonPressed
	ld a, [hJoy5]
	and A_BUTTON | B_BUTTON
	jr z, .skipPlayingSound
.AButtonOrBButtonPressed
	push hl
	ld hl, wFlags_0xcd60
	bit 5, [hl]
	pop hl
	jr nz, .skipPlayingSound
	ld a, SFX_PRESS_AB
	call PlaySound
.skipPlayingSound
	pop af
	ld [H_DOWNARROWBLINKCNT2], a
	pop af
	ld [H_DOWNARROWBLINKCNT1], a ; restore previous values
	xor a
	ld [wMenuWrappingEnabled], a ; disable menu wrapping
	ld a, [hJoy5]
	ret
.noWrappingAround
	ld a, [wMenuWatchMovingOutOfBounds]
	and a ; should we return if the user tried to go past the top or bottom?
	jr z, .checkOtherKeys
	jr .checkIfAButtonOrBButtonPressed

PlacePartyMenuCursor:
	;ld a, [wTopMenuItemY]
	;and a ; is the y coordinate 0?
	;jr z, .adjustForXCoord
	ld a, 0
	coord hl, 0, 0
	ld bc, SCREEN_WIDTH
;.topMenuItemLoop
	;add hl, bc
	;dec a
	;jr nz, .topMenuItemLoop
.adjustForXCoord
	ld a, [wTopMenuItemX]
	ld b, 0
	ld c, a
	add hl, bc
	push hl
	ld a, [wLastMenuItem]
	and a ; was the previous menu id 0?
	jr z, .checkForArrow1
	ld bc, 40
	push af
	ld a, [hFlags_0xFFFA]
	bit 1, a ; is the menu double spaced?
	jr z, .doubleSpaced1
	ld bc, 20
.doubleSpaced1
	pop af
.oldMenuItemLoop
	add hl, bc
	dec a
	jr nz, .oldMenuItemLoop
.checkForArrow1
	ld a, [hl]
	cp $DE ; was an arrow next to the previously selected menu item?
	jr nz, .skipClearingArrow
.clearArrow
	ld a, $7F
	ld bc, SCREEN_WIDTH
	ld [hl], a
	push hl
	add hl, bc
	ld a, $DA
	ld [hl], a
	pop hl
.skipClearingArrow
	pop hl
	ld a, [wCurrentMenuItem]
	and a
	jr z, .checkForArrow2
	ld bc, 40
	push af
	ld a, [hFlags_0xFFFA]
	bit 1, a ; is the menu double spaced?
	jr z, .doubleSpaced2
	ld bc, 20
.doubleSpaced2
	pop af
.currentMenuItemLoop
	add hl, bc
	dec a
	jr nz, .currentMenuItemLoop
.checkForArrow2
	ld a, [hl]
	cp $DE ; has the right arrow already been placed?
	jr z, .skipSavingTile ; if so, don't lose the saved tile
	ld [wTileBehindCursor], a ; save tile before overwriting with right arrow
.skipSavingTile
	ld a, $DE ; place right arrow
	ld bc, SCREEN_WIDTH
	ld [hl], a
	push hl
	add hl, bc
	ld a, $DF ; place right arrow
	ld [hl], a
	pop hl
	ld a, l
	ld [wMenuCursorLocation], a
	ld a, h
	ld [wMenuCursorLocation + 1], a
	ld a, [wCurrentMenuItem]
	ld [wLastMenuItem], a
	ret

; This is used to mark a menu cursor other than the one currently being
; manipulated. In the case of submenus, this is used to show the location of
; the menu cursor in the parent menu. In the case of swapping items in list,
; this is used to mark the item that was first chosen to be swapped.
PlaceUnfilledPartyMenuCursor:
	ld b, a
	ld a, [wMenuCursorLocation]
	ld l, a
	ld a, [wMenuCursorLocation + 1]
	ld h, a
	ld [hl], $DC
	ld a, b
	ld a, $DD
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hl], a
	ret
	
ApplyTextboxPalette:
	di
	ld a, $1
	ld [rVBK], a
	ld a, [wTextboxXOffset]
	ld h, a
	ld a, [wTextboxYOffset]
	ld l, a
	ld a, [wTextboxWidth]
	ld b, a
	ld a, [wTextboxHeight]
	ld c, a
	inc b
	inc b
	inc c
	inc c
.loop ; for each row of the textbox
	push hl
	ld e, c
	call SetTilePalette
	pop hl
	ld de, $20
	add hl, de
	dec b
	jr nz, .loop
.done
	call Func_3082
	ld a, [rIF]
	res VBLANK, a
	ld [rIF], a
	xor a
	ld [rVBK], a
	ei
	ret

SetTilePalette:
	ld a, [rSTAT]
	and %10 ; are we in HBlank or VBlank?
	jr nz, SetTilePalette
.applyTile
	ld a, $06
	ld [hli], a
	dec e
	jr nz, SetTilePalette
	ret

ZeroSpriteStateData::
; zero C110-C1EF and C210-C2EF
; C1F0-C1FF and C2F0-C2FF is used for Pikachu
	ld hl, wSpriteStateData1 + $10
	ld de, wSpriteStateData2 + $10
	xor a
	ld b, 14 * $10
.loop
	ld [hli], a
	ld [de], a
	inc e
	dec b
	jr nz, .loop
	ret

IsFightingJessieJames::
	ld a, [wTrainerClass]
	cp ROCKET
	ret nz
	ld a, [wTrainerNo]
	cp $2a
	ret c
	ld de, JessieJamesPic
	cp $2e
	jr c, .dummy
	ld de, JessieJamesPic ; possibly meant to add another pic
.dummy
	ld hl, wTrainerPicPointer
	ld a, e
	ld [hli], a
	ld [hl], d
	ret

; overwrites sprite data with zeroes
ResetPlayerSpriteData_ClearSpriteData::
	ld bc, $10
	xor a
	call FillMemory
	ret

SerialFunction::
	ld a, [wPrinterConnectionOpen]
	bit 0, a
	ret z
	ld a, [wPrinterOpcode]
	and a
	ret nz
	ld hl, wOverworldMap + 650
	inc [hl]
	ld a, [hl]
	cp $6
	ret c
	xor a
	ld [hl], a
	ld a, $0c
	ld [wPrinterOpcode], a
	ld a, $88
	ld [rSB], a
	ld a, $1
	ld [rSC], a
	ld a, START_TRANSFER_INTERNAL_CLOCK
	ld [rSC], a
	ret

StepCountCheck::
	ld a, [wd730]
	bit 7, a
	jr nz, .doneStepCounting ; if button presses are being simulated, don't count steps
; step counting
	ld hl, wStepCounter
	dec [hl]
	ld a, [wd72c]
	bit 0, a
	jr z, .doneStepCounting
	ld hl, wNumberOfNoRandomBattleStepsLeft
	dec [hl]
	jr nz, .doneStepCounting
	ld hl, wd72c
	res 0, [hl] ; indicate that the player has stepped thrice since the last battle
.doneStepCounting
	ret
