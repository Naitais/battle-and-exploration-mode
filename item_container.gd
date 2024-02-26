extends Node2D

@export var item_container: Inventory
@onready var state_machine = $StateMachine as StateMachine
@onready var open_container_state = $StateMachine/OpenContainerState as OpenContainerState
@onready var open_message_lbl = $open_message_lbl
@onready var inventory_ui_test = $inventory_ui_test

var can_open_container: bool = false
var container_is_open: bool = false

func open_container():
	if can_open_container:
		
		if Input.is_action_just_pressed("open_container") and !container_is_open:
			inventory_ui_test.visible = true
			container_is_open = true
			open_message_lbl.visible = false
		elif Input.is_action_just_pressed("open_container") and container_is_open:
			inventory_ui_test.visible = false
			container_is_open = false
			open_message_lbl.visible = true
	else:
		open_message_lbl.visible = false
		inventory_ui_test.visible = false
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	open_container()

func _on_interact_area_body_entered(body):
	if body.entity_info["type"] == "adventurer":
		can_open_container = true
		if !container_is_open:
			open_message_lbl.visible = true

func _on_interact_area_body_exited(body):
	if body.entity_info["type"] == "adventurer":
		can_open_container = false
		container_is_open = false
