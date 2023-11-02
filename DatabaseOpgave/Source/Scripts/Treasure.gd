extends Area2D


func _on_Treasure1_body_entered(body):
	if body.name == "Player":
		GlobalScript.Treasure += 1
		print(GlobalScript.Treasure)
		queue_free()



func _on_Treasure2_body_entered(body):
	if body.name == "Player":
		GlobalScript.Treasure += 1
		print(GlobalScript.Treasure)
		queue_free()

func _on_Treasure3_body_entered(body):
	if body.name == "Player":
		GlobalScript.Treasure += 1
		print(GlobalScript.Treasure)
		queue_free()

func _on_Treasure4_body_entered(body):
	if body.name == "Player":
		GlobalScript.Treasure += 1
		print(GlobalScript.Treasure)
		queue_free()

func _on_Treasure5_body_entered(body):
	if body.name == "Player":
		GlobalScript.Treasure += 1
		print(GlobalScript.Treasure)
		queue_free()


func _on_Treasure6_body_entered(body):
	if body.name == "Player":
		GlobalScript.Treasure += 1
		print(GlobalScript.Treasure)
		queue_free()


func _on_Treasure7_body_entered(body):
	if body.name == "Player":
		GlobalScript.Treasure += 1
		print(GlobalScript.Treasure)
		queue_free()


func _on_Treasure8_body_entered(body):
	if body.name == "Player":
		GlobalScript.Treasure += 1
		print(GlobalScript.Treasure)
		queue_free()


func _on_Treasure9_body_entered(body):
	if body.name == "Player":
		GlobalScript.Treasure += 1
		print(GlobalScript.Treasure)
		queue_free()


func _on_Treasure10_body_entered(body):
	if body.name == "Player":
		GlobalScript.Treasure += 1
		print(GlobalScript.Treasure)
		queue_free()


func _on_Treasure_Training_body_entered(body):
	if body.name == "Player":
		GlobalScript.Stage += 1
		print(GlobalScript.Stage)
		queue_free()
