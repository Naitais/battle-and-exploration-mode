extends Node2D

const DOUBLETAP_DELAY = 0.25
var doubletap_time = DOUBLETAP_DELAY
var last_keycode = 0

func _process(delta):
	input()
	doubletap_time -= delta

func input():
	if Input.is_action_just_pressed("left_click"):
		if doubletap_time > 0:
			print("Left mouse button double-clicked")
			# Add your logic for handling left mouse button double-click action here
		doubletap_time = DOUBLETAP_DELAY


