extends Node2D
class_name Spell

enum Tags { ## for filtering
	ATTACK,
	UTILITY,
	MINION,
	OTHER,
}

@export_category("Spell details")
@export var title: String
@export var spell_tag: Tags = Tags.OTHER
@export_category("Multiline strings")
@export_multiline var incantation: String
@export_multiline var description: String # flavor text

func cast_spell(target_pos: Vector2) -> void: ## this is to ensure all spells have the function "cast_spell"
	pass
