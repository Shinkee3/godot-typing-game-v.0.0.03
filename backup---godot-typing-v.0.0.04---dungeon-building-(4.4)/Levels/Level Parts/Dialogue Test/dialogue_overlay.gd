extends Control

@onready var dialoguebox = $TextBox/PanelContainer/MarginContainer/SpeechText

@onready var mentorSprite = $MentorSprite
@onready var mcSprite = $MCSprite
@onready var dietritusSprite = $BossCasterSprite


var dialoguepagecounter: int = 0


#This should sort of work for now. All the dialogues are listed in this dictionary with the name. The dialogues are accessed at any location through the PlayerInfo.current_dialogue property. If there is no active dialogue, it returns null and nothing happens


var dialoguelist: Dictionary = {

"firstspawnin": ["Mentor: ...", "Mentor: *cough*", "Mentor: S-so we f-find ourselves back in the du-dungeon.", "Mentor: ...never th-thought it'd be so soon.", "Mentor: T-to think th-that you've...", "You: ...", "Mentor: y-you've grown up s-so much since I f-first t-taught y-you.", "You: ...", "Mentor: *cough* *hack*", "You: ...", "You: Uncle... It's time to go.", "Mentor: *!!!*", "Mentor: O-oh, o-o-of course...", "Mentor: L-lets get to it..."],
"wallslevel": ["Mentor: Ah... It's b-been so long since I-I've s-seen this...", "Mentor: Th-the magic walls are st-still up.", "Mentor: Th... there should be a disp-spelling i-incantation y-you can f-find if you f-focus on the walls.", "Mentor: Ch-chant it and f-focus your en-energy. I-it shouldn't be too h-hard."],
"firstdispellsuccessful": ["Mentor: Hehehe", "Mentor: Y-you've always had a knack f-for dispelling. A-as if the w-words c-come so clearly.", "You: It does always come very clearly to me.", "Mentor: I d-don't know where y-you g-got it from. Definitely n-not from me. Heh.", "Mentor: We are in good h-hands.", "Mentor: Now remember the spellbook I gave you?", "You: Yes, I have it open now.", "Mentor: G-good. Go u-use it on the m-monsters here.", "Mentor: I-it sh-should be easy here still."],
"firstlevellockeddoor": ["Mentor: Ahh, now this i-is d-different", "Mentor: I-I forgot th-these ex-existed. (To deter r-random intruders...)", "Mentor: L-let's look a-at a key-holder.", "Mentor: It sh-should be a-an item with m-magic around this floor.", "Mentor: Dispell that a-and, heh, we a-are g-good to go."],
"firstlevelnearjar": ["Mentor: Th-there! At the c-corner!"],
"pre-bossgate": ["Mentor: ...", "Mentor: There is something I have not told you.", "You: Hmmm?", "Mentor: Detritus... He can cast magic. L-like you and I.", "Mentor: H-he was th-the one that c-cursed m-me,", "Mentor: Th-thirty years ago.", "You: Magic, he's an Amanuensis?", "Mentor: Y...yess. L-like you... and like I... was...", "Mentor: I c-could n-not p-prep-repa-prep---", "You: It's ok uncle. Slow down.", "Mentor: I c-could n-not prepare you against m-magic...", "Mentor: I-it's...", "Mentor: I-its like the w-walls.", "a-and the b-bats.", "Mentor: Y-you d-dispell them.", "Mentor: S-sometimes y-you get ch-charmed.", "Mentor: M-most of the t-time. Y-you j-just h-have t-t-to wait it-it out.", "You: (He is talking really fast.)", "You: It's ok uncle.", "You: We'll figure it out.", "Mentor: ..."],
"bossstagearrival": ["You: (The miasma here is very thick, it clings every movement you do.)", "You: (There really is a caster here.)", "Mentor: T-this is as f-far as I can guide you.", "Mentor: As long as he i-is alive.", "???: Mmmmmm.", "You: (...)", "Mentor: You must not fear. H-here.", "Item: [red gem necklace]", "Mentor: I-if you g-get hurt. Y-you will c-come back here.", "Mentor: T-this... is the most I could do.","(You don the neclace)"],
"bossbattlepre": ["Detritus: Trying to be sneaky, Amanuensis?", "You: Kh-!", "You: How did you kn--", "Detritus: I can taste it from here.", "Detritus: Miasma. Yours and an old friend's", "Mentor: ...", "Detritus: Two Amanuensis. With just one able to cast.", "Detritus: Oh how have the town fallen.", "Detritus: I will sure you die, Amanuensis. I WILL SURE YOU DIE!"],
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
		_check_portraits()
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

func _check_portraits():
	if PlayerInfo.currentdialogue in ["bossbattlepre"]:
		mentorSprite.hide()
		dietritusSprite.show()
