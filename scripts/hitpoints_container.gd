extends HBoxContainer
@export var actor: Entity
@export var hitpoints_container: HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	for points in actor.hitpoints:
		var full_hitpoint = load("res://scenes/hitpoint.tscn").instantiate()
		hitpoints_container.add_child(full_hitpoint)


func _process(_delta):
	if GlobalVar.exploration_mode == false and GlobalVar.combat_mode:
		visible = false
