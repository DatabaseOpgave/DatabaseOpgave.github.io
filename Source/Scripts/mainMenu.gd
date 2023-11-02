extends Node2D


export var mainWorld : PackedScene

func _ready():
		$Login.text = GlobalScript.User_text 

func _on_PlayGameButton_pressed():
	get_tree().change_scene("res://Scenes/TileMap.tscn")
	GlobalScript.Stage += 300
	GlobalScript.Treasure == 0


func _on_ExitButton_pressed():
	get_tree().quit()


func _on_Login_pressed():
	get_tree().change_scene("res://Login.tscn")


func _on_TrainingButton_pressed():
	get_tree().change_scene("res://Scenes/Training.tscn")

