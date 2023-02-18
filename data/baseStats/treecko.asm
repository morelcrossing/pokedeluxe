db DEX_TREECKO ; pokedex id
db 45 ; base hp
db 49 ; base attack
db 65 ; base defense
db 45 ; base speed
db 49 ; base special
db GRASS ; species type 1
db GRASS ; species type 2
db 45 ; catch rate
db 64 ; base exp yield
INCBIN "pic/ymon/treecko.pic",0,1 ; 55, sprite dimensions
dw TreeckoPicFront
dw TreeckoPicBack
; attacks known at lvl 0
db TACKLE
db 0
db 0
db 0
db 3 ; growth rate
; learnset
	tmlearn 3,6
	tmlearn 9,10
	tmlearn 20,21,22
	tmlearn 31,32
	tmlearn 33,34
	tmlearn 44
	tmlearn 50,51
db 1 ; padding
