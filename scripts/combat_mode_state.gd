class_name  CombatModeState
extends State

@export var game_world: Node2D
@export var combat_mobs_container: Node2D
var cave_combat_map = load("res://scenes/cave_combat_map.tscn").instantiate()

# var for while which controls mobs spawned
var i: int = 0

signal exploration_mode_active
signal combat_mode_active

func spawn_entities_in_combat_map():
	game_world.player.position = game_world.combat_map.map_to_local(Vector2(0, 4))
	
	#get the mob_pack involved in combat
	var mobs: Array = GlobalVar.mob_pack_involved_in_combat.instantiated_mobs
	
	while i != mobs.size():
		for mob in mobs:
			
			var combat_mob = mob
			combat_mobs_container.add_child(combat_mob)
			
			i += 1
			#create logic which sets in a position not occupied randi() % 11
			#for now it is just in order of i variable
			combat_mob.position = game_world.combat_map.map_to_local(Vector2(11, i))
			#

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)
	game_world.add_child.call_deferred(cave_combat_map)
	
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	
	set_physics_process(true)
		
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(delta):
	
	#game_world.remove_child(game_world.mob_pack)
	spawn_entities_in_combat_map()
	
	
