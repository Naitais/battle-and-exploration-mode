extends Node2D

var exploration_map = load("res://scenes/exploration_map.tscn").instantiate()
var player = load("res://scenes/player.tscn").instantiate()
var spider = load("res://scenes/spider.tscn").instantiate()

func _ready():
	add_child(exploration_map)
	add_child(player)
	add_child(spider)
	#add_child(spider)
	
	spider.global_position = Vector2(100,200)
	
	
	

