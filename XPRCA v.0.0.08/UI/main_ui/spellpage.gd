extends MarginContainer
class_name SpellPage_UI

## contains the info of a spell shown in the spellbook

var spell_title: String = "" ## for searchbar
var spell_tag: Spell.Tags
@onready var label_title: Label = $PanelContainer/VBox/title
@onready var label_incantation: Label = $PanelContainer/VBox/incantation
@onready var label_description: Label = $PanelContainer/VBox/description

func initialize_spellpage(spell: Spell) -> void:
	spell_title = spell.title
	spell_tag = spell.spell_tag
	label_title.text = spell.title
	label_incantation.text = "\"%s\"" % spell.incantation
	label_description.text = spell.description
