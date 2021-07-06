extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		var new_game_state = not get_tree().paused
		get_tree().paused = new_game_state
		visible = new_game_state


func _on_MainMenu_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Menus/MainMenu.tscn")
	queue_free()


func _on_LevelSelect_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Menus/LevelsSel.tscn")
	queue_free()
