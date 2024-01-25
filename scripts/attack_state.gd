class_name AttackState
extends State

@export var actor: Entity
@export var animation_player: AnimationPlayer
@export var hitbox_collision: CollisionShape2D
@export var basic_attack_detection_area: CollisionShape2D
@export var animated_sprite: AnimatedSprite2D
@export var hitbox_pos_flip_true: float #mas adelante tendria que ser un vector cuando implemente ataque arriba y abajo
@export var hitbox_pos_flip_false: float #mas adelante tendria que ser un vector cuando implemente ataque arriba y abajo

@export var basic_attack_det_area_flip_true: float #mas adelante tendria que ser un vector cuando implemente ataque arriba y abajo
@export var basic_attack_det_area_flip_false: float #mas adelante tendria que ser un vector cuando implemente ataque arriba y abajo

@export var animation_name: String

signal execute_basic_attack
signal basic_attack_animation_finished
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
	animation_player.play(animation_name)
	actor.velocity.x = 0
	actor.velocity.y = 0
	
	if actor.name != "Player":
		#print(actor.position - GlobalVar.player.position)
		#actor.position +=  Vector2(1,0)
		pass
	
	if actor.name == "player":
		if animated_sprite.flip_h:
			hitbox_collision.position.x = hitbox_pos_flip_true
			
		else:
			hitbox_collision.position.x = hitbox_pos_flip_false
			#basic_attack_detection_area.position.x = basic_attack_det_area_flip_false
