class_name  PathfindState
extends State

@export var actor: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

var astargrid = AStarGrid2D.new()
var initial_pos: Vector2
var final_pos: Vector2

var get_mob_path: bool = true

signal turn_started
signal turn_finished

func set_astargrid():
	#PATHFINDING display players movement path
	astargrid.region = Rect2i(0, 0, 12, 9)
	astargrid.cell_size = Vector2i(32, 32)
	#seteo movimiento sin diagonales
	astargrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astargrid.update()
	get_mob_path = true

func find_closest_target():
	for entity in GlobalVar.entities_in_combat:
		if entity.entity_info["team_tag"] == "red":
			actor.target = entity

func get_pathfinding(initial_pos, final_pos):
	#creo el path
	if GlobalVar.combat_map:
		
		initial_pos = GlobalVar.combat_map.local_to_map(actor.global_position)
		#get path only if the entity is playing its turn
		if actor.name == "player" and actor.playing_turn:
			set_occupied_tiles()
			initial_pos = GlobalVar.combat_map.local_to_map(actor.global_position)
			#final position for player is always the mouse position
			final_pos  = GlobalVar.combat_map.local_to_map(actor.get_global_mouse_position())
			#if final_pos > Vector2i(0,0) and final_pos < Vector2i(12,9):
			actor.path = astargrid.get_id_path(initial_pos, final_pos)
			
		#get path for mobs
		elif actor.name != "player" and actor.playing_turn:
			find_closest_target()
			if actor.target:
				initial_pos = GlobalVar.combat_map.local_to_map(actor.global_position)
				final_pos  = GlobalVar.combat_map.local_to_map(actor.target.global_position)
				#print(final_pos)
				#print(initial_pos)
			#if final_pos > Vector2i(0,0) and final_pos < Vector2i(12,9):
			
				actor.path = astargrid.get_id_path(initial_pos, final_pos)
				
				
func set_occupied_tiles():
	for entity in GlobalVar.entities_in_combat:
		if entity.playing_turn == false:
			astargrid.set_point_solid(entity.entity_tile_position)
		else:
			astargrid.set_point_solid(entity.entity_tile_position, false)

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)
	set_astargrid()
	
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
		
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	#
	get_pathfinding(initial_pos, final_pos)
	
