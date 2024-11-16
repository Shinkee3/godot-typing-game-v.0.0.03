extends Area2D
class_name Hurtbox


@onready var enemy: Enemy = owner ## get a reference to parent
@onready var col_shape: CollisionShape2D = $CollisionShape2D ## or possibly check for typos if the assert error pops up

func _ready() -> void:
	var warning_text: String = "The enemy %s is missing a collision shape for its Hurtbox" % enemy.name
	assert(col_shape, warning_text)

## NOTE: I rewrote this part since ideally, the node with 
## the hitbox (spell or projectile) should be responsible for calling functions on the hurtbox (enemy)
## as much as possible the hurtbox shouldnt have a reference to the hitbox unless the hitbox is complicated like SpellHitbox

func receive_spell_effect(spell: Spell) -> void:
	spell.spell_effect(enemy)


func receive_damage(damage: float) -> void:
	enemy.health -= damage

func receive_melee_damage(damage: float) -> void:
	enemy.health -= damage
#func _on_area_entered(area: Area2D) -> void:
	#if area is SpellHitbox:
		#var spell: Spell = area.get_parent()
		#spell.spell_effect(enemy)
	#elif area is ProjectileHitbox:
		#var projectile: Area2D = area
		#enemy.health -= projectile.damage
		#projectile.queue_free()
