extends Levels

func _ready():
	mob = [preload("res://Enemies/Floater.tscn")]
	
	
func _physics_process(delta):
	if are_you_winning_son:
		$"LevelBackground".playing = false
		GlobalSettings.unlockedlevels.append(3)
		get_parent().add_child(victory_screen.instance())
