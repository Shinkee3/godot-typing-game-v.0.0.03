extends Node2D

@onready var tp_markers = $PosMarkers
@onready var body = $Boss_Rewrite
@onready var attackhandler = $AttackHandler
@onready var castinghandler = $CastingHandler
@onready var arenamarkers = $ArenaMarkers
var tempcounter: int = 0

var arenamarkers_count: int
var arenamarkers_children
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	arenamarkers_count = arenamarkers.get_child_count()
	arenamarkers_children = arenamarkers.get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shiftspace"):
		if tempcounter == 0:
			await castinghandler.casting_spell("Teleport and Shoot") #omg it fucking worksss!!!
			teleport_sequence()
		elif tempcounter == 1:
			await castinghandler.casting_spell("Teleport and Shoot", 3, 5) #omg it fucking worksss!!!
			teleport_sequence()
		elif tempcounter == 2:
			wait(2)
			await castinghandler.casting_spell("Area of Effect")
			random_teleport()
			print("randomly teleported")
			area_of_effect()
		
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
		attackhandler.shoot_projectile(target)
		await get_tree().create_timer(1.0).timeout
	body.global_position = old_position

func random_teleport():
	var randmarker = randi_range(0, arenamarkers_count)
	var target_pos = arenamarkers.get_child(randmarker).position
	body.global_position = target_pos

func get_boss_position():
	return body.global_position

func wait(time: float):
	await get_tree().create_timer(time).timeout
	
func area_of_effect(amount: int = 0):
	for i in arenamarkers_children:
		pass

# I think I"m satisfied for that right now. We can add the area next time. We have finally gotten our big milestone down!
#yippie kay yay!!
	
		
