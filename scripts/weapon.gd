class_name Weapon

extends "res://scripts/item.gd"

@export var weapon_type: String

func create_random_weapon():
	pass

func _ready():
	#decide if we include weapon type in this dictionary
	item_info = {
	"item_name": item_name,
	"item_type": item_type,
	"item_texture": item_texture,
	"item_description": item_description,
	"item_level": item_level,
	"item_rarity": item_rarity,
	"item_attributes": item_attributes,
	"item_path": item_path
}
	item_texture_sprite.texture = item_info["item_texture"]
	
	print(item_info)
	set_item_rarity_colour()
