extends Control

@export var player: Player ## set this up at scene (test_level) in the inspector

## NOTE: if you'll add a new spell here, don't forget to put it as a child of SpellContainer
@onready var SpellContainer: Node2D = $SpellContainer

@onready var input_line: LineEdit = $PanelContainer/VBoxContainer/LineEdit ## 
@onready var prompt_hint_top: RichTextLabel = $PanelContainer/VBoxContainer/RichText1 ## show title
@onready var prompt_hint_bot: RichTextLabel = $PanelContainer/VBoxContainer/RichText2 ## show incantation (colored)
@onready var display_list: VBoxContainer = $PanelContainer2/ScrollContainer/VBoxContainer

class spell_info:
	var title: String
	var incant: String
	var SpellNode: Spell

var spell_info_array: Array[spell_info] = []

## these arrays are subsets of (spell_info_array), its purpose is to get the index
## of the desired spell given the title/incantation
var titles_array: Array[String] = []
var incant_array: Array[String] = []

var possible_incants: Array[String] = []
var desired_incant: String = "" ## this is updated once possible_incants only has 1 element left
var last_valid_input: String = "" ## works alongside desired_incant, used for coloring string

func _ready() -> void:
	assert(player, 
		"missing export reference to player, check the inspector 
		(and make sure the player AND the spell_cast_handler exist in the level scene)")
	for s in SpellContainer.get_children():
		if not (s is Spell): ## skip child if its not a spell
			continue
		var new_spell_info: spell_info = spell_info.new()
		new_spell_info.title = s.title
		new_spell_info.incant = s.incantation
		new_spell_info.SpellNode = s
		spell_info_array.append(new_spell_info)
		
		
		## update UI to display the spell titles
		var new_label: Label = Label.new()
		new_label.text = s.title
		display_list.add_child(new_label)
	
	## prepare array of titles and incantations for easier searching of spells
	for s_info in spell_info_array:
		titles_array.append(s_info.title) ## allow for more leniency with capitalization for Spell Titles
		incant_array.append(s_info.incant)
	
	print(titles_array)
	print(incant_array)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter"):
		var current_text: String = input_line.text
		if current_text in titles_array:
			var i: int = retrieve_array_index(current_text, titles_array)
			show_incantation_prompt(spell_info_array[i])
		elif current_text in incant_array:
			var i: int = retrieve_array_index(current_text, incant_array)
			handle_cast_spell(spell_info_array[i])
		else:
			update_prompts("Unknown spell/incantation.", "")
	
		input_line.clear() ## clear the searchbar


func handle_cast_spell(chosen_spell: spell_info) -> void: ## fire the spell
	var spell: Spell = chosen_spell.SpellNode
	var str: String = "Casted [%s] with [u]%s[/u]" % [chosen_spell.title, chosen_spell.incant] 
	update_prompts(str, "")
	spell.cast_spell(player.aim_target_pos)


func show_incantation_prompt(chosen_spell: spell_info) -> void:
	var text_format: String = "%s Incantation:"
	update_prompts(text_format % [chosen_spell.title], chosen_spell.incant)


func update_prompts(top_str: String, bot_str: String) -> void:
	prompt_hint_top.text = top_str
	prompt_hint_bot.text = bot_str
	prompt_hint_top.show()
	prompt_hint_bot.show()


func retrieve_array_index(element: String, array: Array[String]) -> int:
	for i in range(titles_array.size()):
		if array[i] == element:
			return i
	## should not reach this part of the function
	print("Possible error occured at (retrieve_array_index) function of spell_cast_handler")
	return 0


## this function is called whenever signal (text_changed) is emitted
## the (text_changed) signal is emitted by LineEdit when the player types/deletes anything sa input_line
func _on_line_edit_text_changed(new_text: String) -> void:
	## update spell_display_list
	if new_text == "": ## dont do anything when searchbar is empty
		for label in display_list.get_children():
			label.show()
		desired_incant = "" ## this resets the incantation
		last_valid_input = ""
		return
	
	for label in display_list.get_children():
		if new_text in label.text:
			label.show()
		else:
			label.hide()
	
	## if one incantation left, guide the player to the correct incantation 
	possible_incants.clear()
	for incant in incant_array:
		if new_text in incant:
			possible_incants.append(incant)
	
	if possible_incants.size() == 1:
		desired_incant = possible_incants[0] ## make the only possible_incant show up
		last_valid_input = new_text
		var i: int = retrieve_array_index(desired_incant, incant_array)
		show_incantation_prompt(spell_info_array[i])
		var colored_input: String = "[color=lightgreen]%s[/color]" % last_valid_input ## color the prompt green
		var final_text: String = desired_incant.replace(last_valid_input, colored_input)
		prompt_hint_bot.text = final_text
	elif possible_incants.size() == 0 and desired_incant != "":
		## color the bottom prompt red (regex might be needed for this, 
		## my naive implementation wouldnt work for many possile wrong inputs)
		print("probably wrong string")
