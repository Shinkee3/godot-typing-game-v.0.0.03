extends CharacterBody2D
class_name Player_melee

@onready var timer = $Weapon/Timer

var movement_target_pos: Vector2
var aim_target_pos: Vector2

var default_speed: float = 70
var run_speed: float = 100
var speed = default_speed

var default_health: float = 50
var health: float = default_health

var damage: float = 1
var can_attack = true
func _physics_process(delta):

	if Input.is_action_pressed("joystick_run"):
		speed = run_speed
	else:
		speed = default_speed
	var direction_x = Input.get_axis("l_joystick_left", "l_joystick_right")
	if direction_x:
		velocity.x = direction_x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	var direction_y = Input.get_axis("l_joystick_up", "l_joystick_down")
	if direction_y:
		velocity.y= direction_y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	var aim_direction := Input.get_vector("weapon_aim_right", "weapon_aim_left", "weapon_aim_down", "weapon_aim_up")
	if aim_direction != Vector2.ZERO:
		var angle = aim_direction.angle()
		$Weapon.global_rotation = angle
		
	move_and_slide()
	MeleePlayerInfo.melee_player_pos = global_position
	
	if Input.is_action_just_pressed("joystick_attack") && can_attack == true:
		var enemies = $Weapon/hitbox.get_overlapping_areas()
		timer.start()
		can_attack = false
		for enemy in enemies:
			enemy.receive_melee_damage(damage)
		print("attacked")
	
	




func _on_timer_timeout():
	can_attack = true
