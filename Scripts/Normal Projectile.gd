extends Projectile

export var damage_dealt : int = 2
export var travel_speed : int = 600

func _ready() -> void:
	.set_damage(damage_dealt)
	.set_speed(travel_speed)
	
