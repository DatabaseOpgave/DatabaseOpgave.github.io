extends Area2D

func _process(_delta):
	visibility()

func visibility():
	if GlobalScript.Stage == 1:
		self.visible = false
	else:
		self.visible = true

	


func _on_Area2D_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene("res://Scenes/Training 2.tscn")
		GlobalScript.Stage += 1
