class_name HideMobTooltipState extends State

@export var canvas_ui: CanvasLayer
@onready var ui_panel: Panel



signal show_tooltip_false


func show_tooltip():
	ui_panel=canvas_ui.get_child(0)
	ui_panel.visible = false

func _ready():
	set_physics_process(false)

func _enter_state() -> void:
	set_physics_process(true)

func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta):
	show_tooltip()

