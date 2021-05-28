extends PathFollow2D

var speed : int
var health : int
var cash : int
signal breach


func _ready():
	speed *= GlobalSettings._get_speed_mult() 
	health *= GlobalSettings._get_health_mult()
	$AnimatedSprite.playing = true
	
	
func _physics_process(delta):
	offset += speed * delta
	
	if unit_offset >= 1:
		queue_free()


