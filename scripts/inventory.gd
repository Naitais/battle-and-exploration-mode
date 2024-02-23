extends Node2D

@onready var grid_container = $Control/GridContainer

var items: Dictionary = {
	"slot_1": "empty",
	"slot_2": "empty",
	"slot_3": "empty",
	"slot_4": "empty",
	"slot_5": "empty",
	"slot_6": "sword",
	"slot_7": "potion",
	"slot_8": "empty",
	"slot_9": "empty",
}

func open_inventory():
	if Input.is_action_just_pressed("open_inventory"):
		if grid_container.visible == false:
			for key in items.keys():
			#print(key + ": " items[key])
				print(key+ ": " +items[key])
			
			grid_container.visible = true
		else:
			grid_container.visible = false
	
func render_items_in_inventory():
	pass

func add_item_to_inventory():
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	open_inventory()
