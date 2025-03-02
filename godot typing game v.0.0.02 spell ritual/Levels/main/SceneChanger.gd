extends SubViewportContainer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if PlayerInfo.player_health == 0:
		$"SubViewport/game_over".visible = true
