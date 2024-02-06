extends Node2D

var exploration_map = load("res://scenes/exploration_map.tscn").instantiate()
var cave_combat_map = load("res://scenes/cave_combat_map.tscn").instantiate()
var player = load("res://scenes/player.tscn").instantiate()

var combat_map = cave_combat_map.get_child(0)

@onready var mob_packs = $mobPacks

#state machine
@onready var state_machine = $StateMachine as StateMachine
@onready var exploration_mode_state = $StateMachine/ExplorationModeState as ExplorationModeState
@onready var combat_mode_state = $StateMachine/CombatModeState as CombatModeState

func _ready():
	#state machine connextions
	exploration_mode_state.exploration_mode_active.connect(state_machine.change_state.bind(exploration_mode_state))
	exploration_mode_state.combat_mode_active.connect(state_machine.change_state.bind(combat_mode_state))
	
	combat_mode_state.exploration_mode_active.connect(state_machine.change_state.bind(exploration_mode_state))
	combat_mode_state.combat_mode_active.connect(state_machine.change_state.bind(combat_mode_state))
	
	#add_child(exploration_map)
	add_child(player)
	create_unique_mob_pack()
	
func _process(delta):
	if GlobalVar.combat_mode and GlobalVar.exploration_mode == false:
		combat_mode_state.combat_mode_active.emit()
		#remove_child(mob_pack)
	
		
		#if cave_combat_map.get_parent() == null:#solo agrego el nivel si no existe, si ya existe
													#no corro cosntantemente esto porque sino tira error
													#todo el tiempo al tratar de agregarlo constantemente
			#remove_child(exploration_map)
			#add_child(cave_combat_map)
			#move_child(cave_combat_map, 0) #con esta funcion el mapa que cargo siempre esta primero en el orden de nodos
			
		
			#spawn_entities_in_combat_map()
			
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	
	#print(GlobalVar.created_mob_packs)

func create_unique_mob_pack() -> void:
	var mob_pack = load("res://scenes/mob_pack.tscn").instantiate()
	mob_packs.add_child(mob_pack)
	GlobalVar.created_mob_packs.append(mob_pack)
