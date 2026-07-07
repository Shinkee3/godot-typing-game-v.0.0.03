extends Area2D
class_name EarthWall_Projectile

@onready var sprite: Sprite2D = $Sprite2D

var speed: float = 1
var proj_rotation = 0

func _ready() -> void:
	pass
	
func _physics_process(delta):
	self.position += Vector2(speed,0).rotated(proj_rotation)

func _on_lifetime_timeout() -> void: ## NOTE: Lifetime timer node has Autostart and One Shot ON
	queue_free()

