class_name  ExplorationModeState
extends State

@export var game_world: Node2D
@export var mob_packs: Node2D



var exploration_map = load("res://scenes/exploration_map.tscn").instantiate()

signal exploration_mode_active
signal combat_mode_active

func start_exploration_mode():
	
	#game_world.add_child(exploration_map)
	#game_world.add_child(player)
	#game_world.add_child(mob_pack)
	#game_world.add_child(spider) #los mobs deberian ser agregados por el mapa en el cual spawnean
	#add_child(spider)
	pass
	
func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)
	game_world.add_child.call_deferred(exploration_map)
	
	
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
	#game_world.remove_child(game_world.mob_packs)
	
	#if exists in the tree, remove it
	if exploration_map.get_parent():
		game_world.remove_child(exploration_map)
	
	
func _physics_process(delta):
	pass
