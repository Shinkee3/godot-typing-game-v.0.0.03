extends Area2D

var focused: bool = false #if the AIM CURSOR is on the hitbox

func _on_area_entered(area: Area2D) -> void:
	if area.name == "AimCursorArea":
		focused = true
		$SpawnDispellCode.show()


func _on_area_exited(area: Area2D) -> void:
	if area.name == "AimCursorArea":
		focused = false
		$SpawnDispellCode.hide()


func _on_mouse_entered() -> void: #if this does not work in your viewports, remember to set physics object picking in the vp to true
	if focused == false:
		$SpawnDispellCode.show()


func _on_mouse_exited() -> void:
	if focused != true:
		$SpawnDispellCode.hide()
