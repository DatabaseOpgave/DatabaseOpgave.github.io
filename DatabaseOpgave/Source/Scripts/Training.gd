extends Node2D




func _on_Training_door_2_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Scenes/mainMenu.tscn")
		GlobalScript.Stage += 1
