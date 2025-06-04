extends Control

@onready var dialoguebox = $TextBox/PanelContainer/MarginContainer/SpeechText

var dialoguepagecounter: int = 0

#This should sort of work for now. All the dialogues are listed in this dictionary with the name. The dialogues are accessed at any location through the PlayerInfo.current_dialogue property. If there is no active dialogue, it returns null and nothing happens
var dialoguelist: Dictionary = {

"firstspawnin": ["Mentor: ...", "Mentor: *cough*", "Mentor: S-so we f-find ourselves back in the du-dungeon.", "Mentor: ...never th-thought it'd be so soon.", "Mentor: T-to think th-that you've...", "You: ...", "Mentor: y-you've grown up s-so much since I f-first t-taught y-you.", "You: ...", "Mentor: *cough* *hack*", "You: ...", "You: Uncle... It's time to go.", "Mentor: !!!", "Mentor: O-oh, o-o-of course...", "Mentor: L-lets get to it..."]

}

var currentdialogueglobal : String
var currentdialogue: Array


func _ready() -> void:
	currentdialogue = dialoguelist[PlayerInfo.currentdialogue]	#this seems complicated but this jsut basically gets the array from the dictionary 
	dialoguebox.text = currentdialogue[dialoguepagecounter]


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("enter") == true && PlayerInfo.currentdialogue != null:
		if PlayerInfo.indialogue == false:
			PlayerInfo.indialogue = true
		if dialoguepagecounter != currentdialogue.size() - 1:
			dialoguepagecounter += 1
			dialoguebox.text = currentdialogue[dialoguepagecounter]
		elif PlayerInfo.currentdialogue != null:
			print("end of the line")
			self.hide()
			PlayerInfo.currentdialogue = null
			PlayerInfo.indialogue = false
			print(PlayerInfo.currentdialogue)
