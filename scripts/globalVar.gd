extends Node

#EQUIPPED ITEMS BY PLAYER
var on_hand_weapon_slot_one: String = "magic_staff"

var entities = null
var player: CharacterBody2D
var exploration_mode: bool = true

var created_mob_packs: Array = []
var instantiated_mobs: Array
var roaming_mob: CharacterBody2D

#COMBAT VARIABLES
var combat_mode: bool
var mob_pack_involved_in_combat: Node
var entities_in_combat: Array = []
var red_team: Array = []
var blue_team: Array = []
var turn_end: bool
var combat_map: TileMap

#for managing turns
var entity_index: int = 0

#for pathfind
var occupied_tiles: Array = []
var astargrid = AStarGrid2D.new()

func set_astargrid():
	#PATHFINDING display players movement path
	astargrid.region = Rect2i(0, 0, 12, 9)
	astargrid.cell_size = Vector2i(32, 32)
	#seteo movimiento sin diagonales
	astargrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astargrid.update()

#in the futurre I will need a globalvar for different things such as managing spawned mob packs
#this array stores every spawned mob_pack so that when a combat starts, it will get a specific mob_pack
#(maybe it will get the mob_pack id when I get a database) to spawn every mob in the pack in a battle map

#CURSORS
var cursor_default = preload("res://sprites/cursor_default.png")
var cursor_click = preload("res://sprites/cursor_click.png")
var cursor_open_container = preload("res://sprites/cursor_open_container.png")

#Input.set_custom_mouse_cursor(GlobalVar.attack_cursor, Input.CURSOR_ARROW, Vector2(16,16))

func _physics_process(_delta):
	pass
	
func _ready():
	set_astargrid()
	
	
