extends Sprite



func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Scenes/EndGameMenu.tscn")
		GlobalScript.player_Health = GlobalScript.Max_health
		GlobalScript.Level += 1
