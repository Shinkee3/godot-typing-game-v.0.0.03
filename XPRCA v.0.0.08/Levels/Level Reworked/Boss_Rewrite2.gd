extends Node2D

@onready var tp_markers = $PosMarkers
@onready var body = $Boss_Rewrite
@onready var attackhandler = $AttackHandler
@onready var castinghandler = $CastingHandler
@onready var arenamarkers = $ArenaMarkers
@onready var arenaareas = $ArenaAreas
var tempcounter: int = 2

var arenamarkers_count: int
var arenamarkers_children
var current_body_markerpos_index: int


var arenaareas_children

var Level_start_position: Vector2

var summon_circle_position: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	arenamarkers_count = arenamarkers.get_child_count()
	arenamarkers_children = arenamarkers.get_children()
	arenaareas_children = arenaareas.get_children()
	Level_start_position = body.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shiftspace"):
		if tempcounter == 0:
			await castinghandler.casting_spell("Teleport and Shoot") #omg it fucking worksss!!!
			teleport_sequence()
		elif tempcounter == 1:
			await castinghandler.casting_spell("Teleport and Shoot", 3, 5) #omg it fucking worksss!!!
			teleport_sequence()
		elif tempcounter >= 2:
			wait(2)
			await castinghandler.casting_spell("Area of Effect", 0,5)
			await random_teleport()
			await area_of_effect(tempcounter - 1)
			#reset_areas_postion(3)
			#print("resetting areas")

		tempcounter += 1
func cast_spell(spell: String):
	pass

func teleport_sequence():
	
	var old_position: Vector2 = get_boss_position()
	var target: Vector2 = PlayerInfo.player_pos
	tp_markers.global_position = target
	var array1
	for pos in  tp_markers.get_children():
		body.global_position = pos.global_position
		target = PlayerInfo.player_pos
		attackhandler.shoot_projectile(target)
		await get_tree().create_timer(1.0).timeout
	body.global_position = old_position

func random_teleport():
	var randmarker = randi_range(0, arenamarkers_count - 1)
	current_body_markerpos_index = randmarker
	var target_pos = arenamarkers.get_child(randmarker).position
	body.global_position = target_pos

func get_boss_position():
	return body.global_position

func wait(time: float):
	await get_tree().create_timer(time).timeout
	
func area_of_effect(amount: int):
	
	#CHECK FOR ERRORS
	if amount < 1:
		print("Amount of area of effect is less than 1")
		return
	elif amount > arenamarkers_count - 1:
		print("Amount of areas requested exceeds markers available")
		print("Areas requested " + str(amount))
		print("Positions available " + str(arenamarkers_count - 1))
		return
	else:
		var available_markers = arenamarkers.get_children()
		print("Available Markers: " + str(available_markers.size()))
		available_markers.erase(arenamarkers.get_child(current_body_markerpos_index))
		for c in range(0, amount):
			var max_range = available_markers.size() -1
			var marker_index = randi_range(0, max_range)
			var marker_position = available_markers[marker_index].global_position
			arenaareas_children[c].global_position = marker_position
			available_markers.remove_at(marker_index)
			
		print("Available Markers: " + str(available_markers.size()))
		available_markers = arenamarkers_children
		"""await get_tree().create_timer(0.5)
		body.global_position = Level_start_position
		for i in arenaareas_children:
			i.position = Vector2(0,0)"""
	
func reset_boss_position():
	pass

func reset_areas_postion(time: float):
	print("resetting area positions in " + str(time) + " ticks")
	await get_tree().create_timer(time)
	for i in arenaareas_children:
		if i.position != Vector2(0,0):
			i.position = Vector2(0,0)
# I think I"m satisfied for that right now. We can add the area next time. We have finally gotten our big milestone down!
#yippie kay yay!!
	
		
