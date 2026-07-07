extends Area2D
var focused: bool = false #if the AIM CURSOR is on the hitbox

@onready var sparkles = $SparkleArea
@onready var sparkleRay = $SparkleArea/CPUParticles2D

var player
var sparkleRay_activated : bool = false

func _on_area_entered(area: Area2D) -> void:
	if area.name == "AimCursorArea":
		focused = true
		$ExitDispellCode.show()


func _on_area_exited(area: Area2D) -> void:
	if area.name == "AimCursorArea":
		focused = false
		$ExitDispellCode.hide()


func _on_mouse_entered() -> void:
	if focused == false:
		$ExitDispellCode.show()


func _on_mouse_exited() -> void:
	if focused != true:
		$ExitDispellCode.hide()


func _on_sparkle_area_body_entered(body: Node2D) -> void:
	if body_entered:
		if body.name == "Player":
			player = body
		sparkles.show()
		sparkleRay_activated = true
		
func _physics_process(delta: float) -> void:
	if sparkleRay_activated == true:
		sparkleRay.look_at(player.position)
