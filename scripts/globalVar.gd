extends Node

#EQUIPPED ITEMS BY PLAYER
var on_hand_weapon_slot_one: String = "magic_staff"

var entities = null
var player: CharacterBody2D
var exploration_mode: bool = true

var created_mob_packs: Array = []

var instantiated_mobs: Array
var roaming_mob: CharacterBody2D

#COMBAT VARIABLES
var combat_mode: bool
var mob_pack_involved_in_combat: Node
var entities_in_combat: Array = []
var red_team: Array = []
var blue_team: Array = []
var turn_end: bool
var combat_map: TileMap

#in the futurre I will need a globalvar for different things such as managing spawned mob packs
#this array stores every spawned mob_pack so that when a combat starts, it will get a specific mob_pack
#(maybe it will get the mob_pack id when I get a database) to spawn every mob in the pack in a battle map
	
func _physics_process(_delta):
	
	pass
	
	
	
