extends Node2D

@export var item_container: Inventory

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in item_container.inventory_slots:
		print(item.item)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
