extends Area2D
@onready var collision_shape_2d = $CollisionShape2D
@onready var grid_container: GridContainer = get_parent().get_parent().get_parent()
@onready var portrait_container: PanelContainer = get_parent().get_parent()
@onready var selected_entity = GlobalVar.entities_in_combat[grid_container.get_children().find(portrait_container)]
# Called when the node enters the scene tree for the first time.
func _ready():
	
	#set position and size so that it fits the portrait
	collision_shape_2d.scale = Vector2(2,4)
	collision_shape_2d.position = Vector2(15,0) 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mouse_entered():
	selected_entity.get_node("entity_top_selector").visible = true
	
func _on_mouse_exited():
	selected_entity.get_node("entity_top_selector").visible = false
