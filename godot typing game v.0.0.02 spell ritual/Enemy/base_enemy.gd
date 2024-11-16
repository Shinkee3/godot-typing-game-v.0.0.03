extends CharacterBody2D
class_name Enemy

#var player_position ## No need since PlayerInfo now exists
var direction: Vector2 ## Preferable to call this direction instead of "target_pos"  ## Kait: Added this
#@onready var player = get_parent().get_parent().get_node("Player") ## Kait: Added this

var p1_distance: float
var p2_distance: float

var target

@export_category("Enemy Stats")
@export var max_health: float = 10
@export var max_speed: float = 10 ## Kait: Added this for speed change
## export variables can be changed thru the inspector

var health: float:
	set(value): ## setter function, this gets called whenever "health" value is changed
		health = value
		health_updated()

var speed: float: ## Kait: Added this
	set(value): 
		speed = value

@onready var healthbar: Label = $Healthbar ## just a slight nitpick, it's preferable to do this since it's slightly faster performance-wise


func _ready() -> void:
	health = max_health ## i moved them here since having "@onready" alone didnt update the new max_health at the start
	speed = max_speed


func _physics_process(delta: float) -> void: ## Kait: Added this for movement
	p1_distance = position.distance_to(PlayerInfo.player_pos)
	p2_distance = position.distance_to(MeleePlayerInfo.melee_player_pos)
	
	if p1_distance < p2_distance:
		direction = (PlayerInfo.player_pos - position).normalized()
		target = p1_distance
		
	elif p1_distance > p2_distance:
		direction = (MeleePlayerInfo.melee_player_pos - position).normalized()
		target = p2_distance
	
	if target > 5:
		velocity = direction * speed
		move_and_slide()


func health_updated() -> void:
	#print("HP = %d/%d" % [health, max_health])
	healthbar.text = str(health)
	if health <= 0:
		queue_free()
