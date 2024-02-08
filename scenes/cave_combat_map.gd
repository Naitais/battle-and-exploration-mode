extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_entities_involved_in_combat_body_entered(body):
	print(body)


func _on_entities_involved_in_combat_body_exited(body):
	print(body)
