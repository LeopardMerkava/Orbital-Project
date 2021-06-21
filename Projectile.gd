extends Area2D
class_name Projectile

onready var target 
onready var speed : int setget set_speed
onready var velocity 
onready var damage : int setget set_damage
onready var is_AOE : bool
onready var AOE_range setget set_aoe_range


func _physics_process(delta) -> void:
	if target.get_ref():
		velocity = ((target.get_ref().get_global_transform().origin - position).normalized() * speed)
		position += velocity * delta
		rotation = velocity.angle()
	else:
		queue_free()

func set_target(new_target) -> void:
	target = weakref(new_target)

func _on_Area2D_area_entered(area: Area2D) -> void:
	if(area.is_in_group("Enemies")):
		if(is_AOE):
			deal_AOE_Damage()
		else:
			area.get_parent().dealt_damage(damage)
		queue_free()

func deal_AOE_Damage() -> void:
	var area_list = AOE_range.get_overlapping_bodies()
	for foundarea in area_list:
		if foundarea.is_in_group("Enemies"):
			foundarea.get_parent().dealt_damage(damage)
	

func set_damage(new_damage) -> void:
	damage = new_damage

func set_speed(new_speed) -> void:
	speed = new_speed

func set_aoe_range(new_aoe_range) -> void:
	AOE_range = new_aoe_range
