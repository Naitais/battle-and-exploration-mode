extends TileMap

var grid_x: int = 12
var grid_y: int = 9
var selected_tile: Vector2
var map_dictionary: Dictionary = {}

func _ready():
	GlobalVar.combat_map = self
	for x in grid_x:
		for y in grid_y:
			map_dictionary[str(Vector2(x,y))] = { #get a dic with x and y pos of all grass type tiles
				"Selected Tile" : str(Vector2(x,y))
			}
			#set_cell(0, Vector2(x, y), 3, Vector2i(0,0), 0)
	
func _process(_delta):
	selected_tile = local_to_map(get_global_mouse_position())  #get mouse pos
	#print(selected_tile)
	#print(player)
	for x in grid_x:
		for y in grid_y:
			erase_cell(2, Vector2(x,y)) #deletes everything in layer 2 every frame
			erase_cell(1, Vector2(x,y)) #deletes everything in layer 1 every frame
			
	if map_dictionary.has(str(selected_tile)): #si el diccionario de arriba contiene la tile seleccionada entonces estamos en el mapa
		set_cell(2, selected_tile, 3,Vector2i(0,0),0) #seteo tile de "mira" como ayuda visual de tile seleccionada
	
	display_path()
	
func display_path():
	if GlobalVar.player.path:
		for point in GlobalVar.player.path:
			set_cell(1, point, 1,Vector2i(0,0),0) #sets reachable tile
