extends Enemy
class_name Enemy_Caster

func _on_ready():
	$Healthbar.max_value = self.max_health
	print($Healthbar.max_value)
	print(max_health)
	#does not work. arhghh
	
