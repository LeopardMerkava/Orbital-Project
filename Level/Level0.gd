extends Node2D

var enemyList = [load("res://Enemies/Grunt.tscn")]
var tower = [load("res://Towers/BasicTower.tscn")]
var enemyAmount = [[1], [2], [3]]
var enemyindex = 0
var enemycount = 0
var waveCount = 0
var wavenumber = enemyAmount.size()
var sttimeoutcount = 0
export var healthrem = 5
var doneSpawning = false
var cash = 0
var building = false
var instance

func _ready():
	waveCount = 0
	doneSpawning = false
	$HUD.update_health(healthrem)
	$HUD.update_wave_amount(wavenumber)


func _on_SpawnTimer_timeout():
	sttimeoutcount += 1
	
	if waveCount > wavenumber:
		doneSpawning = true
		$SpawnTimer.stop()
		$WaveTimer.stop()
	elif enemyindex == enemyAmount[waveCount - 1].size():
		$SpawnTimer.stop()
		enemyindex = 0
	elif enemycount == enemyAmount[waveCount - 1][enemyindex]:
		enemycount = 0
		enemyindex += 1
	else:
		enemycount += 1
		$Path2D.add_child(enemyList[enemyindex].instance())

func _on_WaveTimer_timeout():
	$SpawnTimer.start()	
	waveCount += 1
	$HUD.update_wave(waveCount)

func _on_HUD_start():
	$WaveTimer.start()
	$SpawnTimer.start()
	waveCount = 1
	$HUD.update_wave(waveCount)

func _on_TextureButton_pressed():
	if !building:
		instance = tower.instance()
		add_child(instance)
		building = true

func _process(_delta):
	if healthrem < 1:
		stop()

func tower_built():
	building = false

func stop():
	$WaveTimer.stop()
	$SpawnTimer.stop()
	get_tree().call_group("Enemies", "queue_free")

func add_cash(added_cash):
	cash += added_cash


