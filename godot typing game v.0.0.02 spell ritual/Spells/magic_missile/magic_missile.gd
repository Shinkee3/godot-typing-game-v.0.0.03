extends Spell

const MagicMissileProjectileScene: PackedScene = preload("res://Projectiles/magic_missile_projectile/magic_missile_projectile.tscn")

#@onready var timer_lifetime: Timer = $lifetime
#@onready var sprite: Sprite2D = $Sprite2D # no need, the visual is now on the projectile scene
#@onready var hitbox: SpellHitbox = $Spell_hitbox
#@onready var player = get_parent().get_parent().get_parent().get_parent().get_node("Player") ## Kait: Added this

## NOTE: i moved some variables here to magic_missile_projectile

## Concern:
"""
2) How do you make magic missile spawn a new instance per spell instead of just controlling one? 
Its a bit awkward right now. since there can only be one projectile on the screen and everytime 
its cast again the spell just resets
"""

## Suggestion
"""
Treat the spell not as the projectile itself, but as the gun that fires the projectile
It needs bullets (the projectiles), we need to create a projectile node which is created by the magic missile spell.
"""

func _ready() -> void:
	#hitbox.monitorable = false
	assert(visible, "if the projectile cant be seen, this node is probably set as hidden")


func cast_spell(target_pos: Vector2) -> void:
	#hitbox.monitorable = true # the bullet has its own hitbox, so this spell no longer needs a "spell_hitbox"
	#timer_lifetime.start() # the bullet has its own lifetime
	shoot_projectile(target_pos)
	#show() # 


func shoot_projectile(_pos: Vector2, ) -> void:
	var projectile: MagicMissile_Projectile = MagicMissileProjectileScene.instantiate() ## create a copy of projectile
	projectile.global_position = PlayerInfo.player_pos ## set starting position
	projectile.direction = PlayerInfo.player_pos.direction_to(_pos) ## set direction of projectile
	projectile.top_level = true ## basically to avoid parent node from affecting child node's position
	
	## removed "get_tree().root" here since it has to be spawned in the same subviewport as the enemies
	add_child(projectile) ## add projectile to tree, as a child of root


## the "spell_effect" function is intended to let the spell affect the enemy in different ways,
## but if we just want to damage the enemy, we can have a separate dedicated function for that instead
func spell_effect(enemy: Enemy) -> void:
	pass
	#enemy.health -= damage
