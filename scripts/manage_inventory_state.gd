class_name ManageInventoryState
extends State

#the parent of the scene is the actual object we are inserting this scene to
@onready var object
@export var grid_container: GridContainer
@onready var inventory_ui_slots: Array = grid_container.get_children()

func populate_grid_container():
	#fill the inventory ui with the corresponding amount of slots in the object inventory
	var slot_amount: int = object.item_container.inventory_slots.size()
	if inventory_ui_slots.size() < slot_amount:
		for r in range(slot_amount):
			var slot_ui = load("res://inventory/inventory_ui_slot.tscn").instantiate()
			grid_container.add_child(slot_ui)

func update_inventory_slots():
	#this for returns an array with each index of the players inventory resource
	for i in range(min(object.item_container.inventory_slots.size(), grid_container.get_children().size())):
		#get every ui slot to call the update function which replaces texture with the texture
		#loaded in the corresponding player inventory slot resource
		grid_container.get_children()[i].update_inventory(object.item_container.inventory_slots[i])
		
func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)
	
	#if the inventory is for the player
	if $"../..".get_parent() == GlobalVar.player:
		object = $"../..".get_parent()
	
	#if the inventory is of another type
	else:
		object = $"../..".get_parent()
	
	populate_grid_container()
	
	
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	update_inventory_slots()
