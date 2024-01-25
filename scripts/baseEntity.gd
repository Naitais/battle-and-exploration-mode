class_name Entity
extends CharacterBody2D

#ESTADISTICAS BASE
@export var level: int = 0

@export var max_health: int = 10
@export var health: int = max_health

@export var max_AP: int = 12
@export var AP: int = max_AP

@export var max_energy: int = 5
@export var energy: int = max_energy

@export var max_mana: int = 5
@export var mana: int = max_mana

@export var max_armor: int = 0
@export var armor: int = max_armor

@export var max_magic_shield: int = 0
@export var magic_shield: int = max_magic_shield

@export var max_hitpoints: int = 1
@export var hitpoints: int = max_hitpoints

@export var initiative: int = 10

@export var speed: int = 40
@export var acceleration: int = 40

@export var physical_damage: int = 1

@onready var sprite = $Sprite2D
@onready var collision_shape = $CollisionShape2D 
@onready var animate = $AnimatedSprite2D

#ENTIDADES
#var entities = get_tree().get_nodes_in_group("entities")
var attacker: CharacterBody2D

func _process(_delta):
	pass
	
func _ready():
	$Hitbox/CollisionShape2D.disabled = true
	

