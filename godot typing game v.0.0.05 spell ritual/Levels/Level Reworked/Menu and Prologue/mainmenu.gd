extends Control

@onready var MainScene = "res://Levels/main/main.tscn"

func _on_start_button_pressed() -> void:
	$LoadingScreen.show()
	print("show loading screen")
	await get_tree().create_timer(0.1).timeout
	get_tree().change_scene_to_file(MainScene)

func _on_exit_button_pressed() -> void:
	get_tree().quit()
