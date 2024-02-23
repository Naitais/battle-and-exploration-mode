extends Control

@onready var inventory_ui = $"."



func open_inventory():
	
	if Input.is_action_just_pressed("open_inventory"):
		if inventory_ui.visible == false:
			#for key in items.keys():
			#print(key + ": " items[key])
			#	print(key+ ": " +items[key])
			
			inventory_ui.visible = true
		else:
			inventory_ui.visible = false
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	open_inventory()
