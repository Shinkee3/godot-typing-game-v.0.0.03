extends Control

#@onready var prompt = $Panel/RichTextLabel
#@onready var panel = $Panel
@onready var prompt_container = $PromptContainer
var time: String
var info = {"time": time, "dietyname" : "Shelob"}
var prompt_text

var active_prompt = null
var current_letter_index = -1

"""var user = {"name": "John", "age": 20} 
var text = "Hello {name}! You are {age} years old
print(text.format(user))

String Format https://www.reddit.com/r/godot/comments/v3wo2j/how_to_replace_variables_in_a_string_with_their/


# Called when the node enters the scene tree for the first time
func _ready() -> void:
	prompt_text = prompt.text
	info.time = Time.get_time_string_from_system()
	prompt.text = prompt_text.format(info)
	prompt_text = prompt.text
	print(prompt_text)
### Leave nothing in my wake. I will be consumed.
### _____

### I invoke you."""
func find_new_active_prompt(typed_character: String):
	for panel in prompt_container.get_children():
		prompt_text = panel.get_prompt()
		var next_character = prompt_text.substr(0 , 1)
		if  next_character == typed_character: #firsc character (index zero) lenght of one (1)
			print("found new prompt that starts with %s" % typed_character)
			active_prompt = panel
			current_letter_index = 1
			active_prompt.set_next_character(current_letter_index) 
			return #stops this for loop from looking for mroe active enemies
		
func _unhandled_input(event: InputEvent) -> void: #you can do this instead of putting input event + event as inputkey
	if event is InputEventKey and event.is_pressed():
		event.set_echo(false)
		var typed_event = event as InputEventKey #bro idk why this needs event as input event key but idk man
		var key_typed = (PackedByteArray([typed_event.unicode])).get_string_from_utf8() # so this has an error. looking into removing the echo
		if active_prompt == null:
			find_new_active_prompt(key_typed)
		else:
			var next_character = prompt_text.substr(current_letter_index, 1) #confused abt the tutorial on this part
			if key_typed == next_character:
				print("successfully typed %s" % key_typed)
				current_letter_index += 1
				active_prompt.set_next_character(current_letter_index) # everytime it updates the count, the colors are updated, also when the enemy is first discovered
				if current_letter_index == prompt_text.length():
					print("done")
					current_letter_index = -1
					active_prompt.queue_free()
					active_prompt = null
			else:
				print("incorrectly typed %s instead of %s" %[key_typed, next_character])
