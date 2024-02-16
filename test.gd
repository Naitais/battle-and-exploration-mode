extends Node2D

var list: Array = [1,0,0]
var r: int = 0
# Called when the node enters the scene tree for the first time.

func set_true():
	for i in list:
		if i != 0:
			print("turn action", i)
	

func _process(delta):
	#set_true()
	for i in list:
		var area_2d_test: Area2D
	

func _on_button_pressed():
	print(list.size()-1)
	print("antes de sumar",r)
	if r < list.size()-1:
		list[r] = 0
		list[r+1] = r+1
		
		r +=1
		print("despues de sumar",r)
	else:
		r = 0
		for i in list:
			i = 0
		list[0] = 1
		print("termino ronda y reseteo")
