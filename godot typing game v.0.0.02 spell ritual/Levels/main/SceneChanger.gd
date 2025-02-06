extends SubViewportContainer

@export_category("Scenes")

@export var scene1 = "res://Levels/main/main_test_level.tscn"
@export var scene2 = "res://Levels/arena_level.tscn"



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerInfo.player_health == 0:
		$"SubViewport/game_over".visible = true
