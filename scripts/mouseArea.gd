extends Area2D

@onready var state_machine = $StateMachine as StateMachine
@onready var mob_pack_tooltip_state = $StateMachine/MobPackTooltipState as MobPackTooltipState
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
