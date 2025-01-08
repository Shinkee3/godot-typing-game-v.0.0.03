extends Node2D

"""
NextLevelDoor, emits a signal in the SignalBus to inform main scene that player has entered the door
and wants to go to a new level as specified by this 

make sure to set Collision Mask 4 on, since that's the collision layer of the player set in the project settings
# Layer = what am i (not everything needs a layer)
# Mask = what layer do i look for
"""

@export_file var connected_level: String

var player_entered: bool = false

func _on_area_2d_body_entered(body):
	if not player_entered:
		player_entered = true
		print_debug("Next Level door entered")
		SignalBus.next_door_entered.emit(connected_level)
	else: # to prevent player from getting stuck "teleporting" in between two doors
		await get_tree().create_timer(1.5).timeout
		player_entered = false

