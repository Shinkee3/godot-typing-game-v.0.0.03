extends HBoxContainer


func _unhandled_key_input(event):
	if Input.is_action_just_released("enter"):
		PlayerInfo.player_health -= 10
		$healthbar.value = PlayerInfo.player_health
