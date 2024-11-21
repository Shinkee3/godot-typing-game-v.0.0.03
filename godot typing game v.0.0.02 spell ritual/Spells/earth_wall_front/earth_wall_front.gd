extends Spell

const EarthWallStaticScene: PackedScene = preload("res://Projectiles/earth_wall_static/earth_wall_static.tscn")

var distancefromplayer = 100
var rotation_speed: float = 2

# changing this makes things very interesting. Try rotation 2, lifetime 0.2

var spell_cast: bool = false
var smoothed_mouse_position: Vector2

@onready var timer_lifetime: Timer = $LifeTime

func _ready() -> void:
	#hitbox.monitorable = false
	hide()

func _physics_process(delta):
	self.global_position = PlayerInfo.player_pos
	
	#the lerp is for smoothening nthe vibe, makes it less jittery
	smoothed_mouse_position = lerp(smoothed_mouse_position, get_global_mouse_position(), 0.3)
	look_at(smoothed_mouse_position)
	if spell_cast == true:
		# ough spaghetti
		var projectile: EarthWall_Static = EarthWallStaticScene.instantiate() ## create a copy of projectile
		projectile.global_position = $Sprite2D.global_position
		var projectile2: EarthWall_Static = EarthWallStaticScene.instantiate()
		projectile2.global_position = $Sprite2D2.global_position
		var projectile3: EarthWall_Static = EarthWallStaticScene.instantiate()
		projectile3.global_position = $Sprite2D3.global_position
		var projectile4: EarthWall_Static = EarthWallStaticScene.instantiate()
		projectile4.global_position = $Sprite2D4.global_position
		var projectile5: EarthWall_Static = EarthWallStaticScene.instantiate()
		projectile5.global_position = $Sprite2D5.global_position
		
		#projectile.position.x += distancefromplayer
		
		#projectile.position = self.position ## set starting position
		#projectile.global_position.x += 100 ## set starting position
		get_tree().root.add_child(projectile)
		get_tree().root.add_child(projectile2)
		get_tree().root.add_child(projectile3)
		get_tree().root.add_child(projectile4)
		get_tree().root.add_child(projectile5)

func cast_spell(target_pos: Vector2) -> void:
	spell_cast = true
	timer_lifetime.start()
	show()
	


func shoot_projectile(target_pos: Vector2) -> void:
	pass 


func _on_life_time_timeout():
	spell_cast = false
