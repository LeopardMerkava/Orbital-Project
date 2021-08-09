extends Levels

#Mob list
onready var cur_mob = [preload("res://Enemies/Grunt.tscn"), preload("res://Enemies/Tank.tscn")]

#wave vars
var cur_wave_size = [[5], [7], [10, 3]]
var cur_enemies = 5 + 7 + 10 + 3

func _ready():
	mob = cur_mob
	wave_size = cur_wave_size
	enemies = cur_enemies
	next_level = 2

