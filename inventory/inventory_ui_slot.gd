extends Panel

@onready var item_display = $item_display
@onready var slot_amount_lbl = $slot_amount_lbl
@onready var item_name_lbl = $item_name_lbl
@onready var inventory: Inventory = get_parent().get_parent().get_parent().get_parent().item_container

var can_pick_item: bool = false

func update_inventory(slot: InventorySlot):
	if !slot.item:
		item_display.visible = false
		slot_amount_lbl.visible = false
		
	else:
		item_display.visible = true
		item_display.texture = slot.item.item_texture
		slot_amount_lbl.visible = true
		
		if slot.amount > 1:
			slot_amount_lbl.text = str(slot.amount)

func show_item_name(slot):
	if slot.item and can_pick_item:
		item_name_lbl.global_position = get_global_mouse_position() + Vector2(-30,-15)
		item_name_lbl.text = slot.item.item_name
		
		pick_up_item(slot.item)

func pick_up_item(item: Item):
	if Input.is_action_just_pressed("left_click"):
		#inventory.insert(item)
		#if item
		GlobalVar.player.item_container.insert(item)
		
func get_slot_item():
	if can_pick_item:
		#find the inventory of the object
		var inventory_slots: Array = get_parent().get_parent().get_parent().get_parent().item_container.inventory_slots
		
		#get the item in the clicked slot ui
		for slot in inventory_slots:
			if slot == inventory_slots[get_parent().get_children().find(self)]:
				#print(inventory_slots[get_parent().get_children().find(self)])
				show_item_name(slot)
				
		#print("self index: ",get_parent().get_children().find(self))
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_slot_item()

func _on_click_slot_area_mouse_entered():
	can_pick_item = true
	item_name_lbl.visible = true
	
func _on_click_slot_area_mouse_exited():
	can_pick_item = false
	item_name_lbl.visible = false
