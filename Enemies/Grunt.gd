extends PathFollow2D

export var speed = 100.0
export var health = 150.0
signal breach


func _ready():
	speed *= GlobalSettings._get_speed_mult() 
	health *= GlobalSettings._get_health_mult()
	$AnimatedSprite.playing = true
	

func _process(delta):
	if health < 0:
		queue_free()
	

func _physics_process(delta):
	offset += speed * delta
	
	if unit_offset >= 1:
		emit_signal("breach", 1)
		queue_free()
