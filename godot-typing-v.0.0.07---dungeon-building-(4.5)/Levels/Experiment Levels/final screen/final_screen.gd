extends RichTextLabel

@onready var prompt = self
@onready var panel = $Panel

var time: String
var info = {"time": time, "dietyname" : "Shelob"}
var prompt_text 

var active_prompt = null
var current_letter_index = -1

"""var user = {"name": "John", "age": 20} 
var text = "Hello {name}! You are {age} years old
print(text.format(user))

String Format https://www.reddit.com/r/godot/comments/v3wo2j/how_to_replace_variables_in_a_string_with_their/
"""

# Called when the node enters the scene tree for the first time.
