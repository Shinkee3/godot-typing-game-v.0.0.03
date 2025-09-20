extends Node2D
class_name BaseLevel

@onready var player: Player = $Player
@onready var player_initial_pos: Vector2 = player.position # currently not used, but can be useful
# if incase u wanna reset the player position back if they return to the level
