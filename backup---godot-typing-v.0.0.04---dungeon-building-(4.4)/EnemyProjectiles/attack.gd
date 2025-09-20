extends Node2D

var total_time: float
var time_left: float
var fade_timer_total: float
var fade_timer_val: float

func _ready() -> void:
	total_time = $Timer.wait_time
	$TextureProgressBar.max_value = total_time
	fade_timer_total = $FadeTimer.wait_time

func _physics_process(delta: float) -> void:
	if $Timer.is_stopped() && $FadeTimer.is_stopped():
		$Timer.start()
	elif $Timer.is_stopped() == false && $FadeTimer.is_stopped():
		time_left = $Timer.time_left
		$TextureProgressBar.value = total_time - time_left
	elif modulate.a != 0:
		$Area2D.monitoring = true
		fade_timer_val = $FadeTimer.time_left/fade_timer_total
		self.modulate.a = fade_timer_val
		if $Area2D.monitoring == true && fade_timer_val < fade_timer_total/2:
			$Area2D.monitoring = false

func _on_timer_timeout() -> void:
	$Label.show()
	$FadeTimer.start()


func _on_fade_timer_timeout() -> void:
	self.modulate.a = 1
	$Label.visible = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.name == "PlayerHurtbox":
		PlayerInfo.player_health -= 40
		print("Player health is now " + str(PlayerInfo.player_health) + " and monitoring should be off.")
		$Area2D.monitoring = false
		
