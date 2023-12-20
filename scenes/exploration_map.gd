extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print(mod_pack_difficulty_rating(randomize_mob_pack_data()))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# This function will generate random data for a mob pack
func randomize_mob_pack_data() -> Array:
	var mob_types = ["spider", "slime", "goblin"]  # Add more mob types as needed
	var mob_pack_data = []

	# Randomize the number of mobs in the pack (you can adjust the range as needed)
	var num_mobs = randi() % 4 + 1

	for i in range(num_mobs):
		var mob_data = {
				"mob_type": mob_types[randi() % mob_types.size()],
				"mob_level": randi() % 5 + 1,  # Adjust the level range as needed
				# Add other stats as needed
			}
		mob_pack_data.append(mob_data)
	
	return mob_pack_data

#funcion para clasificar mod packs en dificultad
func mod_pack_difficulty_rating(mob_pack) -> int:
	var mob_count: int = 0
	var mob_sum_levels: int = 0
	for mob_data in mob_pack:
		mob_count +=1
		mob_sum_levels += mob_data.get("mob_level")
	
	var mob_pack_rating: int
	mob_pack_rating += mob_count + mob_sum_levels
	
	return mob_pack_rating
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
