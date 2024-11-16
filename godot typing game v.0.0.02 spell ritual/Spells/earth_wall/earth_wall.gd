extends Spell

const EarthWallProjectileScene: PackedScene = preload("res://Projectiles/earth_wall_projectile/earth_wall_projectile.tscn")

var distancefromplayer = 100
var rotation_speed: float = 2

# changing this makes things very interesting. Try rotation 2, lifetime 0.2

var spell_cast: bool = false

@onready var timer_lifetime: Timer = $LifeTime

func _ready() -> void:
	#hitbox.monitorable = false
	hide()

func _physics_process(delta):
	rotate(rotation_speed)
	self.global_position = PlayerInfo.player_pos
	if spell_cast == true:
		var projectile: EarthWall_Projectile = EarthWallProjectileScene.instantiate() ## create a copy of projectile
		projectile.global_position = $Sprite2D.global_position
		projectile.proj_rotation = self.rotation
		#projectile.position.x += distancefromplayer
		
		#projectile.position = self.position ## set starting position
		#projectile.global_position.x += 100 ## set starting position
		get_tree().root.add_child(projectile)
		#print(position)

func cast_spell(target_pos: Vector2) -> void:
	spell_cast = true
	timer_lifetime.start()
	show()
	


func shoot_projectile(target_pos: Vector2) -> void:
	pass 


func _on_life_time_timeout():
	spell_cast = false
