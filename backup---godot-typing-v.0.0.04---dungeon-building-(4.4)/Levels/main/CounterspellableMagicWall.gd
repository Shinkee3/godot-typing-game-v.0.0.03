extends LineEdit

var activation_spell : String = self.placeholder_text
@onready var light_indicator = $PointLight2D
@onready var hitbox = $PointLight2D/EnemyHurtbox
@onready var timer = $LifeTime

func _on_text_submitted(new_text):
	if new_text == activation_spell:
		get_parent().queue_free()

func _on_rune_area_area_entered(area):
	self.visible = true

func _on_rune_area_area_exited(area):
	self.visible = false
	print("no more")
