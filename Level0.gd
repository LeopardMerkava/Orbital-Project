extends Node2D

var enemyList = [load("res://Enemies/Grunt.tscn")]
var enemyAmount = [[1], [2], [3]]
var enemyindex = 0
var enemycount = 0
var waveCount = 0
var wavenumber = enemyAmount.size()
var healthrem = 5
var doneSpawning = false

func _ready():
	$WaveTimer.start()
	waveCount = 0
	doneSpawning = false
	

func _on_SpawnTimer_timeout():
	if waveCount > wavenumber:
		doneSpawning = true
		$SpawnTimer.stop()
	elif enemyindex == enemyAmount[waveCount].size():
		$SpawnTimer.stop()
	elif enemycount == enemyAmount[waveCount][enemyindex]:
		enemycount = 0
		enemyindex += 1
	else:
		enemycount += 1
		$Path2D.add_child(enemyList[enemyindex].instance())
		


func _on_WaveTimer_timeout():
	waveCount += 1
	$SpawnTimer.start()


func _on_Grunt_breach():
	pass
