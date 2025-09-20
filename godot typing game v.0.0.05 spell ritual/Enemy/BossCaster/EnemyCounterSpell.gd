extends Area2D

@export_category("Parts")
@export var Counterspell: Node 

func _on_area_entered(area):
	print("area entered")
	Counterspell.visible = true


func _on_area_exited(area):
	Counterspell.visible = false
