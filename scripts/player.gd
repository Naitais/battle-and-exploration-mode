class_name Player

extends "res://scripts/baseEntity.gd"
@onready var state_machine = $StateMachine as StateMachine
@onready var idle_state = $StateMachine/IdleState as IdleState
@onready var attack_state = $StateMachine/AttackState as AttackState
@onready var move_state = $StateMachine/MoveState as MoveState
@onready var hurt_state = $StateMachine/HurtState as HurtState

func _ready():
	$Hitbox/CollisionShape2D.disabled = true
	move_state.movement_key_pressed.connect(state_machine.change_state.bind(move_state))
	move_state.player_not_moving.connect(state_machine.change_state.bind(idle_state))
	attack_state.execute_basic_attack.connect(state_machine.change_state.bind(attack_state))
	attack_state.basic_attack_animation_finished.connect(state_machine.change_state.bind(idle_state))
	hurt_state.damage_taken.connect(state_machine.change_state.bind(hurt_state))
	hurt_state.damage_taken_finished.connect(state_machine.change_state.bind(idle_state))
	
	#wander_state.objective_found.connect(state_machine.change_state.bind(chase_state))
func _input(event):
	if $AnimationPlayer.current_animation == attack_state.animation_name:
		await $AnimationPlayer.animation_finished
	#determino si el input es de movimiento o no
	var characters: Array = ["w","a","s","d"]
	if event is InputEventKey:
		var key_pressed = char(event.unicode)
		for character in characters:
			if character == key_pressed:
				move_state.movement_key_pressed.emit()
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	basic_attack()
	
func basic_attack():
	if Input.is_action_pressed("left_click"):
		attack_state.execute_basic_attack.emit()

func _on_animation_player_animation_finished(basic_attack_animation_name):
	attack_state.basic_attack_animation_finished.emit()


func _on_hurtbox_area_entered(hitbox):
	if hitbox:
		hurt_state.damage_taken.emit()
