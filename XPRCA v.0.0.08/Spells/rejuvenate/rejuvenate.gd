extends Spell

var healing_amt: int = 20

@onready var animation = $GPUParticles2D

func _ready() -> void:
	#hide()
	pass
	

func cast_spell(target_pos: Vector2) -> void:
	global_position = PlayerInfo.player_pos
	#player.position = target_pos
	var player_health = PlayerInfo.player_health
	var max_p_health = PlayerInfo.MAX_PLAYER_HEALTH
	if player_health + healing_amt > max_p_health:
		PlayerInfo.player_health_change(healing_amt)
	elif player_health > max_p_health:
		player_health += max_p_health - player_health
	animation.emitting = true
