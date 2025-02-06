extends Control
class_name GameUI

var player: Player = null # now given by Main via initialize_game_ui function (called by main)

## NOTE: if you'll add a new spell here, don't forget to put it as a child of SpellContainer
#@onready var SpellContainer: Node2D = $SpellContainer (NOW GIVEN BY MAIN)
"""
I had to put the spell container as a child of SubViewport in Main rather than
a child of ingame_ui (formerly spell_cast_handler) since basically the MainViewport (outside subviewport)
and the SubViewport (where main_test_lvl is) have like different dimensions?
basically position = Vector2(1, 1) in MainViewport is NOT the same as
position = Vector2(1, 1) in SubViewport, its like they have their own different 2D spaces, hence
enemies in SubViewport have to be killed by spells in SubViewport.

Spells in MainViewport don't affect enemies in SubViewport (at least from my testing)
"""

@onready var input_line: LineEdit = %IncantationBar ## I have to change this to the dialogue box
@onready var prompt_hint_top1: RichTextLabel = %TopPrompt1 ## show title
@onready var prompt_hint_bot1: RichTextLabel = %BottomPrompt1 ## show incantation (colored)
@onready var prompt_hint_top2: RichTextLabel = %TopPrompt2 ## show title
@onready var prompt_hint_bot2: RichTextLabel = %BottomPrompt2 ## show incantation (colored)
@onready var spellbook: SpellBook_UI = %SpellBook

var spell_info_array: Array[Spell] = [] 
## made class "spell_info" into a public class defined in "spell_info_class.gd"

## these arrays are subsets of (spell_info_array), its purpose is to get the index
## of the desired spell given the title/incantation
var titles_array: Array[String] = []
var incant_array: Array[String] = []

var possible_incants: Array[String] = []
var desired_incant_1: String = "" ## this is updated once possible_incants only has 1 element left
var desired_incant_2: String = ""
var last_valid_input: String = "" ## works alongside desired_incant, used for coloring string

func initialize_game_ui(_player: Player, spell_container: Node2D) -> void:
	
	player = _player
	
	for spell in spell_container.get_children():
		if spell is Spell: ## skip child if its not a spell
			spell_info_array.append(spell)
	
	## prepare array of titles and incantations for easier searching of spells
	for s_info in spell_info_array:
		titles_array.append(s_info.title) ## allow for more leniency with capitalization for Spell Titles
		incant_array.append(s_info.incantation)
	
	spellbook.initialize_spellbook_ui(spell_info_array)
	print_debug(titles_array)
	print_debug(incant_array)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("enter"):
		var current_text: String = PlayerSpeech.spell_typed # POG so current text is what we need to connect to the speech bubble
#		if current_text in titles_array:
#			var i: int = retrieve_array_index(current_text, titles_array)
#			show_incantation_prompt(spell_info_array[i])
		if current_text in incant_array:
			var i: int = retrieve_array_index(current_text, incant_array)
			handle_cast_spell(spell_info_array[i])
		else:
			update_prompts1("Unknown incantation.", "")
			update_prompts2("", "")
	
		input_line.clear() ## clear the searchbar


func handle_cast_spell(chosen_spell: Spell) -> void: ## fire the spell
	chosen_spell.cast_spell(player.aim_target_pos)
	chosen_spell.increase_use_count() # new
	var str: String = ("Casted [%s] with [u]%s[/u], used %d times" 
			% [chosen_spell.title, chosen_spell.incantation, chosen_spell.times_used] 
			)
	update_prompts1(str, "")
	update_prompts2("", "")


func show_incantation_prompt(chosen_spell_1: Spell, chosen_spell_2: Spell = null) -> void:
	var text_format: String = "%s Incantation:"
	update_prompts1(text_format % [chosen_spell_1.title], chosen_spell_1.incantation)
	if chosen_spell_2 != null:
		update_prompts2(text_format % [chosen_spell_2.title], chosen_spell_2.incantation)
	else:
		update_prompts2("", "")
	print_debug("comeon")


func update_prompts1(top_str: String, bot_str: String) -> void:
	prompt_hint_top1.text = top_str
	prompt_hint_bot1.text = bot_str
	prompt_hint_top1.show()
	prompt_hint_bot1.show()

func update_prompts2(top_str: String, bot_str: String) -> void:
	prompt_hint_top2.text = top_str
	prompt_hint_bot2.text = bot_str
	prompt_hint_top2.show()
	prompt_hint_bot2.show()


func retrieve_array_index(element: String, array: Array[String]) -> int:
	for i in range(titles_array.size()):
		if array[i] == element:
			return i
	## should not reach this part of the function
	print("Possible error occured at (retrieve_array_index) function of spell_cast_handler")
	return 0


## this function is called whenever signal (text_changed) is emitted
## the (text_changed) signal is emitted by LineEdit (incantation bar) 
## when the player types/deletes anything sa input_line
func _on_line_edit_text_changed(new_text: String) -> void:
	if new_text == "": ## dont do anything when incantation bar is is empty
		desired_incant_1 = "" ## this resets the incantation
		desired_incant_2 = ""
		last_valid_input = ""
		return
	
	
	## if one incantation left, guide the player to the correct incantation 
	possible_incants.clear()
	for incantation in incant_array:
		if new_text in incantation:
			possible_incants.append(incantation)
	
	if possible_incants.size() == 2:
		last_valid_input = new_text
		desired_incant_1 = possible_incants[0]
		desired_incant_2 = possible_incants[1]
		var index_1: int = retrieve_array_index(desired_incant_1, incant_array)
		var index_2: int = retrieve_array_index(desired_incant_2, incant_array)
		show_incantation_prompt(spell_info_array[index_1], spell_info_array[index_2])
		var colored_input: String = "[color=lightgreen]%s[/color]" % last_valid_input ## color the prompt green
		
		prompt_hint_bot1.text = desired_incant_1.replace(last_valid_input, colored_input)
		prompt_hint_bot2.text = desired_incant_2.replace(last_valid_input, colored_input)
			
	elif possible_incants.size() == 1:
		last_valid_input = new_text
		desired_incant_1 = possible_incants[0]
		var index_1: int = retrieve_array_index(desired_incant_1, incant_array)
		show_incantation_prompt(spell_info_array[index_1])
		var colored_input: String = "[color=lightgreen]%s[/color]" % last_valid_input
		
		prompt_hint_bot1.text = desired_incant_1.replace(last_valid_input, colored_input)
		prompt_hint_bot2.text = ""
		
	elif possible_incants.size() == 0 and desired_incant_1 != "":
		## color the bottom prompt red (regex might be needed for this, 
		## my naive implementation wouldnt work for many possile wrong inputs)
		#print("probably wrong string")
		pass


func _on_node_health_updater(health):
	pass # Replace with function body.
