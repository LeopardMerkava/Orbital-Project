extends Area2D

var target = null
var speed = 200
var velocity
var AOE = false
var AOE_RANGE = 0
var damage = 1

func _physics_process(delta):
	if target.get_ref():
		velocity = ((target.get_ref().get_global_transform().origin - position).normalized() * speed)
		position += velocity * delta
		rotation = velocity.angle()
	else:
		queue_free()

func set_target(new_target):
	target = weakref(new_target)

func get_damage():
	return damage

func is_AOE():
	return AOE

func get_AOE_range():
	return AOE_RANGE
