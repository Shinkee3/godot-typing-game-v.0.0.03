extends LineEdit

var activation_spell : String = self.placeholder_text
@onready var light_indicator = $PointLight2D
@onready var hitbox = $PointLight2D/EnemyHurtbox
@onready var timer = $LifeTime

#This is done so that this same script can be used both for enemies and for spells
@export_category("Counter Spell Parts")
@export var queue_free_parent: Node2D


func _ready():
	activation_spell = self.placeholder_text
	# A separate prompt area may be made, right now that is not my focus though

func _on_text_submitted(new_text):
	if new_text == activation_spell:
		queue_free_parent.queue_free()
