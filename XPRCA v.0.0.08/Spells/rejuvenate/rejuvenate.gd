extends Spell

@export var healing: int = 25

@onready var animation = $GPUParticles2D

func _ready() -> void:
	#hide()
	pass
	

func cast_spell(target_pos: Vector2) -> void:
	global_position = PlayerInfo.player_pos
	#player.position = target_pos
	PlayerInfo.player_health_change(healing)
	animation.emitting = true
