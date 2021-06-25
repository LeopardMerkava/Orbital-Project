extends Projectile

export var damage_dealt : int = 30
export var travel_speed : int = 300

func _ready() -> void:
	.set_damage(damage_dealt)
	.set_speed(travel_speed)
	
func _on_Area2D_area_entered(area: Area2D) -> void:
	if(area.is_in_group("Enemies")):
		var area_list = .get_node("Range").get_overlapping_areas()
		.get_node("AnimatedSprite").play("default")
		.get_node("Range/WHITE_CIRCLE").modulate = Color(1.0, 0.0, 0.0, 0.6)
		for foundarea in area_list:
			if foundarea.is_in_group("Enemies"):
				foundarea.get_parent().dealt_damage(.get_damage())
		yield(.get_node("AnimatedSprite"), "animation_finished")
		.queue_free()
