class_name Player

extends "res://scripts/baseEntity.gd"
@onready var state_machine = $StateMachine as StateMachine
@onready var state_machine_2 = $StateMachine2 as StateMachine
@onready var idle_state = $StateMachine/IdleState as IdleState
@onready var attack_state = $StateMachine/AttackState as AttackState
@onready var move_state = $StateMachine/MoveState as MoveState
@onready var hurt_state = $StateMachine/HurtState as HurtState
@onready var pathfind_state = $StateMachine2/PathfindState as PathfindState
@onready var grid_movement_state = $StateMachine/GridMovementState as GridMovementState

#@onready var game_mode_state = $StateMachine/GameModeState as GameModeState
@onready var panel_container = $PanelContainer
@onready var tooltip_title = $PanelContainer/MarginContainer/GridContainer/tooltip_title
@onready var mob_level_lbl = $PanelContainer/MarginContainer/GridContainer/mob_level_lbl
@onready var mob_power_lbl = $PanelContainer/MarginContainer/GridContainer/mob_power_lbl
@onready var mob_initiative_lbl = $PanelContainer/MarginContainer/GridContainer/mob_initiative_lbl
@onready var mob_debug_lbl = $PanelContainer/MarginContainer/GridContainer/mob_debug_lbl
@onready var mob_action_points_lbl = $PanelContainer/MarginContainer/GridContainer/mob_action_points_lbl

func _ready():
	GlobalVar.player = self
	$Hitbox/CollisionShape2D.disabled = true
	move_state.movement_key_pressed.connect(state_machine.change_state.bind(move_state))
	move_state.player_not_moving.connect(state_machine.change_state.bind(idle_state))
	attack_state.execute_basic_attack.connect(state_machine.change_state.bind(attack_state))
	attack_state.basic_attack_animation_finished.connect(state_machine.change_state.bind(idle_state))
	hurt_state.damage_taken.connect(state_machine.change_state.bind(hurt_state))
	hurt_state.damage_taken_finished.connect(state_machine.change_state.bind(idle_state))
	#pathfind_state.turn_started.connect(state_machine.change_state.bind(pathfind_state))
	#pathfind_state.turn_finished.connect(state_machine.change_state.bind(idle_state))
	grid_movement_state.turn_started.connect(state_machine.change_state.bind(grid_movement_state))
	grid_movement_state.turn_finished.connect(state_machine.change_state.bind(idle_state))
	
	#hurt_state.combat_mode_started.connect(state_machine.change_state.bind(game_mode_state))
	
	#set type of entity when added
	entity_info["type"] = type
	
	entity_info["initiative"] = initiative
	
	#set level 1
	#entity_info["level"] = 1
	
func _input(event):
	if GlobalVar.exploration_mode:
		if $AnimationPlayer.current_animation == attack_state.animation_name:
			await $AnimationPlayer.animation_finished
		#determino si el input es de movimiento o no
		var characters: Array = ["w","a","s","d"]
		if event is InputEventKey:
			var key_pressed = char(event.unicode)
			for character in characters:
				if character == key_pressed.to_lower():
					move_state.movement_key_pressed.emit()

func manage_mob_pack_tooltip_ui():
	#print("mob scene; name ",self)
	#for child in GlobalVar.mob_pack_involved_in_combat.get_children():
	#	if child.name == "spider":
	#		print("global var; name ",child)
			
	#fill tooltip lbls with info
	tooltip_title.text = str(self)
	mob_level_lbl.text = str(level)
	mob_power_lbl.text = str(power)
	mob_initiative_lbl.text = str("iniciativa: ",initiative)
	#mob_debug_lbl.text = str("turn: ",playing_turn)
	mob_debug_lbl.text = str("max_ap: ",max_action_points)
	mob_action_points_lbl.text = str("AP: ",entity_info["action_points"])
		#var mob_icon = TextureRect.new()
		#var mob_data = Label.new()
		#grid_container.add_child(mob_icon)
		#grid_container.add_child(mob_data)
				
		#get info
		#var mob_info = str(mob.name) + " lvl " + str(mob.mob_level) + " Power " + str(mob.mob_power)
		
		#settings
		#mob_icon.expand_mode = TextureRect.EXPAND_FIT_WIDTH
		#mob_icon.texture = load("res://icons/"+mob.name.to_lower()+"_icon.png")
		#mob_data.text = mob_info
func _physics_process(_delta: float) -> void:
	if GlobalVar.exploration_mode:
		move_and_slide()
		basic_attack()
	if GlobalVar.combat_mode:
		manage_mob_pack_tooltip_ui()
		$Camera2D.enabled = false
	
func basic_attack():
	if Input.is_action_pressed("left_click"):
		attack_state.execute_basic_attack.emit()

func _on_animation_player_animation_finished(_basic_attack_animation_name):
	attack_state.basic_attack_animation_finished.emit()

func _on_hurtbox_area_entered(hitbox):
	if hitbox:
		hitpoints -=1
		hurt_state.damage_taken.emit()
		#hitpoints_bar_state.empty_hitpoint.emit()
		
		#get the attacker so that I later know who goes first and to get
		#mob_pack info
		attacker = hitbox.get_parent()

func _on_tooltip_info_area_mouse_entered():
	if GlobalVar.combat_mode:
		panel_container.visible = true

func _on_tooltip_info_area_mouse_exited():
	if GlobalVar.combat_mode:
		panel_container.visible = false
