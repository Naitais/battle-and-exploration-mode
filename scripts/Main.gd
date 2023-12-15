extends Node

var game_world = load("res://scenes/game_world.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(game_world)
	
