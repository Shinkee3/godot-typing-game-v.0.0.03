extends Enemy
class_name Enemy_Skeleton

var player
#NODES
@onready var rayChecker = $PlayerDetection/RayContainer/RayCast2D
@onready var rayContainer = $PlayerDetection/RayContainer

@onready var navTimer = $PlayerDetection/NavTimer
#STATUS
#not sure if this is the best way to go about it, but it does add a variable i can mess around with
enum States{
	IDLE,
	PURSUIT,
	DEAD
}

var current_status = States.IDLE


#[=========]

func _on_detection_range_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("in area range")
		player = body
		current_status = States.PURSUIT

		

		
func search_for_player():
		rayContainer.look_at(player.position)
		
		if rayChecker.get_collider() == player:
			print("ray is colliding with " + str(rayChecker.get_collider()))
			navTimer.stop()

		elif rayChecker.get_collider() != player:
			print("not colliding with player")
			print(navTimer.time_left)
			if navTimer.is_stopped():
				navTimer.start()
			

func _on_nav_timer_timeout() -> void:
	current_status = States.IDLE
	print("idle now")


func move_to_player():
	p1_distance = position.distance_to(player.position)
	direction = (player.position - global_position).normalized()
	target = p1_distance
	print(target)
	if target > 5:
		velocity = direction * speed
		move_and_slide()
		
#[=========]
func _physics_process(delta: float) -> void:
	if current_status == States.IDLE:
		pass
	elif current_status == States.PURSUIT:
		search_for_player()
		move_to_player()
	elif current_status == States.DEAD:
		pass		
"""	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	self.position += direction * 5"""
