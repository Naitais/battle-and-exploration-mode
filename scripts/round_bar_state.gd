class_name RoundBarState
extends State

@export var combat_ui: CanvasLayer
@onready var entities_container = $"../../Control/PanelContainer/entitiesContainer"
var entity_bar_empty: bool = true
signal player_not_moving

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

func start_round_entities_bar_controller():
	#sets columns with amount of entities in the round
	if GlobalVar.entities_in_combat.size() > 0:
		if entities_container.get_children().size() > 0:
			entities_container.get_child(GlobalVar.entity_index).self_modulate = Color(137,137,255,110)
		await get_tree().create_timer(1).timeout
		entities_container.columns = GlobalVar.entities_in_combat.size()
	#creates and adds a label with the name of the entity 
	#later I should replace labels with texture rects containing pictures of entities
		if entity_bar_empty:
			for entity in GlobalVar.entities_in_combat:
				var entity_portrait: PanelContainer = entity.get_node("PortraitContainer").duplicate()
				entity_portrait.visible = true
				entities_container.add_child(entity_portrait)
		entity_bar_empty = false
		
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
	
		
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	start_round_entities_bar_controller()
	print(GlobalVar.entity_index)
	
