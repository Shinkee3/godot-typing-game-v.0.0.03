extends Enemy
class_name Enemy_Boss

var player

@onready var healthBar = $Healthbar

func _on_enemy_hurtbox_health_changed() -> void:
	healthBar.show()
	healthBar.value = health
