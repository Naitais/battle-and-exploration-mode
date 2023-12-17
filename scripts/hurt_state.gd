class_name HurtState
extends State

@export var actor: Entity
@export var animation_player: AnimationPlayer
@export var animation_name: String
@export var hitpoints_container: HBoxContainer

signal damage_taken
signal damage_taken_finished
signal combat_mode_started

func update_hitpoints():
	if hitpoints_container.get_children():
		hitpoints_container.get_child(-1).queue_free()
		
	if actor.hitpoints == 0:
		combat_mode_started.emit()
		GlobalVar.exploration_mode = false
		GlobalVar.combat_mode = true

func _ready():
	#con esto hago que este desactivado el fisics prouces
	set_physics_process(false)

func _enter_state() -> void:
	#solo se activa cuando entro al state wander
	set_physics_process(true)
	
func _exit_state() -> void:
	#cuando se sale se pone false
	set_physics_process(false)
	
func _physics_process(delta):
	animation_player.play("take_damage")
	#if $AnimationPlayer.current_animation == animation_name:
	await animation_player.animation_finished
	update_hitpoints()
	damage_taken_finished.emit()
	
