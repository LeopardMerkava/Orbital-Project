extends Area2D
class_name Towers

# Tower Building Variables
onready var building = true
onready var can_build = false
onready var colliding = false
onready var cell_position
onready var cell_id
onready var tilemap = get_parent().get_node("Map/Base Spots")
onready var cell_size = tilemap.cell_size
onready var current_tile
onready var prev_cell_position
onready var instance


# Tower tracking and attacking variables
onready var enemy_array = []
onready var current_target = null
onready var target_position
onready var projectile : PackedScene setget set_projectile

func _on_Tower_Range_area_entered(area):
	if area.is_in_group("Enemies"):
		enemy_array.append(area.get_parent())
		

func _on_Tower_Range_area_exited(area):
	if area.is_in_group("Enemies"):
		enemy_array.erase(area.get_parent())
		if current_target and area.get_parent() == current_target.get_ref():
			current_target = null
			$Fire.stop()


# This method tracks where the players mouse will be going in the map UI.
# This is a helper function for the build tower

func _mouse_tracker():
	position = get_global_mouse_position()
	cell_position = Vector2(floor(position.x / cell_size.x), floor(position.y / cell_size.y))
	if (prev_cell_position != cell_position):
		print(cell_position)
		prev_cell_position = cell_position
	cell_id = tilemap.get_cellv(cell_position)
	if cell_id != -1 && !get_parent().used_spaces_array.has(cell_position):
		current_tile = tilemap.tile_set.tile_get_name(cell_id)
		print(current_tile)
		if current_tile == "tower_base":
			can_build = true
			position = Vector2(cell_position.x * cell_size.x + cell_size.x / 2,
								cell_position.y * cell_size.y + cell_size.y / 2)
	else:
		can_build = false


func _physics_process(delta):
	if building:
		_mouse_tracker()
		if can_build:
			$"TowerBase".modulate = Color(0.0, 1.0, 0.0, 0.6)
			$"TowerTurret".modulate = Color(0.0, 1.0, 0.0, 0.6)
		else:
			$"TowerBase".modulate = Color(1.0, 0.0, 0.0, 0.6)
			$"TowerTurret".modulate = Color(1.0, 0.0, 0.0, 0.6)
		if Input.is_action_just_pressed("click") and can_build:
			building = false
			get_parent().tower_built()
			$"TowerBase".modulate = Color(1.0, 1.0, 1.0, 1.0)
			$"TowerTurret".modulate = Color(1.0, 1.0, 1.0, 1.0)
			get_parent().used_spaces_array.append(cell_position)
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
				$"TowerTurret".rotation = (target_position - position).angle() + deg2rad(90)
				
				
		

func _on_Fire_timeout():
	if current_target.get_ref():
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
