extends CharacterBody2D

const SPEED = 200
const ACCEL = 1500
const FRICTION = 600

var input = Vector2.ZERO

func _process(delta):
	player_movement(delta)
		
func player_movement(delta):
	input = get_input()

	# Apply acceleration based on input direction
	velocity += input * ACCEL * delta

	# Limit velocity to maximum speed
	velocity = velocity.normalized() * SPEED

	# Apply friction if no input is detected
	if input == Vector2.ZERO:
		var friction_force = velocity.normalized() * FRICTION * delta
		if friction_force.length() > velocity.length():
			velocity = Vector2.ZERO
		else:
			velocity -= friction_force

	# Move the character using move_and_slide
	move_and_slide()
	
func get_input():
	var input = Vector2.ZERO
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input


	
