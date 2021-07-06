extends Levels

func _physics_process(delta):
	if areyouwinningson:
		$"LevelBackground".playing = false
		GlobalSettings.unlockedlevels.append(2)
		get_parent().add_child(victory_screen.instance())
