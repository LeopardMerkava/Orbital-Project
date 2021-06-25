extends Node

onready var mob = preload("res://Enemies/Grunt.tscn")
onready var tower = preload("res://Towers/BasicTower.tscn")

var mobs_remaining = 0
var lives = 100

# Tower Placement Vars
var can_place_tower = false
var invalid_tile

# Called when the node enters the scene tree for the first time.
func _ready():
	#start timer
	$spawner_time.start(60)
	mobs_remaining = 5
	
	$UI/lives.text = "Lives: " +  str(lives)
	
	# Towers cannot be placed on these tiles
	invalid_tile = $nav/tilemap_nav.get_used_cells()
	
	
func _process(delta):
	# show the timer
	$UI/next_wave_time.text = str(int($spawner_time.time_left))
	# set music
	$"LevelBackground".volume_db = GlobalSettings.music
	
func _unhandled_input(event):
	if event is InputEventMouseMotion and can_place_tower:
		$tower_placement.clear()
		
		#get the tile location of the mouse cursor
		var tile = $tower_placement.world_to_map(event.position)
		
		if not tile in invalid_tile:
			#colour it green
			$tower_placement.set_cell(tile.x, tile.y, 0)
		else:
			#colour it red
			$tower_placement.set_cell(tile.x, tile.y, 1)
			
	# Building
	elif event is InputEventMouseButton and can_place_tower and event.pressed:
		#get the tile location of the mouse cursor
		var tile = $tower_placement.world_to_map(event.position)
		
		if not tile in invalid_tile:
			can_place_tower = false
			$tower_placement.clear()
			
			# Invalid space for future placements
			invalid_tile.append(tile)
			
			# Place tower
			var tower_instance = tower.instance()
			tower_instance.position = tile * Vector2(64,64)
			$entities.add_child(tower_instance)

func _on_spawner_time_timeout():
	#Create instance of mob
	var mob_instance = null
	mob_instance = mob.instance()
	mob_instance.connect("lose_a_life", self, "lose_a_life") 
	
	#Set start and end
	mob_instance.position = $start.position
	mob_instance.destination = $end.position
	
	#Set path
	var path = $nav.get_simple_path($start.position, $end.position)
	mob_instance.set_path(path)
	
	#Add mob to the container
	$entities.add_child(mob_instance)
	
	#disable next wave
	$UI/start_next_wave.disabled = true
	
	mobs_remaining -= 1
	if mobs_remaining > 0:
		$spawner_time.start(1)
	else:
		# reset timer for next wave
		$spawner_time.start(60)
		# reset mobs remaining
		mobs_remaining = 5
		#enable next wave
		$UI/start_next_wave.disabled = false

func lose_a_life():
	lives -= 1
	$UI/lives.text = "Lives: " +  str(lives)


func _on_start_next_wave_pressed():
	_on_spawner_time_timeout() 


func _on_tower_pressed():
	$tower_placement.clear()
	can_place_tower = !can_place_tower
	
func _button_pressed(button_name):
	match button_name:
		"Music":
			$"LevelBackground".volume_db = GlobalSettings.music
