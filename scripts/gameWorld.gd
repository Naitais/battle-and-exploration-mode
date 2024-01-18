extends Node2D

var exploration_map = load("res://scenes/exploration_map.tscn").instantiate()
var cave_combat_map = load("res://scenes/cave_combat_map.tscn").instantiate()
var player = load("res://scenes/player.tscn").instantiate()

func _ready():
	add_child(exploration_map)
	add_child(player)
	
	
	
	
func _process(delta):
	if GlobalVar.combat_mode and GlobalVar.exploration_mode == false:
		#combat_mode_state.combat_mode_active.emit()
		
		if cave_combat_map.get_parent() == null:#solo agrego el nivel si no existe, si ya existe
													#no corro cosntantemente esto porque sino tira error
													#todo el tiempo al tratar de agregarlo constantemente
			remove_child(exploration_map)
			add_child(cave_combat_map)
			move_child(cave_combat_map, 0) #con esta funcion el mapa que cargo siempre esta primero en el orden de nodos

	#		player.position = cave_combat_map.get_node("TileMap").map_to_local(Vector2(0, 4))
	#		spider.position = cave_combat_map.get_node("TileMap").map_to_local(Vector2(11, 4))
	
	
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	
	
