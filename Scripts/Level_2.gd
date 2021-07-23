extends Levels

#Mob list
onready var cur_mob = [preload("res://Enemies/Grunt.tscn"), preload("res://Enemies/Floater.tscn")]

#wave vars
var cur_wave_size = [[5], [1, 7], [10, 5]]
var cur_enemies = 5 + 8 + 10 + 5

func _ready():
	mob = cur_mob
	wave_size = cur_wave_size
	enemies = cur_enemies
	next_level = 3
	
	
