extends Projectile

export var damage_dealt : int = 2
export var travel_speed : int = 600

func _ready() -> void:
	.set_damage(damage_dealt)
	.set_speed(travel_speed)
	
func _on_Area2D_area_entered(area: Area2D) -> void:
	if(area.is_in_group("Enemies")):
		var area_list = .get_node("Range").get_overlapping_areas()
		.get_node("AnimatedSprite").play("default")
		.get_node("Range/AnimationPlayer").play("Explode")
		area.dealt_damage(.get_damage())
		print(area_list)
		for foundarea in area_list:
			if foundarea.is_in_group("Enemies") && foundarea != area:
				foundarea.dealt_damage(.get_damage())
		yield(.get_node("AnimatedSprite"), "animation_finished")
		.queue_free()
