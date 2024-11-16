extends Spell

@onready var timer_lifetime: Timer = $lifetime
@onready var attack_timer: Timer = $attacktimer
@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: SpellHitbox = $Spell_hitbox

@onready var sigil_symbols: Array = []
@onready var is_written = false


func _ready() -> void:
	hitbox.monitorable = false
	hide()


func cast_spell(target_pos: Vector2) -> void:
	hitbox.monitorable = true
	global_position = target_pos
	timer_lifetime.start()
	is_written = true
	SigilInfo.visible = true
	show()


func _physics_process(delta: float) -> void:
	if visible == true:
		SigilInfo.global_position = global_position
		sigil_symbols = SigilInfo.sigil_symbols
	#sprite.rotation += 5 * delta
	#SigilInfo.global_rotation = global_rotation


func _on_lifetime_timeout() -> void:
	hitbox.monitorable = false
	is_written = false
	SigilInfo.visible = false
	hide()


func spell_effect(enemy: Enemy) -> void:
	pass

		
