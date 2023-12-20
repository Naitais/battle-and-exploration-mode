extends Node2D

var exploration_map = load("res://scenes/exploration_map.tscn").instantiate()
var cave_combat_map = load("res://scenes/cave_combat_map.tscn").instantiate()
var player = load("res://scenes/player.tscn").instantiate()
var spider = load("res://scenes/spider.tscn").instantiate() #mobs should be instantiates in their map not here
 
@export var playerr: Player

@onready var state_machine = $StateMachine as StateMachine
@onready var combat_mode_state = $StateMachine/CombatModeState as CombatModeState
@onready var exploration_mode_state = $StateMachine/ExplorationModeState as ExplorationModeState

func _ready():
	combat_mode_state.exploration_mode_active.connect(state_machine.change_state.bind(combat_mode_state))
	combat_mode_state.combat_mode_active.connect(state_machine.change_state.bind(combat_mode_state))
	add_child(exploration_map)
	add_child(player)
	add_child(spider) #los mobs deberian ser agregados por el mapa en el cual spawnean
	#add_child(spider)
	
	spider.global_position = Vector2(100,200)
	
func _process(delta):
	if GlobalVar.combat_mode and GlobalVar.exploration_mode == false:
		#combat_mode_state.combat_mode_active.emit()
		
		if cave_combat_map.get_parent() == null:#solo agrego el nivel si no existe, si ya existe
													#no corro cosntantemente esto porque sino tira error
													#todo el tiempo al tratar de agregarlo constantemente
			remove_child(exploration_map)
			add_child(cave_combat_map)
			move_child(cave_combat_map, 0) #con esta funcion el mapa que cargo siempre esta primero en el orden de nodos

			player.position = cave_combat_map.get_node("TileMap").map_to_local(Vector2(0, 4))
			spider.position = cave_combat_map.get_node("TileMap").map_to_local(Vector2(11, 4))
	
	
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	
	
