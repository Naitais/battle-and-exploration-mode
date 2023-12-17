extends State
class_name  HitpointsBarState

@export var actor = Entity
@export var animation_player: AnimationPlayer
@export var hitpoints_container: HBoxContainer

signal empty_hitpoint
signal empty_hitpoint_finished

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)
	
func update_hitpoints():
	if hitpoints_container.get_children():
		hitpoints_container.get_child(-1).queue_free()
		#var empty_hitpoint = load("res://scenes/empty_hitpoint.tscn").instantiate()
		#hitpoints_container.add_child(empty_hitpoint)
	else:
		print("COMBAT MODE STARTS")
		
	empty_hitpoint_finished.emit()
	
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(delta):
	update_hitpoints()
