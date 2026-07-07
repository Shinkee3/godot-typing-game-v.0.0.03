extends Sprite2D

func _physics_process(delta: float) -> void:
	if self.visible == true:
		self.rotation += 10
	else:
		pass
