class_name IdleState
extends State

@export var actor = Entity
@export var animator: AnimatedSprite2D

signal player_not_moving

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
	animator.play("idle")
	actor.velocity.x = 0
	actor.velocity.y = 0

