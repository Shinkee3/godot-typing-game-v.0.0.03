extends Node2D

var total_time: float
var time_left: float
var fade_timer_total: float
var fade_timer_val: float

var is_fading = false

var spawnpos: Vector2

func _ready() -> void:
	total_time = $Timer.wait_time
	$TextureProgressBar.max_value = total_time
	fade_timer_total = $FadeTimer.wait_time

func _spawn_at_position_and_start():
	if $Timer.is_stopped() && $FadeTimer.is_stopped():
		$Timer.start()
		#self.position = spawnpos
		self.visible = true
		self.modulate.a = 100
		is_fading = false
		$Area2D.position = Vector2(0.5, 0) #why is this here? well because if the area 2d spawns on top of th eplayer it does not register so that's a problem

func _physics_process(delta: float) -> void:
	if $Timer.is_stopped() == false :
		time_left = $Timer.time_left
		$TextureProgressBar.value = total_time - time_left
	if is_fading == true:
		fade_timer_val = $FadeTimer.time_left/fade_timer_total
		self.modulate.a = fade_timer_val
		if $Area2D.monitoring == true && fade_timer_val < fade_timer_total/2:
			$Area2D.monitoring = false

func _on_timer_timeout() -> void:
	$Label.show()
	$FadeTimer.start()
	is_fading = true
	$Area2D.position = self.position
	$Area2D.monitoring = true # is now looking for attack


func _on_fade_timer_timeout() -> void:
	$Label.visible = false
	self.visible = false
	is_fading = false

func _on_area_2d_area_entered(area: Area2D) -> void:
	print(area.name)
	if area.name == "PlayerHurtbox":
		PlayerInfo.player_health -= 40
		print("Player health is now " + str(PlayerInfo.player_health) + " and monitoring should be off.")
		#$Area2D.monitoring = false
		

func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_text_backspace"):
		#print("ui backspace clicked, starting countdown")
		#_spawn_at_position_and_start()
	pass
