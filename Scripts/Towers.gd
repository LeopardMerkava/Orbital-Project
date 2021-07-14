extends Area2D
class_name Towers

# Tower tracking and attacking variables
onready var enemy_array = []
onready var current_target = null
onready var target_position
onready var projectile : PackedScene setget set_projectile

func _on_Tower_Range_area_entered(area):
	if area.is_in_group("Enemies"):
		enemy_array.append(area)

func _on_Tower_Range_area_exited(area):
	if area.is_in_group("Enemies"):
		enemy_array.erase(area)
		if current_target and area == current_target.get_ref():
			current_target = null

func _physics_process(delta):
	if enemy_array.size() == 0:
		pass
	elif !current_target:
		current_target = weakref(enemy_array[0])
		target_position = enemy_array[0].get_global_transform().origin
	else:
		if (!current_target.get_ref()):
			current_target = null
		else:
			target_position = current_target.get_ref().get_global_transform().origin
			$"TowerTurret".rotation = (target_position - position).angle() + deg2rad(90)

func _on_Fire_timeout():
	if !current_target:
		pass
	elif current_target.get_ref():
		$"TowerTurret".play("Fire")
		var instance
		instance = projectile.instance()
		instance.set_target(current_target.get_ref())
		instance.position = $"TowerTurret/ProjectileSpawnLocation".get_global_transform().origin
		get_parent().add_child(instance)


func _on_Tower_Turret_animation_finished() -> void:
	$"TowerTurret".stop()

func set_projectile(used_projectile : PackedScene) -> void:
	projectile = used_projectile

