class_name RoundBarState
extends State

@export var combat_ui: CanvasLayer
@onready var entities_container = $"../../Control/PanelContainer/entitiesContainer"
#@onready var portrait_area2d = load("res://scenes/portrait_area_2d.tscn").instantiate()

var entity_bar_empty: bool = true
signal player_not_moving

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

func start_round_entities_bar_controller():
	#sets columns with amount of entities in the round and selects the current entity playing changing colour
	if GlobalVar.entities_in_combat.size() > 0:
		if entities_container.get_children().size() > 0:
			
			for portrait_container in entities_container.get_children():
				
				#changes colour of portrait container depending on the entity who is playing its turn
				if entities_container.get_children().find(portrait_container) == GlobalVar.entity_index:
					portrait_container.self_modulate = Color(16,8,2)
				else: 
					portrait_container.self_modulate = Color(1,1,1)
					
				#get the portrait_rect of the container to lower its opacity
				var portrait: TextureRect = portrait_container.get_child(0)
				
				#when its turn has already ended in the current round lower opacity
				if entities_container.get_children().find(portrait_container) < GlobalVar.entity_index:
					portrait.self_modulate = Color(1,1,1,0.4)
				
				else:
					portrait.self_modulate = Color(1,1,1,1)
				
					
				
				
		#wait until entities in combat list is filled
		await get_tree().create_timer(1).timeout
		entities_container.columns = GlobalVar.entities_in_combat.size()
		
		#creates and adds a container with texture of entity
		if entity_bar_empty:
			for entity in GlobalVar.entities_in_combat:
				var entity_portrait: PanelContainer = entity.get_node("PortraitContainer").duplicate()
				entity_portrait.visible = true
				entities_container.add_child(entity_portrait)
				
				var portrait_area2d = load("res://scenes/portrait_area_2d.tscn").instantiate()
				entity_portrait.get_child(0).add_child(portrait_area2d)
				
		entity_bar_empty = false
		
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
	
		
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	start_round_entities_bar_controller()
	
