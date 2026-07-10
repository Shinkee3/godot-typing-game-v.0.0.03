extends Control
class_name Main

"""
I split up the UI from the level
"""

@onready var player: Player ## intentionally left blank, given by "update_main_info" function

## % here is the "Unique Name" of node (indicated by the % symbol on the scenetree)
## With the unique name, the format is like this: variable_name: class_name = %node_name
#@onready var current_lvl: MainTestLevel = %main_test_level
@onready var current_lvl: BaseLevel = null #%walls_level
@onready var sub_viewport: SubViewport = %SubViewport

# NOTE: Make sure to update level_reference with new levels you want to add, 
# add more code in _instantiate_levels() to support the new levels
var hub_level_path: String = "res://Levels/Level Reworked/hub_level.tscn"
var walls_level_path: String = "res://Levels/Level Reworked/walls_level.tscn"
var walls_level_2_path: String = "uid://bnko63sjwby0s"
var walls_level_3_path:String = "res://Levels/Level Reworked/walls_level_3.tscn"
var walls_level_4_path:String = "uid://bb1g6ix2mk6ym"
#var special_level_path:String = "res://Levels/Level Reworked/special_level.tscn"
var level_reference: Dictionary = {}

"""
note, once u start changing levels, change the class here 
to ## either smthg more general (Node2D) or a dedicated (Level) class if u make one
"""
@onready var spell_container: Node2D = %SpellContainer
@onready var ingame_ui: GameUI = %ingame_ui

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_instantiate_levels()
	go_to_next_level(hub_level_path)
	
	_update_main_info()
	
	# always remember that signals (once emitted) 
	# wont do anything UNLESS someone is connected to them. in this case
	# main.gd is connected to next_door_entered signal
	SignalBus.next_door_entered.connect(on_next_door_entered)

func _instantiate_levels() -> void:
	"NOTE: WHEN U ADD NEW LEVELS, UPDATE THIS FUNCTION TO SUPPORT THEM"
	var hub_level: PackedScene = load(hub_level_path)
	var walls_level: PackedScene = load(walls_level_path)
	var walls_level_2: PackedScene = load(walls_level_2_path)
	var walls_level_3: PackedScene = load(walls_level_3_path)
	var walls_level_4: PackedScene = load(walls_level_4_path)
#	var special_level: PackedScene = load(special_level_path)
	level_reference[hub_level_path] = hub_level.instantiate()
	level_reference[walls_level_path] = walls_level.instantiate()
	level_reference[walls_level_2_path] = walls_level_2.instantiate()
	level_reference[walls_level_3_path] = walls_level_3.instantiate()
	level_reference[walls_level_4_path] = walls_level_4.instantiate()
#	level_reference[special_level_path] = special_level.instantiate()

func _update_main_info() -> void:
	assert(current_lvl.player, "check if the level scene has a reference to the player")
	if current_lvl != null:
		player = current_lvl.player
		ingame_ui.initialize_game_ui(spell_container)


# main receiver function for next_door_entered signal
func on_next_door_entered(path: String) -> void:
	print(path)
	call_deferred("go_to_next_level", path) # has to be deferred due to nodes shenanigens

func go_to_next_level(next_level_path: String) -> void:
	if next_level_path in level_reference.keys():
		if current_lvl != null:
			sub_viewport.remove_child(current_lvl)
		current_lvl = level_reference[next_level_path]
		sub_viewport.add_child(current_lvl)
	#	reset_target_pos()
	else:
		print("ERROR in main.gd: Specified next_level_path has not been instantiated in _instantiate_levels()")
	# remove previous level
	
#func reset_target_pos():
#	PlayerInfo.$AimCursor
	
  # reset target pos but dont use unused param here


func _on_game_over_retry() -> void:
	go_to_next_level(hub_level_path)

# CHEATS
# adding some cheatcodes to skip things
# There should be a better way to this type of thing

func _on_line_edit_text_submitted(new_text: String) -> void:
	if "skip to level" in new_text:
		if new_text[-1] == "0":
			go_to_next_level(hub_level_path)
		elif new_text[-1] == "1":
			go_to_next_level(walls_level_path)
		elif new_text[-1] == "2":
			go_to_next_level(walls_level_2_path)
		elif new_text[-1] == "3":
			go_to_next_level(walls_level_3_path)
		elif new_text[-1] == "4":
			go_to_next_level(walls_level_4_path)
			print(new_text[-1])
		elif new_text[-1] == "5":
			go_to_next_level(hub_level_path)
		else:
			pass
	elif "godmode" in new_text:
		PlayerInfo.player_health_change(9999)
	elif "mortalmode" in new_text:
		PlayerInfo.player_health_change(100)
	
	$CanvasLayer/LineEdit.clear()
