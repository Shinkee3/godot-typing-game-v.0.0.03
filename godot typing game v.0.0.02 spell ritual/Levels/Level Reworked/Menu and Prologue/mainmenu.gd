extends Control

@onready var MainScene = "res://Levels/main/main.tscn"

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(MainScene)
