class_name MoveState
extends State

@export var actor = Entity
@export var animated_sprite: AnimatedSprite2D


signal movement_key_pressed
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
	
	
func _physics_process(delta):
	animated_sprite.play("run")
	player_movement(delta)

func player_movement(_delta):
	if Input.is_action_pressed("up"):
		actor.velocity.y = -actor.speed
		actor.velocity.x = 0
	elif Input.is_action_pressed("down"):
		actor.velocity.y = actor.speed
		actor.velocity.x = 0
	elif Input.is_action_pressed("left"):
		actor.velocity.x = -actor.speed
		actor.velocity.y = 0
		animated_sprite.flip_h = true
	elif Input.is_action_pressed("right"):
		#current_state = States.MOVE
		actor.velocity.x = actor.speed
		actor.velocity.y = 0
		animated_sprite.flip_h = false
		
	else:
	
		player_not_moving.emit()
		actor.velocity.x = 0
		actor.velocity.y = 0
		
