extends Node2D

const MagicMissileProjectileScene: PackedScene = preload("res://Enemy/Bossfight_level4/boss_missile.tscn")

## NOTE: Taken from magic missile projectile and handler justin made

func _ready() -> void:
	assert(visible, "if the projectile cant be seen, this node is probably set as hidden")


func shoot_missile(target_pos: Vector2) -> void:
	#hitbox.monitorable = true # the bullet has its own hitbox, so this spell no longer needs a "spell_hitbox"
	#timer_lifetime.start() # the bullet has its own lifetime
	shoot_projectile(target_pos)
	#show() # 


func shoot_projectile(_pos: Vector2) -> void:
	var projectile: EnemyProjectile_MagicMissile = MagicMissileProjectileScene.instantiate() ## create a copy of projectile
	var boss_position : Vector2 = get_parent().get_boss_position()
	projectile.global_position = boss_position ## set starting position
	projectile.direction = boss_position.direction_to(_pos) ## set direction of projectile
	print_debug(_pos)
	projectile.top_level = true ## basically to avoid parent node from affecting child node's position
	
	## removed "get_tree().root" here since it has to be spawned in the same subviewport as the enemies
	add_child(projectile) ## add projectile to tree, as a child of root


## the "spell_effect" function is intended to let the spell affect the enemy in different ways,
## but if we just want to damage the enemy, we can have a separate dedicated function for that instead
func spell_effect(enemy: Enemy) -> void:
	pass
	#enemy.health -= damage
