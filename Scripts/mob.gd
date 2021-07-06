extends Area2D
class_name Mob

# AnimatedSprite
onready var mob : Node setget set_mob
onready var move_animation_name : String
# AnimationPlayer 
onready var anim_player : Node setget set_anim_player
onready var hit_animation_name : String
onready var death_animation_name : String
var path : = PoolVector2Array() setget set_path
var destination = Vector2()
signal lose_a_life
var speed : int
var health : int
var cash : int
var death = false

func set_mob(mob_node : Node) -> void:
	mob = mob_node

func set_anim_player(anim_player_node : Node) -> void:
	anim_player = anim_player_node

# Called when the node enters the scene tree for the first time. Skipped
# to call the child node first
func _ready():
	pass 

func _on_ready():
	speed *= GlobalSettings._get_speed_mult() 
	health *= GlobalSettings._get_health_mult()
	#mob.play(move_animation_name)
	
func _physics_process(delta):
	if path.size() > 0:
		# move along the path if the mob hasn't reached destination
		var distance = speed * delta
		move_along_path(distance)
	elif abs(position.x - destination.x) < 10 and abs(position.y - destination.y) < 10:
		# free the mob when it reaches destination
		queue_free()
		emit_signal("lose_a_life")

func move_along_path(distance):
	var start_pos = position
	
	# while there is still a path
	for i in range(path.size()):
		# move to the next position on the path
		var distance_to_next = start_pos.distance_to(path[0])
		if distance <= distance_to_next and distance > 0:
			position = start_pos.linear_interpolate(path[0], distance / distance_to_next)
			break
		elif distance < 0:
			position = path[0]
			break
		
		distance -= distance_to_next
		start_pos = path[0]
		path.remove(0)

func set_path(new_path):
	# Path is set in main script
	 path = new_path

#Code for getting hit
func dealt_damage(damage):
	#Play damaged animation
	health -= damage
	if health <= 0 and !death:
		get_parent().get_parent().add_cash(cash)
		#play death animation
		anim_player.play(death_animation_name)
		death = true
		GlobalSettings.deadite += 1
		yield(anim_player, "animation_finished")
		queue_free()
	else:
		anim_player.play(hit_animation_name)


