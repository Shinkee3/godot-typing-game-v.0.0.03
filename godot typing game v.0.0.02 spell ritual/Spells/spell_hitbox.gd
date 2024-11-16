extends Area2D
class_name SpellHitbox

## Dont put a collision box at "spell_hitbox.tscn"
## instead, put the collision box for SpellHitbox once this scene has been attached to a Spell scene

@onready var spell: Spell = get_parent()
@onready var col_shape: CollisionShape2D = $CollisionShape2D ## or possibly check for typos if the assert error pops up

func _ready() -> void:
	var warning_text: String = "The spell %s is missing a collision shape for its SpellHitbox" % spell.name
	assert(col_shape, warning_text)

func _on_area_entered(area: Area2D) -> void:
	if area is Hurtbox:
		var hurtbox: Hurtbox = area
		hurtbox.receive_spell_effect(spell)
