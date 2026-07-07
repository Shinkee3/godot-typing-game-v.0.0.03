extends DialogueArea

@export_category("Dialogue")
@export var dialogue: String

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		_update_currentdialogue_to(dialogue)
		queue_free()
