extends Area2D
class_name EarthWall_Static

@onready var sprite: Sprite2D = $Sprite2D

var speed: float = 1
var proj_rotation = 0

func _ready() -> void:
	pass

func _on_lifetime_timeout() -> void: ## NOTE: Lifetime timer node has Autostart and One Shot ON
	queue_free()

