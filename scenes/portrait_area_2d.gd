extends Area2D
@onready var collision_shape_2d = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#set position and size so that it fits the portrait
	collision_shape_2d.scale = Vector2(2,4)
	collision_shape_2d.position = Vector2(15,0) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	print(GlobalVar.entities_in_combat)
	print(GlobalVar.entity_index)
	
	
func _on_mouse_exited():
	pass # Replace with function body.
