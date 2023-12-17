extends HBoxContainer
@export var actor: Entity
@export var empty_hitpoints_container: HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	for points in actor.hitpoints:
		var empty_hitpoint = load("res://scenes/empty_hitpoint.tscn").instantiate()
		empty_hitpoints_container.add_child(empty_hitpoint)

