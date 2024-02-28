extends Panel

@onready var item_display = $item_display
@onready var slot_amount_lbl: Label = $slot_amount_lbl
@onready var item_name_lbl: Label = $item_name_lbl
@onready var inventory: Inventory = get_parent().get_parent().get_parent().get_parent().item_container
@onready var inventory_slots: Array = get_parent().get_parent().get_parent().get_parent().item_container.inventory_slots

var can_pick_item: bool = false

func update_inventory(slot: InventorySlot):
	if !slot.item:
		item_display.visible = false
		slot_amount_lbl.visible = false
		
	else:
		item_display.visible = true
		item_display.texture = slot.item.item_texture
		slot_amount_lbl.visible = true
		
		#show amount only when the item has stacked more than 1 items
		if slot.amount > 1:
			slot_amount_lbl.text = str(slot.amount)

func show_item_name(slot):
	if slot.item and can_pick_item:
		item_name_lbl.global_position = get_global_mouse_position() + Vector2(-30,-15)
		item_name_lbl.text = slot.item.item_name
		
		
		pick_up_item(slot)
		

func pick_up_item(slot: InventorySlot):
	var new_slot := InventorySlot.new()
	
	if Input.is_action_just_pressed("left_click"):
		GlobalVar.player.item_container.insert(slot.item)
		print(inventory_slots.find(slot))
		
		var slot_index: int = inventory_slots.find(slot)
		if slot_index != -1:
			inventory_slots.remove_at(slot_index)
			inventory_slots.insert(slot_index, new_slot)
			item_name_lbl.text = ""
			
		#await get_tree().create_timer(0.5).timeout
		
		
		
func get_slot_item():
	if can_pick_item:
		#get the item in the clicked slot ui
		for slot in inventory_slots:
			
			if slot and slot == inventory_slots[get_parent().get_children().find(self)]:
				show_item_name(slot)
				
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
