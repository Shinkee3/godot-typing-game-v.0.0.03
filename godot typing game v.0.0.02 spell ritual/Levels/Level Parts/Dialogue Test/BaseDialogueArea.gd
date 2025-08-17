extends Area2D
class_name DialogueArea

var triggered = false
var currentdialogue: String

func _update_currentdialogue_to(currentdialogue):
	PlayerInfo.currentdialogue = currentdialogue
	PlayerInfo.indialogue = true
	print("dialogue changed to " + PlayerInfo.currentdialogue)
	triggered = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter") && triggered == true:
		queue_free()
