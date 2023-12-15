class_name Entity
extends CharacterBody2D

#ESTADISTICAS BASE
@export var max_health: int = 10
@export var health: int = max_health

@export var max_AP: int = 12
@export var AP: int = max_AP

@export var max_energy: int = 5
@export var energy: int = max_energy

@export var max_mana: int = 5
@export var mana: int = max_mana

@export var initiative: int = 10

@export var speed: int = 40
@export var acceleration: int = 40

@export var physical_damage: int = 1

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D 
@onready var animate = $AnimatedSprite2D

#ENTIDADES
#var entities = get_tree().get_nodes_in_group("entities")

func _process(_delta):
	pass
	#if current_state == States.IDLE:
	#	animate.set_modulate(Color(1, 1, 1, 1))
	#	animate.rotation = 0
			
		
		#await $AnimationPlayer.animation_finished
	
func _ready():
	$Hitbox/CollisionShape2D.disabled = true
