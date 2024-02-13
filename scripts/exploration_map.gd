extends Node2D

var player = load("res://scenes/player.tscn").instantiate()

func create_unique_mob_pack() -> void:
	var mob_pack = load("res://scenes/mob_pack.tscn").instantiate()
	add_child(mob_pack)
	GlobalVar.created_mob_packs.append(mob_pack)
	#print("Added mob_pack:", mob_pack)

func _ready():
	#create_unique_mob_pack()
	pass
func _process(_delta):
	pass
