extends Node2D

@onready var mob_pack_area = $mob_pack_area
@onready var panel_container = $PanelContainer
@onready var grid_container = $PanelContainer/MarginContainer/GridContainer

var mob_number: int
var mob_pack_difficulty_rating: float
var mob_pack_id: String
var instantiated_mobs: Array
var roaming_mob

#spiderling
#spider
#guardian spider
#carrier spider
#venomweaver

var mobs_and_paths: Dictionary = {
	"spider": "res://scenes/spider.tscn",
	"spiderling": "res://scenes/spiderling.tscn",
	}

# Called when the node enters the scene tree for the first time.
func _ready():
	create_mob_pack()
	spawn_roaming_mob()
	manage_mob_pack_tooltip_ui()
	#print("mobpack roaming mob ",roaming_mob)
	#print("mobpack mobs ",instantiated_mobs)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if GlobalVar.exploration_mode:
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
		
		instantiated_mobs.append(new_mob)
		
func spawn_roaming_mob():
	
	var mob_power_list: Array = []
	var roaming_mob_list: Array = []
	for mob_scene in instantiated_mobs:
		#add mob's power to list
		mob_power_list.append(mob_scene.power)
	
	#get maximum power number
	var max_mob_power: int = mob_power_list.max()
	
	#gets strongest mob as the roaming mob
	for mob_scene in instantiated_mobs:
		if mob_scene.power == max_mob_power:
			roaming_mob_list.append(mob_scene)
			
	#if mobs match power, choose at random
	if roaming_mob_list.size() > 1:
		roaming_mob = roaming_mob_list[randi() % roaming_mob_list.size()]
				#var cloned_mob = roaming_mob.duplicate()
				#change owner so that i dont get errors
				#cloned_moba.get_parent().remove_child(cloned_mob)
				
		#adds roaming mob to combat_mobs_container
		#get_parent().get_parent().get_child(3).add_child(roaming_mob)
		add_child(roaming_mob)
	else:
		roaming_mob = roaming_mob_list[0]
		#adds roaming mob to combat_mobs_container
		#get_parent().get_parent().get_child(3).add_child(roaming_mob)
		add_child(roaming_mob)
	GlobalVar.roaming_mob = roaming_mob
	
func set_ui_position():
	panel_container.position = roaming_mob.global_position

func manage_mob_pack_tooltip_ui():
	if GlobalVar.exploration_mode:
		#sacar info de los hijos agregados
		for mob in instantiated_mobs:
				#create and add nodes
				var mob_icon = TextureRect.new()
				var mob_data = Label.new()
				grid_container.add_child(mob_icon)
				grid_container.add_child(mob_data)
				
				#get info
				var mob_info = str(mob.name) + " lvl " + str(mob.level) + " Power " + str(mob.power)
				
				#settings
				mob_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH
				mob_icon.texture = load("res://icons/"+mob.name.to_lower()+"_icon.png")
				mob_data.text = mob_info

func _on_mob_pack_area_mouse_entered():
	panel_container.visible = true
	
func _on_mob_pack_area_mouse_exited():
	panel_container.visible = false
