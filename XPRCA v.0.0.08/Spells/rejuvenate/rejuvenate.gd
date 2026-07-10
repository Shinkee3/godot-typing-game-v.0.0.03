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
	
	if player_health <= max_p_health - healing_amt:
		PlayerInfo.player_health_change(healing_amt)
		animation.emitting = true
		print("healed")
	elif player_health < max_p_health:
		PlayerInfo.player_health = max_p_health
		print(player_health)
		print("healed")
		animation.emitting = true
	print(player_health)
