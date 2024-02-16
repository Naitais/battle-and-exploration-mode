class_name  GridMovementState
extends State

#STATE FOR PLAYER TURN

@export var actor: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

signal turn_started
signal turn_finished

func move_player():
	if Input.is_action_just_pressed("left_click") and actor.path.size() > 0:
		print(actor.path)
		animate_grid_movement()

func calculate_ap_consumption_on_movement():
	#calculates how much ap is needed to move entity
	var available_action_points: int = actor.entity_info.action_points
	var action_points_consumption: int = actor.path.size()
	var result: int = available_action_points - action_points_consumption
	
	if result >= 0:
		actor.action_points -= action_points_consumption
		return true
	else:
		return false

func animate_grid_movement():
	if calculate_ap_consumption_on_movement():
		var tween_path = create_tween()
		for point in actor.path:
			#translate into coordinates
			point = GlobalVar.combat_map.map_to_local(Vector2(point))
			tween_path.tween_property(actor, "position", point,0.20)
		
	else:
		var message_lbl = Label.new()
		actor.get_parent().add_child(message_lbl)
		message_lbl.position = actor.get_global_mouse_position()
		message_lbl.text = "You need " + str(actor.path.size()) + " action points to move there"
		await get_tree().create_timer(1).timeout
		message_lbl.queue_free()
		
func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)
	
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
		
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	actor.entity_info["action_points"] = actor.action_points
	move_player()
