extends Sprite2D

@onready var cooldown = $Cooldown
@onready var lifetime = $Lifetime
var castable: bool = true
var cast: bool = false

func _process(delta):
	if castable == true:
		lifetime.start()
		cooldown.start()
		cast = true
		castable = false
		
	if cast == true:
		self.global_position.x -= 1
		


func _on_lifetime_timeout():
	cast = false
	print("no more")
	queue_free()


func _on_cooldown_timeout():
	castable = true
