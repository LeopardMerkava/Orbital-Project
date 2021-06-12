extends Node

var speed_multiplier = 1.0
var health_multiplier = 1.0
var damage_multiplier = 1.0
var cost_multiplier = 1.0

func _get_speed_mult():
	return speed_multiplier

func _get_dmg_mult():
	return damage_multiplier

func _get_health_mult():
	return health_multiplier

func _get_cost_mult():
	return cost_multiplier
