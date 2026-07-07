extends CharacterBody2D

@export var blue = Color("#4682b4") 
@export var green = Color("#639765")
@export var red = Color("#a65455")

@export var dispelling_prompt: String = "scaarium aarua" # the nature of the code makes it so that only unicode english gets typed. A chinese ver has to be built from the ground up.

@onready var prompt = $DispellCode
@onready var prompt_text = dispelling_prompt

const speed = 100

@export var timer_length = 2

@export var player: Node2D

@onready var navigation_agent = $NavigationAgent2D

var on_target = false

func _ready() -> void:
	print(prompt_text)
	prompt.text = prompt_text

	$Timer.wait_time = timer_length
	

func _physics_process(delta: float) -> void:
	if on_target == false:
		var dir = to_local(navigation_agent.get_next_path_position()).normalized()
		velocity = dir * speed
		
		move_and_slide()
	
func make_path() -> void:
	navigation_agent.target_position = player.global_position

func _on_timer_timeout() -> void:
	make_path()


func _on_area_2d_area_entered(area: Area2D) -> void:
	on_target = true
	print("target detected")


func _on_area_2d_area_exited(area: Area2D) -> void:
	on_target = false
	print("target left")
	
	
# BELOW IS DISPELLING 
func get_prompt() -> String:
	return prompt_text

	
func set_next_character(next_character_index: int):
	#really long strings, not optimized. but if your game is very small, non-optimized doesnt matter
	var blue_text = get_bbcode_color_tag(blue) + prompt_text.substr(0, next_character_index) + get_bbcode_end_color_tag() #this one makes the starting letter to the current letter blue! (inxex zero with the length of 1 that increses per character typed) blue is for typed 
	var green_text = get_bbcode_color_tag(green) + prompt_text.substr(next_character_index, 1) + get_bbcode_end_color_tag() #because there will always be a next character, if all the characters are typed, it disappears. So the next character and the one next to that
	var red_text = ""
	#tut said they would use a terniary system but godot's one is weird
	if next_character_index != prompt_text.length(): # so this is because if its hte last letter, the last letter wouldn't be red (huh?) OH red text is untyped letters, not wrong ones
		red_text = get_bbcode_color_tag(red) + prompt_text.substr(next_character_index + 1, prompt_text.length() - next_character_index + 1) + get_bbcode_end_color_tag() # this gets it from the letter next to the current letter, to the number of characters left
	
	prompt.parse_bbcode("[center]" + blue_text + green_text + red_text + "[/center]") #ohh so bbcode is [], center is here so the text keeps centered

# time to plug the functions!
func get_bbcode_color_tag(color: Color) -> String: #helper function
	return "[color=#" + color.to_html(false) + "]" #the false here removes the alpha aka the opacity
	
func get_bbcode_end_color_tag() -> String: #not necessary but the tutorial said theyre just gonna do it so ok
	return "[/color]" #tut said its nice to have, I see now why
