extends Area2D

export onready var speed : int 
export onready var health: int 
export onready var life_damage: int 
onready var path : = PoolVector2Array() setget set_path
onready var destination = Vector2()
signal lose_a_life

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if path.size() > 0:
		# move along the path if the mob hasn't reached destination
		var distance = speed * delta
		move_along_path(distance)
	elif abs(position.x - destination.x) < 10 and abs(position.y - destination.y) < 10:
		# free the mob when it reaches destination
		queue_free()
		emit_signal("lose_a_life", life_damage)

func move_along_path(distance):
	var start_pos = position
	
	# while there is still a path
	for i in range(path.size()):
		# move to the next position on the path
		var distance_to_next = start_pos.distance_to(path[0])
		if distance <= distance_to_next and distance > 0:
			position = start_pos.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance <= 0:
			position = path[0]
			break
		
		distance -= distance_to_next
		start_pos = path[0]
		path.remove(0)

func set_path(new_path) -> void:
	# Path is set in main script
	 path = new_path

#called by projectile
func dealt_damage(damage:int) -> void:
	health -= damage
	if health < 0:
		die()

func die() -> void:
	#TODO: Put cash granting code
	queue_free()
	

