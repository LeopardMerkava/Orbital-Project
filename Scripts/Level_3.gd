extends Levels

onready var cur_mob = [preload("res://Enemies/Grunt.tscn"), preload("res://Enemies/Tank.tscn"),
						preload("res://Enemies/Floater.tscn")]

var cur_wave_size = [[5], [1, 3, 5], [10, 5, 5]]
var cur_enemies = 5 + 1 + 3 + 5 + 10 + 5 + 5

# Called when the node enters the scene tree for the first time.
func _ready():
	mob = cur_mob
	wave_size = cur_wave_size
	enemies = cur_enemies
	next_level = 4


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
