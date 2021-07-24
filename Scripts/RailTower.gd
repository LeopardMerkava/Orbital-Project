extends Towers

#var to track readiness to fire
var rtf = false
var cost = 10

func _ready() -> void:
	.set_projectile(load("res://Projectiles/RailProjectile.tscn"))
	$TowerRange.connect("area_entered", self, "_on_Tower_Range_area_entered")
	$TowerRange.connect("area_exited", self, "_on_Tower_Range_area_exited")
	$TowerTurret.play('Charging')

func _on_Tower_Range_area_entered(area):
	if area.is_in_group("Enemies"):
		if current_target and area.health > current_target.get_ref().max_health:
			current_target = null
		add_to_array(area)
		try_to_fire()

func add_to_array(area):
	var size = enemy_array.size()
	if size == 0:
		enemy_array.append([area, area.id])
		return
	var i = 0
	while (i < size):
		if area.health > enemy_array[i][0].health:
			enemy_array.insert(i, [area, area.id])
			return
		else:
			i += 1
	enemy_array.append([area, area.id])

func _on_Fire_timeout():
		rtf = true
		try_to_fire()
		
func _on_Tower_Turret_animation_finished() -> void:
	$"TowerTurret".play('Standby')

func try_to_fire():
	if rtf and current_target:
		rtf = false
		$"TowerTurret".play("Fire")
		var instance
		instance = projectile.instance()
		instance.set_target(current_target.get_ref())
		instance.position = $"TowerTurret/ProjectileSpawnLocation".get_global_transform().origin
		get_parent().add_child(instance)
		yield($'TowerTurret', "animation_finished")
		$'TowerTurret'.play('Charging')
		$'Fire'.start(5)
	else:
		pass

