extends DialogueArea

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		_update_currentdialogue_to("")
