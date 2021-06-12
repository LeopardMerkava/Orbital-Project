extends Node

var enemies
var timerdelay
var enemyleft
var enemypath

func spawn(enemy, delay, amount, path):
	enemies = enemy
	timerdelay = delay
	enemyleft = amount
	enemypath = path
	$Timer.start(delay)

func _on_Timer_timeout():
	if enemyleft == 0:
		$Timer.stop()
		queue_free()
	else:
		enemypath.add_child(enemies.instance())
		enemyleft -= 1
