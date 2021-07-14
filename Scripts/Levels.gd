extends Node
class_name Levels

#Pause
var PauseScreen = load("res://Menus/Pause.tscn")
var paused = false

#Game Over
var gameover = load("res://Menus/GameOver.tscn")
var gameoverbool = false

#Spawner
onready var spawner = load("res://Misc/Spawner.tscn")

#Mob list
onready var mob = [preload("res://Enemies/Grunt.tscn")]

#wave vars
var wave_size = [[5], [7], [10]]
var enemies = 5 + 7 + 10
var current_wave = 0
var done_spawning = false

#Stats var (used for HUD and such)
export var lives = 3
var originalLives = lives
export var cash = 10


# Tower & Tower Placement Vars
onready var basic_tower = preload("res://Towers/BasicTower.tscn")
onready var bomb_tower = preload("res://Towers/BombTower.tscn")
var can_place_tower = false
var invalid_tile
var curr_tower

# Victory Conditions
var victory_screen = load("res://Menus/Victory.tscn")
var next_level : int

# Win Game
var win_screen = load("res://Menus/Win.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#reset dead counter
	GlobalSettings.deadite = 0
	#start timer
	$spawner_time.start(60)
	$UI/lives.text = "Lives: " +  str(lives)
	# Towers cannot be placed on these tiles
	invalid_tile = $nav/tilemap_nav.get_used_cells() + $unplacable.get_used_cells()
	

func _input(event):
	# Add pause menu
	if event.is_action_pressed("pause") and !paused:
		get_parent().add_child(PauseScreen.instance())
		get_tree().paused = true
		paused = true
	
func _process(delta):
	# set waves left
	$UI/wave.text = "Wave " + str(int(current_wave))
	# show the timer
	$UI/next_wave_time.text = str(int($spawner_time.time_left))
	# set music
	$"LevelBackground".volume_db = GlobalSettings.music
	# Show cash
	$UI/cash.text = "Cash: " + str(cash)
	# Test for Victory
	victory()

	
func _unhandled_input(event):
	if event is InputEventMouseMotion and can_place_tower:
		$tower_placement.clear()
		
		#get the tile location of the mouse cursor
		var tile = $tower_placement.world_to_map(event.position)
		
		if not tile in invalid_tile and (cash - curr_tower.instance().cost) >= 0:
			#colour it green
			$tower_placement.set_cell(tile.x, tile.y, 0)
		else:
			#colour it red
			$tower_placement.set_cell(tile.x, tile.y, 1)
			
	# Building
	elif event is InputEventMouseButton and can_place_tower and event.pressed:
		#get the tile location of the mouse cursor
		var tile = $tower_placement.world_to_map(event.position)
		
		if not tile in invalid_tile and (cash - curr_tower.instance().cost) >= 0:
			can_place_tower = false
			$tower_placement.clear()
			
			# Invalid space for future placements
			invalid_tile.append(tile)
			
			# Place tower
			var tower_instance = curr_tower.instance()
			tower_instance.position = tile * Vector2(64,64) + Vector2(32, 32)
			$entities.add_child(tower_instance)
			cash -= curr_tower.instance().cost

func _on_spawner_time_timeout():
	#Stop timer (if using button)
	$spawner_time.stop()
	#disable next wave
	$UI/start_next_wave.disabled = true
		
	#spawn spawner for every enemy in current list of this wave's enemy
	for i in range (0, wave_size[current_wave].size(), 1):
		var currspawner = spawner.instance()
		add_child(currspawner)
		var path = $nav.get_simple_path($start.position, $end.position)
		var start_pos = $start.position
		var destination = $end.position
		currspawner.spawn(mob[i], 1, wave_size[current_wave][i], start_pos, destination, path)
	current_wave += 1

	if current_wave < wave_size.size():
		$spawner_time.start(60)
		#Wait 5 seconds before the button for next wave is usable
		yield(get_tree().create_timer(5), "timeout")
		$UI/start_next_wave.disabled = false
	else:
		done_spawning = true
	
func lose_a_life():
	lives -= 1
	if lives < 0:
		pass
	elif lives == 0:
		gameoverbool = true
		$spawner_time.stop()
		$UI/start_next_wave.disabled = true
		$UI/lives.text = "Lives: 0"
		$"LevelBackground".playing = false
		get_parent().add_child(gameover.instance())
	else:
		$UI/lives.text = "Lives: " +  str(lives)

func _on_start_next_wave_pressed():
	_on_spawner_time_timeout() 


func _on_tower_pressed():
	$tower_placement.clear()
	can_place_tower = !can_place_tower
	curr_tower = basic_tower

func _on_bomb_tower_pressed():
	$tower_placement.clear()
	can_place_tower = !can_place_tower
	curr_tower = bomb_tower

	
func _button_pressed(button_name):
	match button_name:
		"Music":
			$"LevelBackground".volume_db = GlobalSettings.music

func add_cash(money):
	cash += money
	
func victory():
	if done_spawning == true and gameoverbool == false:
		if enemies == GlobalSettings.deadite + (originalLives - lives):
			
			GlobalSettings.are_you_winning_son = true
			$"LevelBackground".playing = false
			if (next_level == 4):
				get_parent().add_child(win_screen.instance())
			else:
				GlobalSettings.unlockedlevels.append(next_level)
				get_parent().add_child(victory_screen.instance())
			
