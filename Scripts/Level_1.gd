extends Levels

func _ready():
	next_level = 2

#func _physics_process(delta):
#	if GlobalSettings.are_you_winning_son:
#		GlobalSettings.are_you_winning_son = false
#		$"LevelBackground".playing = false
#		GlobalSettings.unlockedlevels.append(2)
#		get_parent().add_child(victory_screen.instance())
