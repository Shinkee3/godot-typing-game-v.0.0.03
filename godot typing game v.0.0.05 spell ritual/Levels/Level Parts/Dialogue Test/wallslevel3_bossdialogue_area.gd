extends DialogueArea

@export_category("Dialogue")
@export var dialogue: String

@onready var casterSpriteDud = $EnemySprite

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		_update_currentdialogue_to(dialogue)
		#casterSpriteDud.show()
