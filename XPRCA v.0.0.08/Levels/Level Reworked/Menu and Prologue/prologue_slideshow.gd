extends VBoxContainer

var imageDictionary = []
var textDictionary = []

func _unhandled_input(event: InputEvent) -> void:
	print(event)
	if event.is_action_pressed("enter"):
		print("enter pressed")
		$TextureRect.texture = load("res://Assets/custom sprites/sapirica slideshow test.png")
	elif event.is_action_pressed("shiftspace"):
		print("shiftspace pressed")
		$TextureRect.texture = load("res://Assets/custom sprites/sapirica slideshow test2.png")
