class_name Entity
extends CharacterBody2D

#main stats
var level: int = randi() % 5 + 1

@export var strength: int = 1 * level
@export var intellect: int = 1 * level
@export var constitution: int = 1 * level
@export var dexterity: int = 1 * level
@export var spirit: int = 1 * level

@export var max_AP: int = 12
@export var AP: int = max_AP

#game stats affected by main stats

#affected by STRENGTH
@export var physical_damage: int = strength

#affected by INTELLECT
@export var magic_damage: int = intellect

#affected by DEXTERITY
@export var crit_chance: int = dexterity
@export var crit_damage: int = dexterity

#affected by SPIRIT
@export var max_mana: int = spirit * 5
@export var mana: int = max_mana

#affected by CONSTITUTION
@export var max_health: int = constitution * 10
@export var health: int = max_health

#affected ONLY by EQUIPMENT
@export var max_armor: int = 0
@export var armor: int = max_armor

@export var max_magic_shield: int = 0
@export var magic_shield: int = max_magic_shield

@export var max_hitpoints: int = 1
@export var hitpoints: int = max_hitpoints

@export var initiative: int = 10

#game logic stats
@export var speed: int = 40
@export var acceleration: int = 40

#will be a sum of all stats 
var power: int = ((strength + intellect + dexterity + spirit + constitution) * level)


var entity_info: Dictionary = {
	"power": power,
	"level":level,
	"health":health,
	"armor": armor,
	"magic shield": magic_shield,
	"initiative": initiative,
	"physical damage": physical_damage,
	"magic damage": magic_damage,
	"critical damage": crit_damage,
	"critical chance": crit_chance,
	"strength": strength,
	"intellect": intellect,
	"constitution": constitution,
	"dexterity": dexterity,
	"spirit": spirit,
}

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
