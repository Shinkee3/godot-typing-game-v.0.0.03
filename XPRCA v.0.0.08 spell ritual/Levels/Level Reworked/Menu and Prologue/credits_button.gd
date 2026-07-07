extends Button

var credits_page

func _ready() -> void:
	credits_page = $CreditsPage

func _on_pressed() -> void:
	credits_page.show()


func _on_button_pressed() -> void:
	credits_page.hide()
