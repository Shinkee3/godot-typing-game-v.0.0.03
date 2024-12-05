extends Spell

@onready var timer_lifetime: Timer = $lifetime
@onready var attack_timer: Timer = $attacktimer
@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: SpellHitbox = $Spell_hitbox

@onready var sigil_symbols: Array = []
@onready var is_written = false

var fire_sigil: Array = ["Eyelid", "woh"]

func _ready() -> void:
	hitbox.monitorable = false
	hide()


func cast_spell(target_pos: Vector2) -> void:
	SigilInfo.sigil_symbols = []
	hitbox.monitorable = true
	global_position = target_pos
	timer_lifetime.start()
	is_written = true
	SigilInfo.visible = true
	print(sigil_symbols)
	show()


func _physics_process(delta: float) -> void:
	if visible == true:
		SigilInfo.global_position = global_position
		sigil_symbols = SigilInfo.sigil_symbols
		
	if sigil_symbols == fire_sigil:
		print("fire sigil written")
		$SigilMainHandler/FireSigil.visible = true
		$SigilMainHandler/FireSigil.global_position = self.global_position
		
	#sprite.rotation += 5 * delta
	#SigilInfo.global_rotation = global_rotation


func _on_lifetime_timeout() -> void:
	hitbox.monitorable = false
	is_written = false
	SigilInfo.visible = false
	hide()


func spell_effect(enemy: Enemy) -> void:
	pass

		
