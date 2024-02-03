class_name Mob

extends "res://scripts/baseEntity.gd"

@onready var state_machine = $StateMachine as StateMachine
@onready var wander_state = $StateMachine/WanderState as WanderState
@onready var chase_state = $StateMachine/Chase as ChaseState
@onready var attack_state = $StateMachine/AttackState as AttackState
@onready var hurt_state = $StateMachine/HurtState as HurtState
@onready var panel_container = $PanelContainer

var mob_level: int = randi() % 5 + 1
var mob_power: int = (3 * mob_level) + (randi() % mob_level + 1) + mob_level

#dictionary with mob info

var mob_info: Dictionary = {
	"power": mob_power,
	"level":mob_level,
	"armor": armor,
	"magic shield": magic_shield,
	"initiative": initiative,
	"physical damage": physical_damage
}

func _ready():
	#emito señales para que se cambie el estado de la state machine
	wander_state.objective_found.connect(state_machine.change_state.bind(chase_state))
	chase_state.objective_lost.connect(state_machine.change_state.bind(wander_state))
	attack_state.objective_lost.connect(state_machine.change_state.bind(chase_state))
	attack_state.execute_basic_attack.connect(state_machine.change_state.bind(attack_state))
	hurt_state.damage_taken.connect(state_machine.change_state.bind(hurt_state))
	hurt_state.damage_taken_finished.connect(state_machine.change_state.bind(chase_state))
	
	print(mob_info)
func exploration_mode_movement():
	if velocity.length() > 0:
		animate.play("idle") #here we place the run animation
	if velocity.x > 0:
		animate.flip_h = true
		attack_state.hitbox_collision.position.x = attack_state.hitbox_pos_flip_true
		attack_state.basic_attack_detection_area.position.x = attack_state.basic_attack_det_area_flip_true 
	elif velocity.x < 0:
		animate.flip_h = false
		attack_state.hitbox_collision.position.x = attack_state.hitbox_pos_flip_false
		attack_state.basic_attack_detection_area.position.x = attack_state.basic_attack_det_area_flip_false
		
func _physics_process(_delta):
	if GlobalVar.exploration_mode:
		move_and_slide()
		exploration_mode_movement()
	
func _on_objective_detection_area_body_entered(body):
	#emito señales para que se cambie el estado de la state machine
	if body == GlobalVar.player:
		wander_state.objective_found.emit()

func _on_objective_detection_area_body_exited(body):
	#emito señales para que se cambie el estado de la state machine
	if body == GlobalVar.player:
		chase_state.objective_lost.emit()

func _on_basic_attack_area_body_entered(body):
	if body == GlobalVar.player and GlobalVar.exploration_mode:
		attack_state.execute_basic_attack.emit()

func _on_basic_attack_area_body_exited(body):
	if body == GlobalVar.player:
		if $AnimationPlayer.current_animation == attack_state.animation_name:
			await $AnimationPlayer.animation_finished
			attack_state.objective_lost.emit()
			
func _on_hurtbox_area_entered(hitbox):
	if hitbox:
		hitpoints -=1
		hurt_state.damage_taken.emit()
		
		#get the attacker so that I later know who goes first and to get
		#mob_pack info
		attacker = hitbox.get_parent()
		
		#hitpoints_bar_state.empty_hitpoint.emit()



func _on_tooltip_info_area_mouse_entered():
	if GlobalVar.combat_mode:
		panel_container.visible = true


func _on_tooltip_info_area_mouse_exited():
	if GlobalVar.combat_mode:
		panel_container.visible = false
