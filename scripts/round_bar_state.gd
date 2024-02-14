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
		
		await get_tree().create_timer(1).timeout
		entities_container.columns = GlobalVar.entities_in_combat.size()
		#print(entities_container.columns)
	#creates and adds a label with the name of the entity 
	#later I should replace labels with texture rects containing pictures of entities
		if entity_bar_empty:
			for entity in GlobalVar.entities_in_combat:
				
				var entity_texture = TextureRect.new()
				var texture_container = Container.new()
				entities_container.scale = Vector2(5,5) #seteo el scale para agrandar imagenes de avatar
				entities_container.add_child(entity_texture)
				
				#si respeto siempre la misma estrucutra para los archivos con los nombre esto funciona
				#entity_texture.texture = load("res://sprites/characters/"+entity.entity_name.to_lower()+"_icon.png")
				entity_texture.texture = entity.get_node("entity_portrait").texture
				#print(entity.get_node("entity_portrait"))
		entity_bar_empty = false
		
		#logic for showing something to know which is the current entity playing
		for entity in GlobalVar.entities_in_combat:
			if entity.playing_turn == false:
				#print(GlobalVar.entities_in_combat.find(entity))
				#print(entities_container.get_child(0))
				#HERE MAKE EVERY RECT GRAY OR SOMTHING
				pass
			else: 
				#HERE MAKE THE RECT OF THE PLAYING EMTITY NORMAL
				pass
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
	
		
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	start_round_entities_bar_controller()
