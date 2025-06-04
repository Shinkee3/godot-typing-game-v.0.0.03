extends Control

@onready var dialoguebox = $TextBox/PanelContainer/MarginContainer/SpeechText

var dialoguepagecounter: int = 0

#This should sort of work for now. All the dialogues are listed in this dictionary with the name. The dialogues are accessed at any location through the PlayerInfo.current_dialogue property. If there is no active dialogue, it returns null and nothing happens
var dialoguelist: Dictionary = {

"firstspawnin": ["Mentor: ...", "Mentor: *cough*", "Mentor: S-so we f-find ourselves back in the du-dungeon.", "Mentor: ...never th-thought it'd be so soon.", "Mentor: T-to think th-that you've...", "You: ...", "Mentor: y-you've grown up s-so much since I f-first t-taught y-you.", "You: ...", "Mentor: *cough* *hack*", "You: ...", "You: Uncle... It's time to go.", "Mentor: *!!!*", "Mentor: O-oh, o-o-of course...", "Mentor: L-lets get to it..."],
"wallslevel": ["Mentor: Ah... It's b-been so long since I-I've s-seen this...", "Mentor: Th-the magic walls are st-still up.", "Mentor: Th... there should be a disp-spelling i-incantation y-you can f-find if you f-focus on the walls.", "Mentor: Ch-chant it and f-focus your en-energy. I-it shouldn't be too h-hard."],
"firstdispellsuccessful": ["Mentor: Hehehe", "Mentor: Y-you've always had a knack f-for dispelling. A-as if the w-words c-come so clearly.", "You: It does always come very clearly to me.", "Mentor: I d-don't know where y-you g-got it from. Definitely n-not from me. Heh.", "Mentor: We are in good h-hands.", "Mentor: Now remember the spellbook I gave you?", "You: Yes, I have it open now.", "Mentor: G-good. Go u-use it on the m-monsters here.", "Mentor: I-it sh-should be easy here still."],
}

var currentdialogueglobal : String
var currentdialogue: Array


func _ready() -> void:
	if PlayerInfo.currentdialogue != null:
		currentdialogue = dialoguelist[PlayerInfo.currentdialogue]	#this seems complicated but this jsut basically gets the array from the dictionary 
		dialoguebox.text = currentdialogue[dialoguepagecounter]


func _unhandled_key_input(event: InputEvent) -> void: #ideally maybe there;s like, one centralized key input studier?
	if  PlayerInfo.currentdialogue != null && self.visible == false:
		currentdialogue = dialoguelist[PlayerInfo.currentdialogue]	#this seems complicated but this jsut basically gets the array from the dictionary 
		dialoguebox.text = currentdialogue[dialoguepagecounter]
		self.show()
	elif event.is_action_pressed("enter") == true &&  PlayerInfo.currentdialogue != null:
		if PlayerInfo.indialogue == false:
			PlayerInfo.indialogue = true
		if dialoguepagecounter != currentdialogue.size() - 1:
			dialoguepagecounter += 1
			dialoguebox.text = currentdialogue[dialoguepagecounter]
		elif PlayerInfo.currentdialogue != null:
			print("end of the line")
			self.hide()
			dialoguepagecounter = 0
			PlayerInfo.currentdialogue = null
			PlayerInfo.indialogue = false
			print(PlayerInfo.currentdialogue)
