extends PathFollow2D

func _physics_process(delta: float) -> void:
	if self.progress_ratio < 1:
		self.progress_ratio = self.progress_ratio + 0.001
		print("added progress ratio")
	else:
		self.progress_ratio = 0
