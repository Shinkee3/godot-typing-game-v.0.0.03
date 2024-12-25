extends Node2D
class_name Main

"""
I split up the UI from the level
"""

@onready var player: Player ## intentionally left blank, given by "update_main_info" function

## % here is the "Unique Name" of node (indicated by the % symbol on the scenetree)
## With the unique name, the format is like this: variable_name: class_name = %node_name
#@onready var current_lvl: MainTestLevel = %main_test_level
@onready var current_lvl: WallsLevel = %walls_level


"""
note, once u start changing levels, change the class here 
to ## either smthg more general (Node2D) or a dedicated (Level) class if u make one
"""
@onready var spell_container: Node2D = %SpellContainer
@onready var ingame_ui: GameUI = %ingame_ui

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_main_info()


func update_main_info() -> void:
	assert(current_lvl.player, "check if the level scene has a reference to the player")
	player = current_lvl.player
	ingame_ui.initialize_game_ui(player, spell_container)
