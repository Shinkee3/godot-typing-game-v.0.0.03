extends Node2D

@onready var markers = $PosMarkers

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shiftspace"):
		teleport_sequence()

func teleport_sequence():
	markers.global_position = PlayerInfo.player_pos
	var array1
	for pos in  markers.get_children():
		$Boss_Rewrite.global_position = pos.global_position
		await get_tree().create_timer(1.0).timeout
