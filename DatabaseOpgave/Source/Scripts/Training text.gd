extends Sprite

func _process(delta):
	visibility()


func visibility():
	if GlobalScript.Stage == 2:
		self.visible = false
		
	else:
		self.visible = true
