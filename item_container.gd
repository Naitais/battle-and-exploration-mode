extends Node2D

@export var item_container: Inventory
@onready var inventory_ui_test = $inventory_ui_test

var can_open_container: bool = false
var player_is_close: bool = false

func open_container():
	if can_open_container and player_is_close:
		
		if Input.is_action_just_pressed("left_click"):
			inventory_ui_test.visible = true
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#for item in item_container.inventory_slots:
	#	print(item.item)
	open_container()

func _on_interact_area_mouse_entered():
	can_open_container = true

func _on_interact_area_mouse_exited():
	can_open_container = false

func _on_proximity_area_body_entered(body):
	if body.name == "player":
		player_is_close = true

func _on_proximity_area_body_exited(body):
	if body.name == "player":
		player_is_close = false
