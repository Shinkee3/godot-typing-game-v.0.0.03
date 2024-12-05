extends CharacterBody2D
class_name Player

## both cursors have "Top Level" property turned on
@onready var movement_cursor: Sprite2D = $MovementCursor
@onready var aim_cursor: Sprite2D = $AimCursor
@onready var aim_guide_locked: Sprite2D = $AimGuideLocked
@onready var aim_guide_loose: Sprite2D = $AimGuideLoose

var movement_target_pos: Vector2
var aim_target_pos: Vector2

var smoothed_mouse_position: Vector2

var speed: float = 80

func _ready() -> void:
	movement_target_pos = global_position
	aim_cursor.hide()
	
	# connect signals from PlayerInfo:
	PlayerInfo.TeleportSpell.connect(_teleport_player) ## NOTE: receiver function for this signal

	PlayerInfo.player_health = 100
	print(PlayerInfo.player_health)
## unhandled lets u select searchbar without accidentally moving the character (unlike _input)
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		movement_target_pos = get_global_mouse_position()
		movement_cursor.global_position = movement_target_pos
	if event.is_action_pressed("right_click"):
		aim_target_pos = get_global_mouse_position()
		aim_cursor.global_position = aim_target_pos
		aim_cursor.show()
		aim_guide_locked.look_at(aim_target_pos)


func _physics_process(_delta: float) -> void:
	smoothed_mouse_position = lerp(smoothed_mouse_position, get_global_mouse_position(), 0.3)
	aim_guide_loose.look_at(smoothed_mouse_position)
	velocity = position.direction_to(movement_target_pos) * speed
	
	# NOTE: the PlayerInfo.player_pos variable is intended to share the Player's global_position to other scripts
	PlayerInfo.player_pos = global_position # You need the Player script to manually update the PlayerInfo autoload
	
	if position.distance_to(movement_target_pos) > 10:
		move_and_slide()
		movement_cursor.show()
	else:
		movement_cursor.hide()


func _teleport_player(target_pos: Vector2) -> void:
	global_position = target_pos
	movement_target_pos = target_pos ## just to keep the player from moving back to their initial position


func _on_player_hurtbox_area_entered(area):
	print(area)
	if area.name == "EnemyHurtbox":
		print("hurt")
		PlayerInfo.player_health -= 25
		print(PlayerInfo.player_health)
