extends CanvasLayer

var old_scene = "main_test_level"
const level = preload("res://Levels/main/main_test_level.tscn")

func _on_button_pressed():
	get_tree().quit()
	



func _on_button_2_pressed():
	get_parent().get_node("game_over").visible = false
	print("button pressed")
	PlayerInfo.player_health = 100
	
"""	get_parent().add_child(level.instantiate())
	old_scene = str(level.instantiate().name)
	print(get_parent().get_children())
	print(level.instantiate().name)"""
	
