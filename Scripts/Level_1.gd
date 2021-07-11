extends Levels

func _physics_process(delta):
	if GlobalSettings.are_you_winning_son:
		$"LevelBackground".playing = false
		GlobalSettings.unlockedlevels.append(2)
		get_parent().add_child(victory_screen.instance())
