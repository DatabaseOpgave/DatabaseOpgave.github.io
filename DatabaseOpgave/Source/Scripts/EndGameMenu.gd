extends Control



func _on_ExitGameButton_pressed():
	get_tree().quit()


func _on_NextLevelButton_pressed():
	get_tree().change_scene("res://Scenes/TileMap2.tscn")


func _on_StoreButton_pressed():
	get_tree().change_scene("res://Scenes/Store.tscn")
