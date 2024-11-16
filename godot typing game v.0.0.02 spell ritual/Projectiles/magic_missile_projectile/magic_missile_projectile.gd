extends Area2D
class_name MagicMissile_Projectile

var speed: float = 400
var damage: float = 2
var direction: Vector2

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	var projectile_velocity: Vector2 = direction.normalized() * speed
	translate(projectile_velocity * delta)
	print_debug(global_position) # print_debug makes it clearer from which node is doing the print


func _on_lifetime_timeout() -> void: ## NOTE: Lifetime timer node has Autostart and One Shot ON
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.has_method("receive_damage"): ## duck typing 
		area.receive_damage(damage)
		queue_free()
