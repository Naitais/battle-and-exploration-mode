extends Resource

class_name Inventory

signal update_inventory_slot

@export var inventory_slots: Array[InventorySlot]

func insert(item: Item):
	var items_in_slots = inventory_slots.filter(func(slot): return slot.item == item)
	if items_in_slots.is_empty():
		items_in_slots[0].amount += 1
	else:
		var empty_slot = inventory_slots.filter(func(slot): return slot.item == null)
		if !empty_slot.is_empty():
			empty_slot[0].item = item
			empty_slot[0].amount = 1
			
	update_inventory_slot.emit()
