extends Node

#EQUIPPED ITEMS BY PLAYER
var on_hand_weapon_slot_one: String = "magic_staff"

var entities = null
var player: CharacterBody2D
var exploration_mode: bool = true
var combat_mode: bool 
var created_mob_packs: Array = []
var selected_mob_pack: Node

var mouse_pos: Vector2
#in the futurre I will need a globalvar for different things such as managing spawned mob packs
#this array stores every spawned mob_pack so that when a combat starts, it will get a specific mob_pack
#(maybe it will get the mob_pack id when I get a database) to spawn every mob in the pack in a battle map


func _physics_process(_delta):
	#print(on_hand_weapon_slot_one)
	
	
	print(created_mob_packs)
	
