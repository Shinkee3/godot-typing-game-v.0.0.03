extends LineEdit

var activation_spell : String = self.placeholder_text
@onready var light_indicator = $PointLight2D
@onready var hitbox = $PointLight2D/EnemyHurtbox
@onready var timer = $LifeTime

func _on_text_submitted(new_text):
	if new_text == activation_spell && timer.is_stopped():
		self.clear()
		activate_rune()
	else:
		self.clear()

func _on_life_time_timeout():
	print(timer.is_stopped())
	deactivate_rune()
	
func activate_rune():
	light_indicator.visible = true
	hitbox.monitorable = true
	timer.start()
	
func deactivate_rune():
	light_indicator.visible = false
	hitbox.monitorable = false


func _on_rune_area_mouse_entered():
	print("mouse entered")


func _on_rune_area_area_entered(area):
	self.visible = true

func _on_rune_area_area_exited(area):
	self.visible = false
	print("no more")
