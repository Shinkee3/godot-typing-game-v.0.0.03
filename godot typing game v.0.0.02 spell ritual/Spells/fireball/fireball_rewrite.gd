extends Spell

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D ## visuals
@onready var hitbox: SpellHitbox = $Spell_hitbox

var damage: float = 10

func _ready() -> void:
	hitbox.monitoring = false ## disable this at the start since it hasn't been casted yet
	hide()


## the class "Spell" already has the "cast_spell" function, but
## Fireball script overwrites the stuff in the "cast_spell" function to add its own effects.
func cast_spell(target_pos: Vector2) -> void:
	global_position = target_pos
	anim_sprite.play("explode_2")
	hitbox.monitoring = true ## hitbox active (should be monitoring, not monitorable)
	show()
	
	await anim_sprite.animation_finished
	hitbox.monitoring = false ## hitbox inactive
	hide()


func spell_effect(enemy: Enemy) -> void:
	enemy.health -= damage
