extends Spell

@onready var timer_lifetime: Timer = $lifetime
@onready var attack_timer: Timer = $attacktimer
@onready var sprite: Sprite2D = $Sprite2D
@onready var hitbox: SpellHitbox = $Spell_hitbox

var spawn_position
var symbol_name: String = "Small_Circle"


func _ready() -> void:
	hitbox.monitorable = false
	hide()


func cast_spell(target_pos: Vector2) -> void:
	spawn_position = SigilInfo.global_position
	global_position = spawn_position
	print(spawn_position)
	hitbox.monitorable = true
	SigilInfo.sigil_symbols.append(symbol_name)
	print(SigilInfo.sigil_symbols)
	show()


func _physics_process(delta: float) -> void:
	#sprite.rotation += 5 * delta
	if visible == true && SigilInfo.visible == false:
		hitbox.monitorable = false
		hide()
	pass

func spell_effect(enemy: Enemy) -> void:
	pass
		
