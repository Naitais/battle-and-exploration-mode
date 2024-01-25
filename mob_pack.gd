extends Node2D

@onready var mob_pack_area = $mob_pack_area
@onready var panel_container = $PanelContainer
@onready var grid_container = $PanelContainer/MarginContainer/GridContainer

var mob_number: int
var mob_pack_difficulty_rating: float
var mob_pack_id: String
var instantiated_mobs: Array
var roaming_mob

var mobs_and_paths: Dictionary = {
	"spider": "res://scenes/spider.tscn",
	"slime": "res://scenes/spider.tscn",
	"goblin": "res://scenes/spider.tscn"
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	create_mob_pack()
	spawn_roaming_mob()
	manage_mob_pack_tooltip_ui()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	set_ui_position()
	mob_pack_area.global_position = roaming_mob.global_position
	
func create_mob_pack():
	mob_number = randi() % 4 + 1
	mob_pack_id = name
	
	for i in range(mob_number):
		#get random mob
		var mob_types = mobs_and_paths.keys()
		var random_mob = mob_types[randi() % mob_types.size()]
		
		#get path of random mob
		var mob_path: String = mobs_and_paths[random_mob]
		
		#load and instantiate new random mob scene
		var mob_scene: PackedScene = load(mob_path)
		var new_mob = mob_scene.instantiate()
		
		#mobs are contained in an array to later be spawned
		instantiated_mobs.append(new_mob)
	
func spawn_roaming_mob():
	
	var mob_power_list: Array = []
	var roaming_mob_list: Array = []
	for mob_scene in instantiated_mobs:
		#add mob's power to list
		mob_power_list.append(mob_scene.mob_power)
		
	#get maximum power number
	var max_mob_power: int = mob_power_list.max()
	
	#gets strongest mob as the roaming mob
	for mob_scene in instantiated_mobs:
		if mob_scene.mob_power == max_mob_power:
			roaming_mob_list.append(mob_scene)
			#if mobs match power, choose at random
			if roaming_mob_list.size() > 1:
				roaming_mob = roaming_mob_list[randi() % roaming_mob_list.size()]
				add_child(roaming_mob)
			else:
				roaming_mob = roaming_mob_list[0]
				add_child(roaming_mob)
		
func set_ui_position():
	panel_container.position = roaming_mob.global_position

func manage_mob_pack_tooltip_ui():
	if GlobalVar.exploration_mode:
		for mob in instantiated_mobs:
				#create and add nodes
				var mob_icon = TextureRect.new()
				var mob_data = Label.new()
				grid_container.add_child(mob_icon)
				grid_container.add_child(mob_data)
				
				#get info
				var mob_info = str(mob.name) + " lvl " + str(mob.mob_level) + " Power " + str(mob.mob_power)
				
				#settings
				mob_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH
				mob_icon.texture = load("res://icons/"+mob.name.to_lower()+"_icon.png")
				mob_data.text = mob_info
	
	
			#label.text = mob_info
			#texture_rect.texture = load("res://icons/"+mob.name.to_lower()+"_icon.png")
	else:
		print("asdasda")
		
			
#funcion para clasificar mod packs en dificultad tengo que adaptarla a nueva logica
#no esta en uso aun

func mod_pack_difficulty_rating(mob_pack):
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

func _on_mob_pack_area_mouse_entered():
	panel_container.visible = true
	
func _on_mob_pack_area_mouse_exited():
	panel_container.visible = false
