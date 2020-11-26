LoadFollowSprite:
	call LoadStillFollowSprite
	call LoadWalkingFollowSprite
	ret
	
LoadStillFollowSprite:
	ld a, [wFontLoaded]
	bit 0, a ; reloading upper half of tile patterns after displaying text?
	ret nz ; if so, skip loading data into the lower half
	call ReadFollowSpriteSheetData
	ret nc
	ld hl, $80C0
	call CopyVideoDataAlternate ; new yellow function
	ret

LoadWalkingFollowSprite:
	call ReadFollowSpriteSheetData
	ret nc
	ld hl, $c0
	add hl, de
	ld d, h
	ld e, l
	ld hl, $88C0
	call CopyVideoDataAlternate
	ret

ReadFollowSpriteSheetData:
	ld a, [wPartySpecies]
	ld [wd11e], a
	push de
	predef IndexToPokedex
	pop de
	ld a, [wd11e]
	;ld a, 7
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, FollowSpriteSheetPointerTable
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld c, [hl]
	swap c ; get the number of tiles, not the raw byte length
		   ; this is because of the use of CopyVideoDataAlternate
	inc hl
	ld b, [hl]
	inc hl
	scf
	ret

FollowSpriteSheetPointerTable:
	; SPRITE_F_BULBASAUR
	dw FollowBulbasaur
	db $c0 ; byte count
	db BANK(FollowBulbasaur)

	; SPRITE_F_IVYSAUR
	dw FollowIvysaur
	db $c0 ; byte count
	db BANK(FollowIvysaur)

	; SPRITE_F_VENUSAUR
	dw FollowVenusaur
	db $c0 ; byte count
	db BANK(FollowVenusaur)

	; SPRITE_F_CHARMANDER
	dw FollowCharmander
	db $c0 ; byte count
	db BANK(FollowCharmander)

	; SPRITE_F_CHARMELEON
	dw FollowCharmeleon
	db $c0 ; byte count
	db BANK(FollowCharmeleon)

	; SPRITE_F_CHARIZARD
	dw FollowCharizard
	db $c0 ; byte count
	db BANK(FollowCharizard)

	; SPRITE_F_SQUIRTLE 
	dw FollowSquirtle
	db $c0 ; byte count
	db BANK(FollowSquirtle)

	; SPRITE_F_WARTORTLE
	dw FollowWartortle
	db $c0 ; byte count
	db BANK(FollowWartortle)

	; SPRITE_F_BLASTOISE
	dw FollowBlastoise
	db $c0 ; byte count
	db BANK(FollowBlastoise)

	; SPRITE_F_CATERPIE
	dw FollowCaterpie
	db $c0 ; byte count
	db BANK(FollowCaterpie)

	; SPRITE_F_METAPOD
	dw FollowMetapod
	db $c0 ; byte count
	db BANK(FollowMetapod)

	; SPRITE_F_BUTTERFREE
	dw FollowButterfree
	db $c0 ; byte count
	db BANK(FollowButterfree)

	; SPRITE_F_WEEDLE
	dw FollowWeedle
	db $c0 ; byte count
	db BANK(FollowWeedle)

	; SPRITE_F_KAKUNA
	dw FollowKakuna
	db $c0 ; byte count
	db BANK(FollowKakuna)

	; SPRITE_F_BEEDRILL
	dw FollowBeedrill
	db $c0 ; byte count
	db BANK(FollowBeedrill)

	; SPRITE_F_PIDGEY
	dw FollowPidgey
	db $c0 ; byte count
	db BANK(FollowPidgey)

	; SPRITE_F_PIDGEOTTO
	dw FollowPidgeotto
	db $c0 ; byte count
	db BANK(FollowPidgeotto)

	; SPRITE_F_PIDGEOT
	dw FollowPidgeot
	db $c0 ; byte count
	db BANK(FollowPidgeot)

	; SPRITE_F_RATTATA
	dw FollowRattata
	db $c0 ; byte count
	db BANK(FollowRattata)

	; SPRITE_F_RATICATE
	dw FollowRaticate
	db $c0 ; byte count
	db BANK(FollowRaticate)

	; SPRITE_F_SPEAROW
	dw FollowSpearow
	db $c0 ; byte count
	db BANK(FollowSpearow)

	; SPRITE_F_FEAROW
	dw FollowFearow
	db $c0 ; byte count
	db BANK(FollowFearow)

	; SPRITE_F_EKANS
	dw FollowEkans
	db $c0 ; byte count
	db BANK(FollowEkans)

	; SPRITE_F_ARBOK
	dw FollowArbok
	db $c0 ; byte count
	db BANK(FollowArbok)

	; SPRITE_F_PIKACHU
	dw FollowPikachu
	db $c0 ; byte count
	db BANK(FollowPikachu)

	; SPRITE_F_RAICHU
	dw FollowRaichu
	db $c0 ; byte count
	db BANK(FollowRaichu)

	; SPRITE_F_SANDSHREW
	dw FollowSandshrew
	db $c0 ; byte count
	db BANK(FollowSandshrew)

	; SPRITE_F_SANDSLASH
	dw FollowSandslash
	db $c0 ; byte count
	db BANK(FollowSandslash)

	; SPRITE_F_NIDORAN_F
	dw FollowNidoranf
	db $c0 ; byte count
	db BANK(FollowNidoranf)

	; SPRITE_F_NIDORINA
	dw FollowNidorina
	db $c0 ; byte count
	db BANK(FollowNidorina)

	; SPRITE_F_NIDOQUEEN
	dw FollowNidoqueen
	db $c0 ; byte count
	db BANK(FollowNidoqueen)

	; SPRITE_F_NIDORAN_M
	dw FollowNidoranm
	db $c0 ; byte count
	db BANK(FollowNidoranm)

	; SPRITE_F_NIDORINO
	dw FollowNidorino
	db $c0 ; byte count
	db BANK(FollowNidorino)

	; SPRITE_F_NIDOKING
	dw FollowNidoking
	db $c0 ; byte count
	db BANK(FollowNidoking)

	; SPRITE_F_CLEFAIRY
	dw FollowClefairy
	db $c0 ; byte count
	db BANK(FollowClefairy)

	; SPRITE_F_CLEFABLE
	dw FollowClefable
	db $c0 ; byte count
	db BANK(FollowClefable)

	; SPRITE_F_VULPIX
	dw FollowVulpix
	db $c0 ; byte count
	db BANK(FollowVulpix)

	; SPRITE_F_NINETALES
	dw FollowNinetails
	db $c0 ; byte count
	db BANK(FollowNinetails)

	; SPRITE_F_JIGGLYPUFF
	dw FollowJigglypuff
	db $c0 ; byte count
	db BANK(FollowJigglypuff)

	; SPRITE_F_WIGGLYTUFF
	dw FollowWigglytuff
	db $c0 ; byte count
	db BANK(FollowWigglytuff)

	; SPRITE_F_ZUBAT
	dw FollowZubat
	db $c0 ; byte count
	db BANK(FollowZubat)

	; SPRITE_F_GOLBAT
	dw FollowGolbat
	db $c0 ; byte count
	db BANK(FollowGolbat)

	; SPRITE_F_ODDISH
	dw FollowOddish
	db $c0 ; byte count
	db BANK(FollowOddish)

	; SPRITE_F_GLOOM
	dw FollowGloom
	db $c0 ; byte count
	db BANK(FollowGloom)

	; SPRITE_F_VILEPLUME
	dw FollowVileplume
	db $c0 ; byte count
	db BANK(FollowVileplume)

	; SPRITE_F_PARAS
	dw FollowParas
	db $c0 ; byte count
	db BANK(FollowParas)

	; SPRITE_F_PARASECT
	dw FollowParasect
	db $c0 ; byte count
	db BANK(FollowParasect)

	; SPRITE_F_VENONAT
	dw FollowVenonat
	db $c0 ; byte count
	db BANK(FollowVenonat)

	; SPRITE_F_VENOMOTH
	dw FollowVenomoth
	db $c0 ; byte count
	db BANK(FollowVenomoth)

	; SPRITE_F_DIGLETT
	dw FollowDiglett
	db $c0 ; byte count
	db BANK(FollowDiglett)

	; SPRITE_F_DUGTRIO
	dw FollowDugtrio
	db $c0 ; byte count
	db BANK(FollowDugtrio)

	; SPRITE_F_MEOWTH
	dw FollowMeowth
	db $c0 ; byte count
	db BANK(FollowMeowth)

	; SPRITE_F_PERSIAN
	dw FollowPersian
	db $c0 ; byte count
	db BANK(FollowPersian)

	; SPRITE_F_PSYDUCK
	dw FollowPsyduck
	db $c0 ; byte count
	db BANK(FollowPsyduck)

	; SPRITE_F_GOLDUCK
	dw FollowGolduck
	db $c0 ; byte count
	db BANK(FollowGolduck)

	; SPRITE_F_MANKEY
	dw FollowMankey
	db $c0 ; byte count
	db BANK(FollowMankey)

	; SPRITE_F_PRIMEAPE
	dw FollowPrimeape
	db $c0 ; byte count
	db BANK(FollowPrimeape)

	; SPRITE_F_GROWLITHE
	dw FollowGrowlithe
	db $c0 ; byte count
	db BANK(FollowGrowlithe)

	; SPRITE_F_ARCANINE
	dw FollowArcanine
	db $c0 ; byte count
	db BANK(FollowArcanine)

	; SPRITE_F_POLIWAG
	dw FollowPoliwag
	db $c0 ; byte count
	db BANK(FollowPoliwag)

	; SPRITE_F_POLIWHIRL
	dw FollowPoliwhirl
	db $c0 ; byte count
	db BANK(FollowPoliwhirl)

	; SPRITE_F_POLIWRATH
	dw FollowPoliwrath
	db $c0 ; byte count
	db BANK(FollowPoliwrath)

	; SPRITE_F_ABRA
	dw FollowAbra
	db $c0 ; byte count
	db BANK(FollowAbra)

	; SPRITE_F_KADABRA
	dw FollowKadabra
	db $c0 ; byte count
	db BANK(FollowKadabra)

	; SPRITE_F_ALAKAZAM
	dw FollowAlakazam
	db $c0 ; byte count
	db BANK(FollowAlakazam)

	; SPRITE_F_MACHOP
	dw FollowMachop
	db $c0 ; byte count
	db BANK(FollowMachop)

	; SPRITE_F_MACHOKE
	dw FollowMachoke
	db $c0 ; byte count
	db BANK(FollowMachoke)

	; SPRITE_F_MACHAMP
	dw FollowMachamp
	db $c0 ; byte count
	db BANK(FollowMachamp)

	; SPRITE_F_BELLSPROUT
	dw FollowBellsprout
	db $c0 ; byte count
	db BANK(FollowBellsprout)

	; SPRITE_F_WEEPINBELL
	dw FollowWeepinbell
	db $c0 ; byte count
	db BANK(FollowWeepinbell)

	; SPRITE_F_VICTREEBEL
	dw FollowVictreebel
	db $c0 ; byte count
	db BANK(FollowVictreebel)

	; SPRITE_F_TENTACOOL
	dw FollowTentacool
	db $c0 ; byte count
	db BANK(FollowTentacool)

	; SPRITE_F_TENTACRUEL
	dw FollowTentacruel
	db $c0 ; byte count
	db BANK(FollowTentacruel)

	; SPRITE_F_GEODUDE
	dw FollowGeodude
	db $c0 ; byte count
	db BANK(FollowGeodude)

	; SPRITE_F_GRAVELER
	dw FollowGraveler
	db $c0 ; byte count
	db BANK(FollowGraveler)

	; SPRITE_F_GOLEM
	dw FollowGolem
	db $c0 ; byte count
	db BANK(FollowGolem)

	; SPRITE_F_PONYTA
	dw FollowPonyta
	db $c0 ; byte count
	db BANK(FollowPonyta)

	; SPRITE_F_RAPIDASH
	dw FollowRapidash
	db $c0 ; byte count
	db BANK(FollowRapidash)

	; SPRITE_F_SLOWPOKE
	dw FollowSlowpoke
	db $c0 ; byte count
	db BANK(FollowSlowpoke)

	; SPRITE_F_SLOWBRO
	dw FollowSlowbro
	db $c0 ; byte count
	db BANK(FollowSlowbro)

	; SPRITE_F_MAGNEMITE
	dw FollowMagnemite
	db $c0 ; byte count
	db BANK(FollowMagnemite)

	; SPRITE_F_MAGNETON
	dw FollowMagneton
	db $c0 ; byte count
	db BANK(FollowMagneton)

	; SPRITE_F_FARFETCHD
	dw FollowFarfetchd
	db $c0 ; byte count
	db BANK(FollowFarfetchd)

	; SPRITE_F_DODUO
	dw FollowDoduo
	db $c0 ; byte count
	db BANK(FollowDoduo)

	; SPRITE_F_DODRIO
	dw FollowDodrio
	db $c0 ; byte count
	db BANK(FollowDodrio)

	; SPRITE_F_SEEL
	dw FollowSeel
	db $c0 ; byte count
	db BANK(FollowSeel)

	; SPRITE_F_DEWGONG
	dw FollowDewgong
	db $c0 ; byte count
	db BANK(FollowDewgong)

	; SPRITE_F_GRIMER
	dw FollowGrimer
	db $c0 ; byte count
	db BANK(FollowGrimer)

	; SPRITE_F_MUK
	dw FollowMuk
	db $c0 ; byte count
	db BANK(FollowMuk)

	; SPRITE_F_SHELLDER
	dw FollowShellder
	db $c0 ; byte count
	db BANK(FollowShellder)

	; SPRITE_F_CLOYSTER
	dw FollowCloyster
	db $c0 ; byte count
	db BANK(FollowCloyster)

	; SPRITE_F_GASTLY
	dw FollowGastly
	db $c0 ; byte count
	db BANK(FollowGastly)

	; SPRITE_F_HAUNTER
	dw FollowHaunter
	db $c0 ; byte count
	db BANK(FollowHaunter)

	; SPRITE_F_GENGAR
	dw FollowGengar
	db $c0 ; byte count
	db BANK(FollowGengar)

	; SPRITE_F_ONIX
	dw FollowOnix
	db $c0 ; byte count
	db BANK(FollowOnix)

	; SPRITE_F_DROWZEE
	dw FollowDrowzee
	db $c0 ; byte count
	db BANK(FollowDrowzee)

	; SPRITE_F_HYPNO
	dw FollowHypno
	db $c0 ; byte count
	db BANK(FollowHypno)

	; SPRITE_F_KRABBY
	dw FollowKrabby
	db $c0 ; byte count
	db BANK(FollowKrabby)

	; SPRITE_F_KINGLER
	dw FollowKingler
	db $c0 ; byte count
	db BANK(FollowKingler)

	; SPRITE_F_VOLTORB
	dw FollowVoltorb
	db $c0 ; byte count
	db BANK(FollowVoltorb)

	; SPRITE_F_ELECTRODE
	dw FollowElectrode
	db $c0 ; byte count
	db BANK(FollowElectrode)

	; SPRITE_F_EXEGGCUTE
	dw FollowExeggcute
	db $c0 ; byte count
	db BANK(FollowExeggcute)

	; SPRITE_F_EXEGGUTOR
	dw FollowExeggutor
	db $c0 ; byte count
	db BANK(FollowExeggutor)

	; SPRITE_F_CUBONE
	dw FollowCubone
	db $c0 ; byte count
	db BANK(FollowCubone)

	; SPRITE_F_MAROWAK
	dw FollowMarowak
	db $c0 ; byte count
	db BANK(FollowMarowak)

	; SPRITE_F_HITMONLEE
	dw FollowHitmonlee
	db $c0 ; byte count
	db BANK(FollowHitmonlee)

	; SPRITE_F_HITMONCHAN
	dw FollowHitmonchan
	db $c0 ; byte count
	db BANK(FollowHitmonchan)

	; SPRITE_F_LICKITUNG
	dw FollowLickitung
	db $c0 ; byte count
	db BANK(FollowLickitung)

	; SPRITE_F_KOFFING
	dw FollowKoffing
	db $c0 ; byte count
	db BANK(FollowKoffing)

	; SPRITE_F_WEEZING
	dw FollowWeezing
	db $c0 ; byte count
	db BANK(FollowWeezing)

	; SPRITE_F_RHYHORN
	dw FollowRhyhorn
	db $c0 ; byte count
	db BANK(FollowRhyhorn)

	; SPRITE_F_RHYDON
	dw FollowRhydon
	db $c0 ; byte count
	db BANK(FollowRhydon)

	; SPRITE_F_CHANSEY
	dw FollowChansey
	db $c0 ; byte count
	db BANK(FollowChansey)

	; SPRITE_F_TANGELA
	dw FollowTangela
	db $c0 ; byte count
	db BANK(FollowTangela)

	; SPRITE_F_KANGASKHAN
	dw FollowKangaskhan
	db $c0 ; byte count
	db BANK(FollowKangaskhan)

	; SPRITE_F_HORSEA
	dw FollowHorsea
	db $c0 ; byte count
	db BANK(FollowHorsea)

	; SPRITE_F_SEADRA
	dw FollowSeadra
	db $c0 ; byte count
	db BANK(FollowSeadra)

	; SPRITE_F_GOLDEEN
	dw FollowGoldeen
	db $c0 ; byte count
	db BANK(FollowGoldeen)

	; SPRITE_F_SEAKING
	dw FollowSeaking
	db $c0 ; byte count
	db BANK(FollowSeaking)

	; SPRITE_F_STARYU
	dw FollowStaryu
	db $c0 ; byte count
	db BANK(FollowStaryu)

	; SPRITE_F_STARMIE
	dw FollowStarmie
	db $c0 ; byte count
	db BANK(FollowStarmie)

	; SPRITE_F_MR_MIME
	dw FollowMrmime
	db $c0 ; byte count
	db BANK(FollowMrmime)

	; SPRITE_F_SCYTHER
	dw FollowScyther
	db $c0 ; byte count
	db BANK(FollowScyther)

	; SPRITE_F_JYNX
	dw FollowJynx
	db $c0 ; byte count
	db BANK(FollowJynx)

	; SPRITE_F_ELECTABUZZ
	dw FollowElectabuzz
	db $c0 ; byte count
	db BANK(FollowElectabuzz)

	; SPRITE_F_MAGMAR
	dw FollowMagmar
	db $c0 ; byte count
	db BANK(FollowMagmar)

	; SPRITE_F_PINSIR
	dw FollowPinsir
	db $c0 ; byte count
	db BANK(FollowPinsir)

	; SPRITE_F_TAUROS
	dw FollowTauros
	db $c0 ; byte count
	db BANK(FollowTauros)

	; SPRITE_F_MAGIKARP
	dw FollowMagikarp
	db $c0 ; byte count
	db BANK(FollowMagikarp)

	; SPRITE_F_GYARADOS
	dw FollowGyarados
	db $c0 ; byte count
	db BANK(FollowGyarados)

	; SPRITE_F_LAPRAS
	dw FollowLapras
	db $c0 ; byte count
	db BANK(FollowLapras)

	; SPRITE_F_DITTO
	dw FollowDitto
	db $c0 ; byte count
	db BANK(FollowDitto)

	; SPRITE_F_EEVEE
	dw FollowEevee
	db $c0 ; byte count
	db BANK(FollowEevee)

	; SPRITE_F_VAPOREON
	dw FollowVaporeon
	db $c0 ; byte count
	db BANK(FollowVaporeon)

	; SPRITE_F_JOLTEON
	dw FollowJolteon
	db $c0 ; byte count
	db BANK(FollowJolteon)

	; SPRITE_F_FLAREON
	dw FollowFlareon
	db $c0 ; byte count
	db BANK(FollowFlareon)

	; SPRITE_F_PORYGON
	dw FollowPorygon
	db $c0 ; byte count
	db BANK(FollowPorygon)

	; SPRITE_F_OMANYTE
	dw FollowOmanyte
	db $c0 ; byte count
	db BANK(FollowOmanyte)

	; SPRITE_F_OMASTAR
	dw FollowOmastar
	db $c0 ; byte count
	db BANK(FollowOmastar)

	; SPRITE_F_KABUTO
	dw FollowKabuto
	db $c0 ; byte count
	db BANK(FollowKabuto)

	; SPRITE_F_KABUTOPS
	dw FollowKabutops
	db $c0 ; byte count
	db BANK(FollowKabutops)

	; SPRITE_F_AERODACTYL
	dw FollowAerodactyl
	db $c0 ; byte count
	db BANK(FollowAerodactyl)

	; SPRITE_F_SNORLAX
	dw FollowSnorlax
	db $c0 ; byte count
	db BANK(FollowSnorlax)

	; SPRITE_F_ARTICUNO
	dw FollowArticuno
	db $c0 ; byte count
	db BANK(FollowArticuno)

	; SPRITE_F_ZAPDOS
	dw FollowZapdos
	db $c0 ; byte count
	db BANK(FollowZapdos)

	; SPRITE_F_MOLTRES
	dw FollowMoltres
	db $c0 ; byte count
	db BANK(FollowMoltres)

	; SPRITE_F_DRATINI
	dw FollowDratini
	db $c0 ; byte count
	db BANK(FollowDratini)

	; SPRITE_F_DRAGONAIR
	dw FollowDragonair
	db $c0 ; byte count
	db BANK(FollowDragonair)

	; SPRITE_F_DRAGONITE
	dw FollowDragonite
	db $c0 ; byte count
	db BANK(FollowDragonite)

	; SPRITE_F_MEWTWO
	dw FollowMewtwo
	db $c0 ; byte count
	db BANK(FollowMewtwo)

	; SPRITE_F_MEW
	dw FollowMew
	db $c0 ; byte count
	db BANK(FollowMew)
