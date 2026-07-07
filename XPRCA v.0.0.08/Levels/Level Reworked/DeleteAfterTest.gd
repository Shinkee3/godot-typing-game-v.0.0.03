extends Node2D

var speed = 120

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	
	if direction.x != 0.0:
		self.global_position.x += direction.x * speed
		print(global_position.x)
	if direction.y!= 0.0:
		self.global_position.y += direction.y * speed
	print(global_position)
	#	velocity = direction * speed
	#elif Input.is_action_pressed("run"):
	#	velocity = direction * sprint_speed
