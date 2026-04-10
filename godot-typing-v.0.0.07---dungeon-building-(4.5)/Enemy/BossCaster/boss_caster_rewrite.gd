extends CharacterBody2D

@onready var rectangleAttacks : Node2D = $EnemySpells/RectangleAttacks

var attack_array : Array = ["shoot", "5", "circles", "5", "rectangle",]

var repeat_cycle : bool = true

#TEMP VARS

@onready var missile = $Sprite2D

@onready var orb = $Sprite2D2

@onready var stun = $EnemySprite/Stun

func _attacks():
	#_shoot()
	await get_tree().create_timer(3).timeout
	#_circles()
	

func _physics_process(delta: float) -> void:
	check_status()
	


func check_status():
	if repeat_cycle == false:
		pass
	else:
		repeat_cycle = false
		rectangleAttacks.whole_attack_sequence()
		print("waiting 6 seconds")
		await get_tree().create_timer(6).timeout
		print("6 sec timer ended")
		var missile_num = 5
		while missile_num != 0:
			print ("shoot missile")
			await get_tree().create_timer(0.2).timeout
			missile.show()
			await get_tree().create_timer(1).timeout
			missile.hide()
			missile_num -= 1
		rectangleAttacks.spaced_attack_sequence()
		await get_tree().create_timer(6).timeout
		missile_num = 5
		while missile_num != 0:
			print ("shoot missile")
			await get_tree().create_timer(0.1).timeout
			missile.show()
			await get_tree().create_timer(0.3).timeout
			missile.hide()
			missile_num -= 1
		await get_tree().create_timer(2).timeout
		
		var orb_num = 3
		while orb_num != 0:
			print ("shoot orb")
			await get_tree().create_timer(0.01).timeout
			orb.show()
			await get_tree().create_timer(0.1).timeout
			orb.hide()
			orb_num -= 1
			
		await get_tree().create_timer(2).timeout
		missile_num = 8
		while missile_num != 0:
			print ("shoot missile")
			await get_tree().create_timer(0.1).timeout
			missile.show()
			await get_tree().create_timer(0.3).timeout
			missile.hide()
			missile_num -= 1
		
		stun.show()
		await get_tree().create_timer(4).timeout
		stun.hide()
		await get_tree().create_timer(0.1).timeout
		stun.show()
		await get_tree().create_timer(0.1).timeout
		stun.hide()
		await get_tree().create_timer(0.1).timeout
		stun.show()
		await get_tree().create_timer(0.1).timeout
		stun.hide()
		await get_tree().create_timer(0.01).timeout
		stun.show()
		await get_tree().create_timer(0.01).timeout
		stun.hide()
		await get_tree().create_timer(0.01).timeout
		stun.show()
		await get_tree().create_timer(0.01).timeout
		stun.hide()
		await get_tree().create_timer(0.01).timeout
		stun.show()
		await get_tree().create_timer(0.01).timeout
		stun.hide()
		await get_tree().create_timer(0.01).timeout
		stun.show()
		await get_tree().create_timer(0.01).timeout
		stun.hide()
		await get_tree().create_timer(0.01).timeout
		stun.show()
		await get_tree().create_timer(0.01).timeout
		stun.hide()
		await get_tree().create_timer(0.1).timeout
		stun.show()
		await get_tree().create_timer(0.1).timeout
		stun.hide()
		await get_tree().create_timer(2).timeout
		repeat_cycle = true
