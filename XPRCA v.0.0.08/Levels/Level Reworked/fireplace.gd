extends GPUParticles2D

@export var base_damage: float = 1.0
var damage_multiplier: float = 1.0
var damage: float
var actively_burning: bool = false
var can_attack: bool = true

func _physics_process(delta: float) -> void:
	if actively_burning == true && can_attack == true:
		_damage_over_time()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		damage_multiplier = 1
		actively_burning = false


func _on_hitbox_body_entered(body: Node2D) -> void:
	print(body.name)
	if body.name == "Player":
		actively_burning = true
		print("player stepping in the fire")

func _damage_over_time():
	if actively_burning == true:
		damage = base_damage * damage_multiplier
		PlayerInfo.player_health_change(-damage)
		damage_multiplier += 0.5
		can_attack = false
		await get_tree().create_timer(0.5).timeout
		can_attack = true
	else:
		return
