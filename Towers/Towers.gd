extends Area2D


var building = true
var can_build = false
var colliding = false

var enemy_array = []
var current_target = null
var target_position
var projectile = load("res://Projectile/NormalProjectile.tscn")

func _ready():
	pass # Replace with function body.

func _on_Tower_Range_area_entered(area):
	if area.is_in_group("Enemies"):
		enemy_array.append(area.get_parent())
		


func _on_Tower_Range_area_exited(area):
	if area.is_in_group("Enemies"):
		enemy_array.erase(area.get_parent())
		if area.get_parent() == current_target.get_ref():
			current_target = null
			$Fire.stop()

func _physics_process(delta):
	if false:
		pass
	else:
		if enemy_array.size() == 0:
			pass
		elif !current_target:
			current_target = weakref(enemy_array[0])
			target_position = enemy_array[0].get_global_transform().origin
			if current_target:
				$Fire.start()
		else:
			if (!current_target.get_ref()):
				current_target = null
				$Fire.stop()
			else:
				target_position = current_target.get_ref().get_global_transform().origin
				$"Tower Turret".rotation = (target_position - position).angle() + deg2rad(90)
				
				
		

func _on_Fire_timeout():
	if current_target.get_ref():
		var instance
		instance = projectile.instance()
		instance.set_target(current_target.get_ref())
		instance.position = $"Tower Turret/Projectile Spawn Location".get_global_transform().origin
		get_parent().add_child(instance)
