extends Enemy
class_name Enemy_Skeleton

var player
#NODES
@onready var rayChecker = $PlayerDetection/RayContainer/RayCast2D
@onready var rayContainer = $PlayerDetection/RayContainer
@onready var sprite = $EnemySprite

#ATTACKS
@onready var navTimer = $PlayerDetection/NavTimer
@onready var magicRay = $PlayerDetection/RayContainer/CPUParticles2D
@onready var healthBar = $Healthbar
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
		player = body
		magicRay.show()
		if healthBar.visible == false:
			healthbar.show()
		current_status = States.PURSUIT

		

		
func search_for_player():
		rayContainer.look_at(player.position)
		
		if rayChecker.get_collider() == player:
			navTimer.stop()

		elif rayChecker.get_collider() != player:
			print("not colliding with player")
			if navTimer.is_stopped():
				navTimer.start()
				self_modulate.a = 100
			

func _on_nav_timer_timeout() -> void:
	current_status = States.IDLE
	magicRay.hide()
	if healthBar.value == max_health:
		healthBar.hide()
	print("idle now")


func move_to_player():
	p1_distance = position.distance_to(player.position)
	direction = (player.position - global_position).normalized()
	target = p1_distance
	
	if direction.x > 0.2:
		sprite.flip_h = true
	elif direction.x < 0.2:
		sprite.flip_h = false
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
	#var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	#self.position += direction * 5


func _on_enemy_hurtbox_health_changed() -> void:
	healthBar.show()
	healthBar.value = health


func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("player attacked")
		PlayerInfo.player_health_change(-base_damage)
