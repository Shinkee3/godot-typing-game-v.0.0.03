extends Node2D

@onready var light_indicator = $InteractSample/PointLight2D
@onready var hitbox = $InteractSample/PointLight2D/EnemyHurtbox
@onready var timer = $InteractSample/LifeTime
@onready var inputbar = $InteractSample
@onready var counterspell = $InteractSample/PanelContainer/counterspell

var activation_spell : String

func _ready():
	activation_spell = counterspell.text

func _on_interact_sample_text_submitted(new_text):
	if new_text == activation_spell && timer.is_stopped():
		queue_free()
	else:
		inputbar.clear()
		print("wrong string")
func _on_rune_area_area_entered(area):
	inputbar.visible = true

func _on_rune_area_area_exited(area):
	inputbar.visible = false
	print("no more")

