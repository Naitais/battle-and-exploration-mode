extends Node2D
var spider = load("res://scenes/spider.tscn").instantiate() #mobs should be instantiates in their map not here

# Called when the node enters the scene tree for the first time.
func _ready():
	#print(mod_pack_difficulty_rating(randomize_mob_pack_data()))
	spawn_mob_from_mob_pack(get_strongest_mob(randomize_mob_pack_data()))
	#los mobs deberian ser agregados por el mapa en el cual spawnean
	
	spider.global_position = Vector2(100,200)
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
				"mob_level": randi() % 5 + 1,
				"power": randi() % 100 + 1,  # Adjust the level range as needed
				#power should be the result of a mob's stats
				# Add other stats as needed
			}
		mob_pack_data.append(mob_data)
	
	return mob_pack_data

#funcion para clasificar mod packs en dificultad
func mod_pack_difficulty_rating(mob_pack) -> int:
	var mob_count: int = 0
	var mob_sum_levels: int = 0
	var pack_power: int = 0
	#power should be the result of a mob's stats
	for mob_data in mob_pack:
		mob_count +=1
		mob_sum_levels += mob_data.get("mob_level")
		pack_power += mob_data.get("power") 
	pack_power = pack_power / mob_count
	var mob_pack_rating: int
	mob_pack_rating += mob_count + mob_sum_levels + pack_power
	
	return mob_pack_rating
	
func get_strongest_mob(mob_pack):
	#this function will look for the strongest mob in a mob_pack
	var mob_power_list = []
	for mob_data in mob_pack:
		mob_power_list.append(mob_data.get("power"))
		
	var max_mob_power: int = mob_power_list.max()
	
	for mob_data in mob_pack:
		if mob_data.get("power") == max_mob_power:
		#this can cause problems if two mobs have the same power level
			return [mob_data, mob_pack]
	
func spawn_mob_from_mob_pack(strongest_mob_data):
	var strongest_mob_type: String = strongest_mob_data[0].get("mob_type")
	var mob_pack: Array = strongest_mob_data[1]
	GlobalVar.spawned_mob_packs.append(mob_pack)
	add_child(spider)
	#here we would add the strongest mob from the mob pack but i need to create the rest of the mobs
	#I still need to think about the locations I would place the mobs in
	#maybe I will make it spawn in a random area of specific spots of the map
