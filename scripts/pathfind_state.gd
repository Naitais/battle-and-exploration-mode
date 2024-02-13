class_name  PathfindState
extends State

@export var actor: CharacterBody2D
var astargrid = AStarGrid2D.new()

signal create_pathfind

func set_astargrid():
	#PATHFINDING display players movement path
	astargrid.region = Rect2i(0, 0, 12, 9)
	astargrid.cell_size = Vector2i(32, 32)
	#seteo movimiento sin diagonales
	astargrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astargrid.update()

func get_pathfinding(initial_pos, final_pos):
	#creo el path
	var path = astargrid.get_id_path(initial_pos, final_pos)
	return path

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)
	set_astargrid()
	
func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
		
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(_delta):
	print(get_pathfinding(actor.global_position, actor.get_global_mouse_position()))
