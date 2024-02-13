extends Node2D

var detect_teams: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	detect_teams = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_entities_involved_in_combat_body_entered(body):
	GlobalVar.entities_in_combat.append(body)
	
func _on_entities_involved_in_combat_body_exited(body):
	#when entity exits combat map reset tean tag
	body.entity_info["team_tag"] = " "
	
#detects entities in RED TEAM
func _on_red_team_area_body_entered(body):
	#set team
	if detect_teams and body != GlobalVar.roaming_mob:
		GlobalVar.red_team.append(body)
		body.entity_info["team_tag"] = "red"
		
func _on_red_team_area_body_exited(_body):
	pass # Replace with function body.

#detects entities in BLUE TEAM
func _on_blue_team_area_body_entered(body):
	#set team
	if detect_teams:
		GlobalVar.blue_team.append(body)
		body.entity_info["team_tag"] = "blue"
		
func _on_blue_team_area_body_exited(_body):
	pass # Replace with function body.
