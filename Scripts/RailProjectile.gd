extends Projectile

export var damage_dealt : int = 6
export var travel_speed : int = 1500

func _ready() -> void:
	.set_damage(damage_dealt)
	.set_speed(travel_speed)
