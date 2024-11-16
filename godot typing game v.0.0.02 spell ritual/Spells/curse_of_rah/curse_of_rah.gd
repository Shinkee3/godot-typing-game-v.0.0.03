extends Spell

@onready var timer_lifetime: Timer = $lifetime
@onready var attack_timer: Timer = $attacktimer
@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: SpellHitbox = $Spell_hitbox


var damage: float = 2
var damage_repeat: int = 4
var current_damage_reps = damage_repeat

func _ready() -> void:
	hitbox.monitorable = false
	hide()


func cast_spell(target_pos: Vector2) -> void:
	hitbox.monitorable = true
	global_position = target_pos
	timer_lifetime.start()
	attack_timer.start()
	current_damage_reps = damage_repeat
	print("spell refreshed")
	show()


func _physics_process(delta: float) -> void:
	pass


func _on_lifetime_timeout() -> void:
	hitbox.monitorable = false
	hide()


func spell_effect(enemy: Enemy) -> void:
	enemy.health -= damage
	current_damage_reps -= 1


func _on_attacktimer_timeout() -> void:
	if current_damage_reps != 0:
		attack_timer.start()
		var repeats_left := str(current_damage_reps)
		print("repeats left: " + repeats_left)
		current_damage_reps -= 1
		
