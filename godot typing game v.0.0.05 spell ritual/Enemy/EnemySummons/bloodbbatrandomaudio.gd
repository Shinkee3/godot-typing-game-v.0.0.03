extends AudioStreamPlayer2D

var time: float = 0.0

func _on_finished() -> void:
	$Timer.wait_time = randf()
	$Timer.start()
	print("finished")



func _on_timer_timeout() -> void:
	self.play()
	
