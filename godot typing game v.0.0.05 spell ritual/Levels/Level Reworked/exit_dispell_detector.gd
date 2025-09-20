extends Area2D
var focused: bool = false #if the AIM CURSOR is on the hitbox

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
