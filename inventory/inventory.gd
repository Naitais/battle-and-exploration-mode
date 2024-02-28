extends Resource

class_name Inventory

signal update_inventory_slot

enum type {PLAYER_INVENTORY, ENVIORENMENT_CONTAINER}

@export var inventory_slots: Array[InventorySlot]
@export var inventory_type: type

func insert(item: Item):
	# Check if there are slots with the same item
	var matching_slots = inventory_slots.filter(func(slot): return slot.item == item)
	
	if matching_slots.size() > 0 and item.item_can_stack:
		# If there are matching slots, stack the item
		matching_slots[0].amount += 1
	else:
		# If no matching slots, find an empty slot
		var empty_slots = inventory_slots.filter(func(slot): return !slot.item)
		
		if empty_slots.size() > 0:
			# If there's an empty slot, insert the item
			empty_slots[0].item = item
			empty_slots[0].amount = 1
		else:
			print("Inventory full, cannot insert item:", item)

			
	#update_inventory_slot.emit()
