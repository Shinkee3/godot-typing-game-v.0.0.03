extends Spell

@onready var timer_lifetime: Timer = $lifetime


func _ready() -> void:
	hide()


func cast_spell(target_pos: Vector2) -> void:
	global_position = target_pos
	timer_lifetime.start()
	show()


func _on_lifetime_timeout() -> void:
	hide()
