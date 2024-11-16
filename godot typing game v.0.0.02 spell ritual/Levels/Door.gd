extends Node2D

@export_category("Scene Connector")
@export var next_scene: String

func _on_area_2d_body_entered(body):
	print(body.name)
	if body.name == "Player" or "Player_melee":
		print("player entered the door")
		get_tree().change_scene_to_file(next_scene)
