extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	randomize_mob_pack_data()
	print(randomize_mob_pack_data())

# This function will generate random data for a mob pack
func randomize_mob_pack_data() -> Array:
	var mob_types = ["goblin", "slime", "skeleton"]  # Add more mob types as needed
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
	

