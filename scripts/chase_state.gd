class_name  ChaseState
extends State

@export var actor: Mob
@export var animator: AnimatedSprite2D

signal objective_lost

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
		
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(delta):
	var direction = GlobalVar.player.global_position - actor.global_position
	#actor.global_position += (GlobalVar.player.global_position - actor.global_position)/actor.speed
	#if direction.length() > 25:
	actor.velocity = direction.normalized() * actor.speed
	pass	
	#else:
	#	actor.velocity = Vector2.ZERO
