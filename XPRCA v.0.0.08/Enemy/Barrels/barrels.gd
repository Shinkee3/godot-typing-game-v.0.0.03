extends Enemy
class_name Destroyable_Barrel

var player
#NODES
@onready var sprite = $EnemySprite

@onready var healthBar = $Healthbar
@onready var MAXHEALTH = healthBar.max_value
#STATUS
#not sure if this is the best way to go about it, but it does add a variable i can mess around with
enum States{
	IDLE,
	PURSUIT,
	DEAD
}

var current_status = States.IDLE


func _on_enemy_hurtbox_health_changed() -> void:
	healthBar.show()
	healthBar.value = health
	print("health bar is " + str(healthBar.value))
	if healthBar.value == 0:
		sprite.hide()
		await get_tree().create_timer(0.5).timeout
		healthBar.value = MAXHEALTH
		sprite.show()
		print("max health is " + str(MAXHEALTH))

	
	
