extends MarginContainer
class_name enemy_spellbubble

@onready var text = $PanelContainer/MarginContainer/RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()
	clear_text()

func casting_spell(incant: String, wind_up: float = 1, cast_speed: float = 1):
	var casting_speed:float = 1/(cast_speed * 2)	 #NOTE: 0.5 is the baseline
	clear_text()
	show()
	await get_tree().create_timer(wind_up).timeout
	for i in incant.length():
		await get_tree().create_timer(casting_speed).timeout
		text.append_text(incant[i])
	hide()
	clear_text()
	return

func clear_text():
	text.text = ""
