extends Resource

class_name Item

enum type {WEAPON, CONSUMABLE}

@export var item_name: String
@export var item_type: type
@export var item_texture: Texture2D
@export_multiline var item_description: String
@export var item_level: int
@export var item_rarity: String
@export var item_attributes: Dictionary
@export var item_path: String
@export var item_can_stack: bool

var rarities: Dictionary = {
	"common":Color(1,1,1,0.55), 
	"magic":Color(1,2,1), 
	"rare":Color(1,1,2), 
	"epic":Color(2,1,2), 
	"legendary":Color(5,2,1), 
	"unique":Color(5,3,1)
}

var item_info: Dictionary = {
	"item_name": item_name,
	"item_type": item_type,
	"item_texture": item_texture,
	"item_description": item_description,
	"item_level": item_level,
	"item_rarity": item_rarity,
	"item_attributes": item_attributes,
	"item_path": item_path
}

#looks for rarity of item to paint its container taking into account colour values in rarities dictionary
func set_item_rarity_colour():
	print(item_info["item_rarity"])
	for rarity in rarities.keys():
		print(rarity)
		if rarity == item_info["item_rarity"].to_lower():
			#panel_container.self_modulate = rarities[rarity]
			pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
