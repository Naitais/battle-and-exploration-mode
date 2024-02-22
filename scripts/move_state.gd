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
	#animated_sprite.play("run")
	player_movement(delta)

func player_movement(_delta):
	if GlobalVar.exploration_mode:
		if Input.is_action_pressed("up"):
			actor.velocity.y = -actor.speed
			animated_sprite.play("back")
		elif Input.is_action_pressed("down"):
			actor.velocity.y = actor.speed
			animated_sprite.play("front")
		else:
			actor.velocity.y = 0

		if Input.is_action_pressed("left"):
			actor.velocity.x = -actor.speed
			animated_sprite.play("left")
			animated_sprite.flip_h = true
		elif Input.is_action_pressed("right"):
			actor.velocity.x = actor.speed
			animated_sprite.play("right")
			animated_sprite.flip_h = false
		else:
			actor.velocity.x = 0

		# Handle diagonal movement
		if Input.is_action_pressed("up") and Input.is_action_pressed("left"):
			actor.velocity = Vector2(-actor.speed, -actor.speed).normalized() * actor.speed
			animated_sprite.play("back_left")
			animated_sprite.flip_h = false
		elif Input.is_action_pressed("up") and Input.is_action_pressed("right"):
			actor.velocity = Vector2(actor.speed, -actor.speed).normalized() * actor.speed
			animated_sprite.play("back_right")
			animated_sprite.flip_h = true
		elif Input.is_action_pressed("down") and Input.is_action_pressed("left"):
			actor.velocity = Vector2(-actor.speed, actor.speed).normalized() * actor.speed
			animated_sprite.play("front_left")
			animated_sprite.flip_h = true
		elif Input.is_action_pressed("down") and Input.is_action_pressed("right"):
			actor.velocity = Vector2(actor.speed, actor.speed).normalized() * actor.speed
			animated_sprite.play("front_right")
			animated_sprite.flip_h = false

			
