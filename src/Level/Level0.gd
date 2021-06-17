extends Node2D

onready var enemyList = [load("res://src/Enemies/Grunt.tscn")]
onready var tower = load("res://src/Towers/BasicTower.tscn")
onready var spawner = load("res://src/Level/Spawner.tscn")
var enemyAmount = [[1], [2], [3]]
var enemyindex = 0
var enemycount = 0
var waveCount = 0
var wavenumber = enemyAmount.size()
export var healthrem = 5
var doneSpawning = false
export var startingCash = 200
var cash = 0
var building = false
var instance
var used_spaces_array = []

func _ready():
	waveCount = 0
	doneSpawning = false
	$HUD.update_health(healthrem)
	$HUD.update_wave_amount(wavenumber)
	$HUD.update_wave(waveCount)
	$HUD.update_cash(startingCash)

func _on_WaveTimer_timeout():
	# If last wave, stop
	if waveCount == wavenumber:
		$WaveTimer.stop()
		doneSpawning = true
	else:	
		#spawn spawner for every enemy in current list of this wave's enemy
		for i in range (0, enemyAmount[waveCount].size(), 1):
			var currspawner = spawner.instance()
			add_child(currspawner)
			currspawner.spawn(enemyList[i], 1, enemyAmount[waveCount][i], $Path2D)
		waveCount += 1
		$HUD.update_wave(waveCount)

func _on_HUD_start():
	$WaveTimer.start()
	for i in range (0, enemyAmount[waveCount].size(), 1):
			var currspawner = spawner.instance()
			add_child(currspawner)
			currspawner.spawn(enemyList[i], 1, enemyAmount[waveCount][i], $Path2D)
	waveCount += 1
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


