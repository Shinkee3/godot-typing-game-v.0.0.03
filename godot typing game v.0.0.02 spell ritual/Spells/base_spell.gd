extends Node2D
class_name Spell

enum Tags { ## for filtering
	ATTACK,
	UTILITY,
	SIGIL,
	OTHER,
}

@export_category("Spell details")
@export var title: String
@export var spell_tag: Tags = Tags.OTHER
@export_category("Multiline strings")
@export_multiline var incantation: String
@export_multiline var description: String # flavor text
var times_used: int = 0 # tracks how many times this spell was used

func cast_spell(target_pos: Vector2) -> void: ## this is to ensure all spells have the function "cast_spell"
	pass


func increase_use_count() -> void:
	times_used += 1
