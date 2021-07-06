extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var new_game_state = not get_tree().paused
		get_tree().paused = new_game_state
		visible = new_game_state
