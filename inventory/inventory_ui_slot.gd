extends Panel

@onready var item_display = $item_display

func update_inventory(item: Item):
	if !item:
		item_display.visible = false
	else:
		item_display.visible = true
		item_display.texture = item.item_texture
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
