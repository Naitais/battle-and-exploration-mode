class_name DumbAiState
extends State

@export var actor: Mob
@export var animated_sprite: AnimatedSprite2D

#STATE FOR MOB TURN
signal turn_started
signal turn_finished

enum EntityState {
	MOVE,
	IDLE
}

# Current state variable
var current_state: EntityState = EntityState.IDLE

func animate_grid_movement():
	var available_action_points: int = actor.entity_info.action_points
	#if calculate_ap_consumption_on_movement():
	var tween_path = create_tween()
	tween_path.connect("finished", on_tween_path_finished)
	for point in actor.path:
		#translate into coordinates
		point = GlobalVar.combat_map.map_to_local(Vector2(point))
		tween_path.tween_property(actor, "position", point,0.20)
		#actor.action_points -= i
	
func on_tween_path_finished():
	turn_finished.emit()
	actor.playing_turn = false
	print("movement finished")
	
func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)
	# Start in the idle state
	set_state(EntityState.IDLE)

func set_state(state: EntityState) -> void:
	current_state = state
	match state:
		EntityState.MOVE:
			# Perform actions for the move state
			print("moving")
			animate_grid_movement()
			
		EntityState.IDLE:
			# Perform actions for the idle state
			print("Idle.")

# Function to update the state
func update_state() -> void:
	# Update state based on conditions
	if actor.playing_turn:
		# Change to move state if needed
		set_state(EntityState.MOVE)
		
	elif current_state == EntityState.MOVE:
		pass
		# Change to idle state if needed
		#set_state(EntityState.IDLE)

func _enter_state() -> void:
	#solo se activa cuando entro al state wander 
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	update_state()
	actor.entity_info["action_points"] = actor.action_points
	
