class_name  CombatModeState
extends State

@export var game_world: Node2D
var cave_combat_map = load("res://scenes/cave_combat_map.tscn").instantiate()

signal exploration_mode_active
signal combat_mode_active

func start_combat_mode():
	if GlobalVar.exploration_mode == false and combat_mode_active:
		if cave_combat_map.get_parent() == null:#solo agrego el nivel si no existe, si ya existe
													#no corro cosntantemente esto porque sino tira error
													#todo el tiempo al tratar de agregarlo constantemente
			print("it works")
			remove_child(game_world.exploration_map)
			add_child(cave_combat_map)
			move_child(cave_combat_map, 0) #con esta funcion el mapa que cargo siempre esta primero en el orden de nodos

			GlobalVar.player.position = cave_combat_map.get_node("TileMap").map_to_local(Vector2(0, 4))
			#enemy.position = current_map_tilemap.map_to_local(Vector2(16, 4))

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)
	
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
		
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(delta):
	#start_combat_mode()
	#print("it works")
	pass
