class_name  CombatModeState
extends State

@export var game_world: Node2D
@export var combat_mobs_container: Node2D
var cave_combat_map = load("res://scenes/cave_combat_map.tscn").instantiate()
var entities_in_combat: Array = GlobalVar.entities_in_combat
var current_entity_turn: CharacterBody2D
var i: int = 0

# var for while which controls mobs spawned
var entity_index: int = 0
var start_round: bool = true

#run only the first time, make it false when combat ends
var entities_spawned: bool = false

signal exploration_mode_active
signal combat_mode_active

func spawn_entities_in_combat_map():
	if entities_spawned == false:
		game_world.player.position = game_world.combat_map.map_to_local(Vector2(0, 4))
		
		#reset i
		i = 0
		#get the mob_pack involved in combat IF there are mobs in the global array
		if GlobalVar.mob_pack_involved_in_combat.instantiated_mobs.size()>0:
			var mobs: Array = GlobalVar.mob_pack_involved_in_combat.instantiated_mobs
		
			while i != mobs.size():
				for mob in mobs:
					var combat_mob = mob
					
					#if mob already has a parent, do not add it again
					if combat_mob.get_parent() == null: 
						combat_mobs_container.add_child(combat_mob)
					i += 1
					#create logic which sets in a position not occupied randi() % 11
					#for now it is just in order of i variable
					combat_mob.position = game_world.combat_map.map_to_local(Vector2(11, i))
	entities_spawned = true
	
func compare_entities(a, b):
	#sort by initiative stat
	return a.entity_info["initiative"] > b.entity_info["initiative"]
	
func get_turn_order():
	if start_round:
		#wait so that all entities are spawned before sorting
		await get_tree().create_timer(1).timeout
		#sort by initiative stat
		GlobalVar.entities_in_combat.sort_custom(compare_entities)
		
		# Reset playing_turn for all entities
		for entity in GlobalVar.entities_in_combat:
			entity.playing_turn = false
		
		# set only the first one as true so that it can start the round of turns
		if GlobalVar.entities_in_combat.size() > 0:
			GlobalVar.entities_in_combat[0].playing_turn = true
	start_round = false

func play_turn():
	#check if array is empty
	if GlobalVar.entities_in_combat.size() > 0:
		for entity in GlobalVar.entities_in_combat:
			
			#manage player states for combat
			if entity.playing_turn and entity.name == 'player':
				entity.pathfind_state.activar_prueba.emit()
				#maybe trigger signal or something
				
				
func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)
	
	
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	
	#if already has a parent, do not add it again
	if cave_combat_map.get_parent() == null:
		game_world.add_child.call_deferred(cave_combat_map)
		
	set_physics_process(true)
		
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	#game_world.remove_child(game_world.mob_pack)
	spawn_entities_in_combat_map()
	get_turn_order()
	play_turn()
	finish_turn() 
	
func finish_turn():
	if Input.is_action_just_pressed("finish_turn"):
		
		if entity_index < GlobalVar.entities_in_combat.size()-1:
			#sets false when turn finishes and sets true to next entity
			GlobalVar.entities_in_combat[entity_index].playing_turn = false
			GlobalVar.entities_in_combat[entity_index+1].playing_turn = true
			entity_index +=1
		else:
			entity_index = 0
			start_round = true
			print("RESETING ROUND")


