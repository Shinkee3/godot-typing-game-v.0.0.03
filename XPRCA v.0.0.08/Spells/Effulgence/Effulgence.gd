extends Spell

@onready var timer_lifetime: Timer = $lifetime
@onready var sprite: Sprite2D = $Sprite2D ## visuals
@onready var hitbox: SpellHitbox = $Spell_hitbox

var speed_reduction: float = 0.5
var damage: float = 10

func _ready() -> void:
	hitbox.monitorable = false ## disable this at the start since it hasn't been casted yet
	hide()

func cast_spell(target_pos: Vector2) -> void:
	hitbox.monitorable = true
	timer_lifetime.start()
	var player_pos = PlayerInfo.player_pos
	global_position = player_pos
	show()

func _on_lifetime_timeout() -> void:
	hitbox.monitorable = false 
	hide()

func spell_effect(enemy: Enemy) -> void:
	enemy.speed = enemy.speed * speed_reduction
	print("enemy slowed")
