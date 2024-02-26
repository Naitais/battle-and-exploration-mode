extends Panel

@onready var item_display = $item_display
@onready var slot_amount_lbl = $slot_amount_lbl

func update_inventory(slot: InventorySlot):
	if !slot.item:
		item_display.visible = false
		slot_amount_lbl.visible = false
		
	else:
		item_display.visible = true
		item_display.texture = slot.item.item_texture
		slot_amount_lbl.visible = true
		slot_amount_lbl.text = str(slot.amount)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_click_slot_area_mouse_entered():
	print("afuera ",get_parent())
	if Input.is_action_just_pressed("left_click"):
		print(get_parent())
