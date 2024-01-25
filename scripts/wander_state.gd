class_name WanderState
extends State

@export var actor: Mob
@export var animator: AnimatedSprite2D
#@export var vision_cast:  RayCast2D

var move_direction: Vector2
var wander_time: float

signal objective_found

func randomize_wander():
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1,1)).normalized()
	wander_time = randf_range(1,3)
func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
	randomize_wander()
		
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(delta):
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
		
	if actor:
		actor.velocity = move_direction * actor.speed
