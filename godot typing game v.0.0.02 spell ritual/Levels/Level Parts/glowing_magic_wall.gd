extends Node2D

@export_category("Parts")
@export var Counterspell: Node 

func _on_rune_area_area_entered(area):
	Counterspell.visible = true
	print("area entered")

func _on_rune_area_area_exited(area):
	Counterspell.visible = false
	print("should be invisible now")
