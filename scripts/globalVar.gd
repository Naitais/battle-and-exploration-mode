extends Node

#EQUIPPED ITEMS BY PLAYER
var on_hand_weapon_slot_one: String = "magic_staff"

var entities = null
var player: CharacterBody2D


func _physics_process(_delta):
	#print(on_hand_weapon_slot_one)
	entities = get_tree().get_nodes_in_group("entities")
	for entity in GlobalVar.entities:
		if entity.name == "player":
			player = entity
		#print(entity)

