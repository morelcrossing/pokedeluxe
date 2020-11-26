; monochrome palette color ids
	const_def
	const WHITE
	const LIGHT_GRAY
	const DARK_GRAY
	const BLACK

SET_PAL_BATTLE_BLACK         EQU $00
SET_PAL_BATTLE               EQU $01
SET_PAL_TOWN_MAP             EQU $02
SET_PAL_STATUS_SCREEN        EQU $03
SET_PAL_POKEDEX              EQU $04
SET_PAL_SLOTS                EQU $05
SET_PAL_TITLE_SCREEN         EQU $06
SET_PAL_NIDORINO_INTRO       EQU $07
SET_PAL_GENERIC              EQU $08
SET_PAL_OVERWORLD            EQU $09
SET_PAL_PARTY_MENU           EQU $0A
SET_PAL_POKEMON_WHOLE_SCREEN EQU $0B
SET_PAL_GAME_FREAK_INTRO     EQU $0C
SET_PAL_TRAINER_CARD         EQU $0D
SET_PAL_PARTY_POKEMON1       EQU $10
SET_PAL_PARTY_POKEMON2       EQU $11
SET_PAL_SPRITES              EQU $12
UPDATE_PARTY_MENU_BLK_PACKET EQU $FC

; super game boy palettes
const_value = 0

	const PAL_ROUTE       ; $00
	const PAL_PALLET      ; $01
	const PAL_VIRIDIAN    ; $02
	const PAL_PEWTER      ; $03
	const PAL_CERULEAN    ; $04
	const PAL_LAVENDER    ; $05
	const PAL_VERMILION   ; $06
	const PAL_CELADON     ; $07
	const PAL_FUCHSIA     ; $08
	const PAL_CINNABAR    ; $09
	const PAL_INDIGO      ; $0A
	const PAL_SAFFRON     ; $0B
	const PAL_TOWNMAP     ; $0C
	const PAL_LOGO1       ; $0D
	const PAL_LOGO2       ; $0E
	const PAL_0F          ; $0F
	const PAL_MEWMON      ; $10
	const PAL_BLUEMON     ; $11
	const PAL_REDMON      ; $12
	const PAL_CYANMON     ; $13
	const PAL_PURPLEMON   ; $14
	const PAL_BROWNMON    ; $15
	const PAL_GREENMON    ; $16
	const PAL_PINKMON     ; $17
	const PAL_YELLOWMON   ; $18
	const PAL_GREYMON     ; $19
	const PAL_SLOTS1      ; $1A
	const PAL_SLOTS2      ; $1B
	const PAL_SLOTS3      ; $1C
	const PAL_SLOTS4      ; $1D
	const PAL_BLACK       ; $1E
	const PAL_GREENBAR    ; $1F
	const PAL_YELLOWBAR   ; $20
	const PAL_REDBAR      ; $21
	const PAL_BADGE       ; $22
	const PAL_CAVE        ; $23
	const PAL_GAMEFREAK   ; $24
	const PAL_25          ; $25
	const PAL_26          ; $26
	const PAL_27          ; $27
	const PAL_P_BULBASAUR  ; 1
	const PAL_P_IVYSAUR    ; 2
	const PAL_P_VENUSAUR   ; 3
	const PAL_P_CHARMANDER ; 4
	const PAL_P_CHARMELEON ; 5
	const PAL_P_CHARIZARD  ; 6
	const PAL_P_SQUIRTLE   ; 7
	const PAL_P_WARTORTLE  ; 8
	const PAL_P_BLASTOISE  ; 9
	const PAL_P_CATERPIE   ; 10
	const PAL_P_METAPOD    ; 11
	const PAL_P_BUTTERFREE ; 12
	const PAL_P_WEEDLE     ; 13
	const PAL_P_KAKUNA     ; 14
	const PAL_P_BEEDRILL   ; 15
	const PAL_P_PIDGEY     ; 16
	const PAL_P_PIDGEOTTO  ; 17
	const PAL_P_PIDGEOT    ; 18
	const PAL_P_RATTATA    ; 19
	const PAL_P_RATICATE   ; 20
	const PAL_P_SPEAROW    ; 21
	const PAL_P_FEAROW     ; 22
	const PAL_P_EKANS      ; 23
	const PAL_P_ARBOK      ; 24
	const PAL_P_PIKACHU    ; 25
	const PAL_P_RAICHU     ; 26
	const PAL_P_SANDSHREW  ; 27
	const PAL_P_SANDSLASH  ; 28
	const PAL_P_NIDORAN_F  ; 29
	const PAL_P_NIDORINA   ; 30
	const PAL_P_NIDOQUEEN  ; 31
	const PAL_P_NIDORAN_M  ; 32
	const PAL_P_NIDORINO   ; 33
	const PAL_P_NIDOKING   ; 34
	const PAL_P_CLEFAIRY   ; 35
	const PAL_P_CLEFABLE   ; 36
	const PAL_P_VULPIX     ; 37
	const PAL_P_NINETALES  ; 38
	const PAL_P_JIGGLYPUFF ; 39
	const PAL_P_WIGGLYTUFF ; 40
	const PAL_P_ZUBAT      ; 41
	const PAL_P_GOLBAT     ; 42
	const PAL_P_ODDISH     ; 43
	const PAL_P_GLOOM      ; 44
	const PAL_P_VILEPLUME  ; 45
	const PAL_P_PARAS      ; 46
	const PAL_P_PARASECT   ; 47
	const PAL_P_VENONAT    ; 48
	const PAL_P_VENOMOTH   ; 49
	const PAL_P_DIGLETT    ; 50
	const PAL_P_DUGTRIO    ; 51
	const PAL_P_MEOWTH     ; 52
	const PAL_P_PERSIAN    ; 53
	const PAL_P_PSYDUCK    ; 54
	const PAL_P_GOLDUCK    ; 55
	const PAL_P_MANKEY     ; 56
	const PAL_P_PRIMEAPE   ; 57
	const PAL_P_GROWLITHE  ; 58
	const PAL_P_ARCANINE   ; 59
	const PAL_P_POLIWAG    ; 60
	const PAL_P_POLIWHIRL  ; 61
	const PAL_P_POLIWRATH  ; 62
	const PAL_P_ABRA       ; 63
	const PAL_P_KADABRA    ; 64
	const PAL_P_ALAKAZAM   ; 65
	const PAL_P_MACHOP     ; 66
	const PAL_P_MACHOKE    ; 67
	const PAL_P_MACHAMP    ; 68
	const PAL_P_BELLSPROUT ; 69
	const PAL_P_WEEPINBELL ; 70
	const PAL_P_VICTREEBEL ; 71
	const PAL_P_TENTACOOL  ; 72
	const PAL_P_TENTACRUEL ; 73
	const PAL_P_GEODUDE    ; 74
	const PAL_P_GRAVELER   ; 75
	const PAL_P_GOLEM      ; 76
	const PAL_P_PONYTA     ; 77
	const PAL_P_RAPIDASH   ; 78
	const PAL_P_SLOWPOKE   ; 79
	const PAL_P_SLOWBRO    ; 80
	const PAL_P_MAGNEMITE  ; 81
	const PAL_P_MAGNETON   ; 82
	const PAL_P_FARFETCHD  ; 83
	const PAL_P_DODUO      ; 84
	const PAL_P_DODRIO     ; 85
	const PAL_P_SEEL       ; 86
	const PAL_P_DEWGONG    ; 87
	const PAL_P_GRIMER     ; 88
	const PAL_P_MUK        ; 89
	const PAL_P_SHELLDER   ; 90
	const PAL_P_CLOYSTER   ; 91
	const PAL_P_GASTLY     ; 92
	const PAL_P_HAUNTER    ; 93
	const PAL_P_GENGAR     ; 94
	const PAL_P_ONIX       ; 95
	const PAL_P_DROWZEE    ; 96
	const PAL_P_HYPNO      ; 97
	const PAL_P_KRABBY     ; 98
	const PAL_P_KINGLER    ; 99
	const PAL_P_VOLTORB    ; 100
	const PAL_P_ELECTRODE  ; 101
	const PAL_P_EXEGGCUTE  ; 102
	const PAL_P_EXEGGUTOR  ; 103
	const PAL_P_CUBONE     ; 104
	const PAL_P_MAROWAK    ; 105
	const PAL_P_HITMONLEE  ; 106
	const PAL_P_HITMONCHAN ; 107
	const PAL_P_LICKITUNG  ; 108
	const PAL_P_KOFFING    ; 109
	const PAL_P_WEEZING    ; 110
	const PAL_P_RHYHORN    ; 111
	const PAL_P_RHYDON     ; 112
	const PAL_P_CHANSEY    ; 113
	const PAL_P_TANGELA    ; 114
	const PAL_P_KANGASKHAN ; 115
	const PAL_P_HORSEA     ; 116
	const PAL_P_SEADRA     ; 117
	const PAL_P_GOLDEEN    ; 118
	const PAL_P_SEAKING    ; 119
	const PAL_P_STARYU     ; 120
	const PAL_P_STARMIE    ; 121
	const PAL_P_MR_MIME    ; 122
	const PAL_P_SCYTHER    ; 123
	const PAL_P_JYNX       ; 124
	const PAL_P_ELECTABUZZ ; 125
	const PAL_P_MAGMAR     ; 126
	const PAL_P_PINSIR     ; 127
	const PAL_P_TAUROS     ; 128
	const PAL_P_MAGIKARP   ; 129
	const PAL_P_GYARADOS   ; 130
	const PAL_P_LAPRAS     ; 131
	const PAL_P_DITTO      ; 132
	const PAL_P_EEVEE      ; 133
	const PAL_P_VAPOREON   ; 134
	const PAL_P_JOLTEON    ; 135
	const PAL_P_FLAREON    ; 136
	const PAL_P_PORYGON    ; 137
	const PAL_P_OMANYTE    ; 138
	const PAL_P_OMASTAR    ; 139
	const PAL_P_KABUTO     ; 140
	const PAL_P_KABUTOPS   ; 141
	const PAL_P_AERODACTYL ; 142
	const PAL_P_SNORLAX    ; 143
	const PAL_P_ARTICUNO   ; 144
	const PAL_P_ZAPDOS     ; 145
	const PAL_P_MOLTRES    ; 146
	const PAL_P_DRATINI    ; 147
	const PAL_P_DRAGONAIR  ; 148
	const PAL_P_DRAGONITE  ; 149
	const PAL_P_MEWTWO     ; 150
	const PAL_P_MEW        ; 151
	const PAL_SPRITES     ; $2F
	const PAL_MENU        ; $30
