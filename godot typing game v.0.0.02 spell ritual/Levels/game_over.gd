extends CanvasLayer

var old_scene = "main_test_level"

signal retry

func _on_button_pressed():
	get_tree().quit()
	



func _on_button_2_pressed():
	get_parent().get_node("game_over").visible = false
	print("button pressed")
	PlayerInfo.player_health = 100
	retry.emit()
	
	
	
