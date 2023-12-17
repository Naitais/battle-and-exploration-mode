class_name  ExplorationModeState
extends State

@export var game_world: Node2D

var exploration_map = load("res://scenes/exploration_map.tscn").instantiate()
var player = load("res://scenes/player.tscn").instantiate()
var spider = load("res://scenes/spider.tscn").instantiate() #mobs should be instantiates in their map not here

signal exploration_mode_active
signal combat_mode_active

func start_exploration_mode():
	
	game_world.add_child(exploration_map)
	game_world.add_child(player)
	game_world.add_child(spider) #los mobs deberian ser agregados por el mapa en el cual spawnean
	#add_child(spider)
	spider.global_position = Vector2(100,200)
	

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)
	#start_exploration_mode()
	pass
	
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
	
		
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(delta):
	pass
	
