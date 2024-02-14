extends CanvasLayer

@onready var player = get_parent().get_children()[1]

@onready var hit_points_bar = %HitPointsBar
@onready var ap_points_bar = %APPointsBar
@onready var energy_bar = %EnergyBar
@onready var mana_bar = %ManaBar

func _ready():
	pass

func _physics_process(delta):
	#manage HEALTH POINTS
	hit_points_bar.max_value = player.max_health
	hit_points_bar.value = player.health
	
	#manage AP POINTS
	ap_points_bar.max_value = player.max_AP
	ap_points_bar.value = player.AP

	#manage ENERGY POINTS
	energy_bar.max_value = player.max_energy
	energy_bar.value = player.energy
	
	#manage MANA POINTS
	mana_bar.max_value = player.max_mana
	mana_bar.value = player.mana
