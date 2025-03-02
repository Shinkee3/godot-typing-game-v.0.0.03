extends Control

@onready var speechText = $TextBox/PanelContainer/MarginContainer/SpeechText # this is just the node
@onready var speechBubble = $TextBox

@onready var gestureDisp = $MarginContainer/Gesture
@onready var gestureBox = $MarginContainer
@onready var gestureIndicator = $GestureIndicator

var is_gesturing: bool = false #this is to have a gesturing bool. This will bemultiplied by -1. if gesturing is true, no text will be shown.
var gesture_string = ""

var spell_typed: String

func _unhandled_key_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed():
		if event.is_action_pressed("capslock"): # gesturing check, imperfect since this will depend on the capslock's starting position
			spell_casting_setter()
		if is_gesturing == false:
			if event.is_action_pressed("ui_cancel") or event.is_action_pressed("enter"): #clear speech bubble
				speechText.text = "" # its working now so thats weird
			elif event.is_action_pressed("ui_text_backspace"):# delete the last letter
				speechText.text = speechText.text.left(-1)
			elif event.is_action_pressed("shiftspace"): # enter the spell # I like this better
				print("shift and space") # connect this to the spellcasting once you've figured it out
			else: # for spaces and characters. Since this is more common it should be at the top ideally after the caps check. 
				event.set_echo(false) # this does not work
				var typed_event = event as InputEventKey #bro idk why this needs event as input event key but idk man
				var key_typed = (PackedByteArray([typed_event.unicode])).get_string_from_utf8() # so this has an error. looking into removing the echo
				speechText.text += key_typed
				if speechBubble.visible && speechText.text.length() == 0:
					speechBubble.hide()
				elif speechBubble.visible == false && speechText.text.length() > 0:
					speechBubble.show()
					PlayerSpeech.spell_text = speechText.text
					print(speechText.text)
					#spell_casting(event)

		else:
			spell_gesturing(event)
			

func spell_casting_setter():
	is_gesturing = not is_gesturing #trial, a state machine would be muhc better
	if is_gesturing == false && gestureIndicator.visible == true:
		gestureBox.hide()
		print(is_gesturing)
	if is_gesturing == true && gestureIndicator.visible == false:
		gestureBox.hide()
	return

"""func spell_casting(event):
	if event.is_action_pressed("ui_cancel") or event.is_action_pressed("enter"): #clear speech bubble
		speechText.text = "" # its working now so thats weird
	elif event.is_action_pressed("ui_text_backspace"):# delete the last letter
		speechText.text = speechText.text.left(-1)
	elif event.is_action_pressed("shiftspace"): # enter the spell # I like this better
		print("shift and space") # connect this to the spellcasting once you've figured it out
	else: # for spaces and characters. Since this is more common it should be at the top ideally after the caps check. 
		event.set_echo(false) # this does not work
		var typed_event = event as InputEventKey #bro idk why this needs event as input event key but idk man
		var key_typed = (PackedByteArray([typed_event.unicode])).get_string_from_utf8() # so this has an error. looking into removing the echo
		speechText.text += key_typed
		if speechBubble.visible && speechText.text.length() == 0:
			speechBubble.hide()
		elif speechBubble.visible == false && speechText.text.length() > 0:
			speechBubble.show()
			PlayerSpeech.spell_text = speechText.text
			print(speechText.text)"""

func spell_gesturing(event):
	gestureBox.show()
	gestureIndicator.show()
	print("visible gesture")
	var typed_event = event as InputEventKey #bro idk why this needs event as input event key but idk man
	var key_typed = (PackedByteArray([typed_event.unicode])).get_string_from_utf8() # so this has an error. looking into removing the echo
	# this is a very  rudimentary way to look for matching prompts. This will do for now
	# WAZXD + S
	if key_typed == "S": # just to have a way to remove strings
		# suggestion: remove the gesture component. This woul dmake the game extremely complicated. You can save this for hte future, but not for this game
		# instead, make one letter = one attack. Or two letters being nothing but one attack. There are only a set amount of spells you can use for this
		gestureDisp.text = "🙏"
		clear_gesture()
	elif key_typed == "A":
		gestureDisp.text = "👈"
		add_gesture(key_typed)
	elif key_typed == "W":
		gestureDisp.text = "🤞"
		add_gesture(key_typed)
	elif key_typed == "D":
		gestureDisp.text = "👉"
		add_gesture(key_typed)
	elif key_typed == "X":
		gestureDisp.text = "🤘"
		add_gesture(key_typed)
	elif key_typed == "Z":
		gestureDisp.text = "🖐️"
		add_gesture(key_typed)
	# Gesture spells + max length
	if gesture_string.length() > 3:
		clear_gesture()
	elif gesture_string == "WD":
		print("wd gesture")
		clear_gesture()
	return

func clear_gesture():
	gesture_string = ""

func add_gesture(gesture): # add gestures to the end of the string, for ease purposes (ideally it would be a dict but ths=is should do for now
	gesture_string += gesture
	print(gesture_string)

# now the hard part would be connecting the prompts to this one.
