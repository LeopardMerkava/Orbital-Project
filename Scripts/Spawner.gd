extends Node

onready var enemies : PackedScene
onready var timerdelay : int
onready var enemyleft : int
onready var enemy_start
onready var enemy_dest
onready var enemy_path
signal finished_spawning

func spawn(enemy, delay, amount, start_position, end_position, path):
	enemies = enemy
	timerdelay = delay
	enemyleft = amount
	enemy_start = start_position
	enemy_dest = end_position
	enemy_path = path
	
	#Start spawning first enemy 1 second after spawner is created, then set to
	#delay
	$Timer.start(1)
	yield($Timer, "timeout")
	$Timer.stop()
	$Timer.start(delay)

func _on_Timer_timeout():
	if enemyleft == 0:
		$Timer.stop()
		emit_signal("finished_spawning")
		queue_free()
		
	else:
		#Create instance of mob
		var mob_instance = enemies.instance()
		mob_instance.connect("lose_a_life", self.get_parent(), "lose_a_life") 
	
		#Set start and end
		mob_instance.position = enemy_start
		mob_instance.destination = enemy_dest
		enemyleft -= 1
		
		#Set path
		mob_instance.set_path(enemy_path)
		
		#Add mob to parent's container
		self.get_parent().get_node("entities").add_child(mob_instance)
		
