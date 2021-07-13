extends Levels

func _ready():
	mob = [preload("res://Enemies/Floater.tscn")]
	next_level = 3
	
	
#func _physics_process(delta):
#	if GlobalSettings.are_you_winning_son:
#		GlobalSettings.are_you_winning_son = false
#		$"LevelBackground".playing = false
#		GlobalSettings.unlockedlevels.append(3)
#		get_parent().add_child(victory_screen.instance())
