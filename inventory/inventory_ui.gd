extends Control

@onready var inventory_ui = $"."
@onready var player_inventory: Inventory = preload("res://inventory/player_inventory.tres")
@onready var inventory_ui_slots: Array = $NinePatchRect/GridContainer.get_children()

func update_inventory_slots():
	#this for returns an array with each index of the players inventory resource
	for i in range(min(player_inventory.inventory_slots.size(), inventory_ui_slots.size())):
		#get every ui slot to call the update function which replaces texture with the texture
		#loaded in the corresponding player inventory slot resource
		inventory_ui_slots[i].update_inventory(player_inventory.inventory_slots[i])

func open_inventory():
	if Input.is_action_just_pressed("open_inventory"):
		if visible == false:
			
			visible = true
		else:
			visible = false
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#this signal is emited when an item is inserted into the inventory
	player_inventory.update_inventory_slot.connect(update_inventory_slots)
	update_inventory_slots()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	open_inventory()
