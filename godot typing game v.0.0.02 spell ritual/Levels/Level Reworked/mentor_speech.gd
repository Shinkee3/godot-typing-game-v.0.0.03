extends MarginContainer

@onready var textbox: Node = $PanelContainer/MarginContainer/RichTextLabel
var script_counter: int = -1
const script_counter_reset: int = -1
var script_length: int

var current_script #this is to start making space for building up
var script_1: Array[String] = ["Test", "Anatha test", "Da third test", "fouth test"]

func _ready() -> void:
	assign_script()

func _input(event: InputEvent) -> void:
	"""This could use some more finesse. Perhaps once two-three keys 
	are pressed the speech bubble disappears. Also the thing where 
	speech bubbles overlap is a bit of a problem. Perhaps giving it an area 
	that if it detects, it will adjust to the player speech bubble.
	
	I think the player speech bubble holds higher priority since it needs to be
	present all the time.
	
	Then 
	"""
	#if not event.is_action_pressed("enter"): #Does not work. 
	#	self.hide()
	if event.is_action_pressed("enter"):
		if script_counter < script_length && current_script != null:
			if self.visible == false:
				self.show()
			script_counter += 1
			textbox.text = script_1[script_counter]
		else:
			script_counter = script_counter_reset
			current_script = null
			print("end of script")
			self.hide()

			
func assign_script():
	current_script = script_1
	script_length = current_script.size() - 1
