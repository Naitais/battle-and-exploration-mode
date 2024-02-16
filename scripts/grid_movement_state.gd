class_name  GridMovementState
extends State

@export var actor: CharacterBody2D
@export var animated_sprite: AnimatedSprite2D

var astargrid = AStarGrid2D.new()
var initial_pos: Vector2
var final_pos: Vector2
var path: Array

signal start_movement
signal player_turn_finished
signal player_turn_started
signal finished_movement

func animate_grid_movement():
	var tween_path = create_tween()
	for point in actor.path:
		#translate into coordinates
		point = GlobalVar.combat_map.map_to_local(Vector2(point))
		tween_path.tween_property(actor, "position", point,0.20)
		
func move_player():
	if Input.is_action_just_pressed("left_click"):
		animate_grid_movement()

func on_tween_path_finished():
	print("finalizo moviemitno")

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
	if actor.name == "player":
		move_player()
		
