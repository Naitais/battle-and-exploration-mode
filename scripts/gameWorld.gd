extends Node2D

var exploration_map = load("res://scenes/exploration_map.tscn").instantiate()
var cave_combat_map = load("res://scenes/cave_combat_map.tscn").instantiate()
var player = load("res://scenes/player.tscn").instantiate()
var combat_map = cave_combat_map.get_child(0)

func spawn_entities_in_combat_map():
	#get the mob_pack involved in combat
	var mobs: Array = GlobalVar.mob_pack_involved_in_combat.instantiated_mobs
	
	#spawning the mobs inside mob_pack
	for mob in mobs:
		add_child(mob)
		mob.position = combat_map.map_to_local(Vector2(0, 16))
		
	#spawning the player
	player.position = combat_map.map_to_local(Vector2(0, 4))
	
func _ready():
	add_child(exploration_map)
	add_child(player)
	
func _process(delta):
	if GlobalVar.combat_mode and GlobalVar.exploration_mode == false:
		#combat_mode_state.combat_mode_active.emit()
		spawn_entities_in_combat_map()
		
		if cave_combat_map.get_parent() == null:#solo agrego el nivel si no existe, si ya existe
													#no corro cosntantemente esto porque sino tira error
													#todo el tiempo al tratar de agregarlo constantemente
			remove_child(exploration_map)
			add_child(cave_combat_map)
			move_child(cave_combat_map, 0) #con esta funcion el mapa que cargo siempre esta primero en el orden de nodos
	
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	
	#print(GlobalVar.created_mob_packs)
	
