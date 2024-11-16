extends VBoxContainer
class_name SpellBook_UI

## displays the list of spell pages

@export var SpellPagePackedScene: PackedScene
@export var filter_button: PackedScene

var filter_dict: Dictionary = {} ## to keep track of what spell filters (spell tags) are on

@onready var display_list: VBoxContainer = %DisplayList
@onready var filter_container: GridContainer = $Filters
@onready var searchbar: LineEdit = $Searchbar

func initialize_spellbook_ui(spell_info_array: Array[Spell]) -> void:
	for spell_info in spell_info_array:
		var new_spellpage: SpellPage_UI = SpellPagePackedScene.instantiate()
		display_list.add_child(new_spellpage)
		new_spellpage.initialize_spellpage(spell_info)
	
	## create filter buttons
	for tag in Spell.Tags:
		var new_filter: Button = filter_button.instantiate()
		new_filter.text = String(tag)
		new_filter.custom_minimum_size = Vector2(75,0)
		filter_dict[tag] = false
		filter_container.add_child(new_filter)
		new_filter.toggled.connect(enable_filter.bind(new_filter.text))
	
	#print_debug(filter_dict)

func _on_searchbar_text_changed(new_text: String):
	update_displayed_spellpages(new_text)


## default variables put into argument
## basically this lets other functions call this argument without passing the default argument
func update_displayed_spellpages(new_text: String = searchbar.text) -> void:
	var filters_enabled: bool = false
	for tag in filter_dict:
		if filter_dict[tag] == true:
			filters_enabled = true
	
	if new_text == "": ## dont do anything when spell searchbar is empty
		for spellpage in display_list.get_children():
			var key: String = Spell.Tags.keys()[spellpage.spell_tag]
			
			if not filters_enabled: # show everything when no filter is on
				spellpage.show()
			else:
				if filter_dict[key] == true: # show only filtered spells
					spellpage.show()
				else:
					spellpage.hide()
		return
	
	## if spell searchbar is NOT empty:
	for spellpage in display_list.get_children():
		if spellpage is SpellPage_UI:
			var key: String = Spell.Tags.keys()[spellpage.spell_tag]
			
			if (new_text.to_lower() in spellpage.spell_title.to_lower() and
				(not filters_enabled or filter_dict[key] == true)
				):
				spellpage.show()
			else:
				spellpage.hide()


func enable_filter(pressed: bool, tag: String) -> void:
	if filter_dict.has(tag):
		filter_dict[tag] = pressed
	update_displayed_spellpages()
