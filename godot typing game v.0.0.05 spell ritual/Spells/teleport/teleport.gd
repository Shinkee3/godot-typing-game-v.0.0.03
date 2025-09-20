extends Spell

#@onready var player: Player = get_parent().get_parent().get_parent().get_parent().get_node("Player") ## Kait: Added this

func _ready() -> void:
	hide()


func cast_spell(target_pos: Vector2) -> void:
	#player.position = target_pos
	PlayerInfo.TeleportSpell.emit(target_pos) ## It's 
	show()


func _on_lifetime_timeout() -> void:
	hide()
