extends Node2D

@onready var rect1 : Node2D = $RectangleAttack
@onready var rect2 : Node2D = $RectangleAttack2
@onready var rect3 : Node2D = $RectangleAttack3
@onready var rect4 : Node2D = $RectangleAttack4
@onready var rect5 : Node2D = $RectangleAttack5

@onready var rectsArray : Array = [rect1, rect2, rect3, rect4, rect5]

@onready var FloorWipeWhole : Array = []
@onready var FloorWipeSpace : Array = []

var attack_array : Array = ["shoot", "5", "circles", "5", "rectangle"]

func _attacks():
	_shoot()
	await get_tree().create_timer(3).timeout
	_circles()
	
func _shoot():
	pass

func _circles():
	pass

func _rectangles():
	pass

func spawnRects():
	pass


func getSpacedAttacksPos():
	FloorWipeSpace = []
	for marker in $Markers/FloorWipeSpace.get_children(): # get_children needs to be added as there isnt really anything to find if you just go for marker in node
		FloorWipeSpace.append(marker.position)

func getWholeAttackPos():
	FloorWipeWhole = []
	for marker in $Markers/FloorWipeWhole.get_children(): # get_children needs to be added as there isnt really anything to find if you just go for marker in node
		FloorWipeWhole.append(marker.position)

func spawnRectsSpaced(): #good... goood... it works.... muahahahaha
	print(FloorWipeSpace)
	#for position in FloorWipeSpace:
	print(FloorWipeWhole)
	
	var indexcount = 0
	for pos in FloorWipeSpace: # this one makes the rectangles spawn in gradually
		print(indexcount)
		rectsArray[indexcount].position = FloorWipeSpace[indexcount]
		
		rectsArray[indexcount]._spawn_at_position_and_start()
		
		indexcount += 1
		
		await get_tree().create_timer(0.4).timeout

func spawnRectsWhole(): #good... goood... it works.... muahahahaha
	print(FloorWipeWhole)
	
	var indexcount = 0
	for pos in FloorWipeWhole: # this one makes the rectangles spawn in gradually
		print(indexcount)
		rectsArray[indexcount].position = FloorWipeWhole[indexcount]
		
		rectsArray[indexcount]._spawn_at_position_and_start()
		
		indexcount += 1
		
		await get_tree().create_timer(0.4).timeout
	#rectsArray[0].position = FloorWipeWhole[0]
	#rect2.position = FloorWipeWhole[1]
	#rect3.position = FloorWipeWhole[2]
	#rect4.position = FloorWipeWhole[3]
	#rect5.position = FloorWipeWhole[4]

func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("enter"):
		look_at(PlayerInfo.player_pos)
		print("enter pressed")
		getSpacedAttacksPos()
		spawnRectsSpaced()
	if event.is_action_pressed("controlkey"):
		look_at(PlayerInfo.player_pos)
		print("controlkey pressed")
		getWholeAttackPos()
		spawnRectsWhole()
