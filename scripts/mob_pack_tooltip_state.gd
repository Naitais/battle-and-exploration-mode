class_name MobPackTooltipState extends State

@export var canvas_ui: CanvasLayer
@export var mouse_area: Area2D
@export var exploration_map: Node2D
@onready var ui_panel: Panel
@onready var text_label: RichTextLabel

signal show_tooltip_true

func show_tooltip():
	ui_panel=canvas_ui.get_child(0)
	text_label=ui_panel.get_child(0)
	ui_panel.visible = true
	ui_panel.position = ui_panel.get_global_mouse_position() + Vector2(-50, -50)
	#print(exploration_map.spawned_mob_packs)
	
	#print(exploration_map.spawned_mob_packs[0])
	#for i in (exploration_map.spawned_mob_packs):
		#for r in i:
			#print(r)
	for mob_pack in GlobalVar.spawned_mob_packs:
		var	mob_pack_info = ""
		for mob_data in mob_pack:
			print(GlobalVar.spawned_mob_packs)
			#print(mob_data.get("mob_pack_id"))
			var mob_info = str(mob_data.get("mob_type")) + " lvl " + str(mob_data.get("mob_level")) + " Power " + str(mob_data.get("power"))
			mob_pack_info += mob_info + "\n"

		#print(mob_pack_info)
		text_label.text = mob_pack_info
	
	
func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	show_tooltip()

