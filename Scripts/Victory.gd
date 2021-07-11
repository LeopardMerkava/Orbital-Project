extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Return_pressed():
	get_tree().change_scene("res://Menus/MainMenu.tscn")
	queue_free()
	GlobalSettings.are_you_winning_son = false
	GlobalSettings.deadite = 0

func _on_Reset_pressed():
	get_tree().change_scene("res://Menus/LevelsSel.tscn")
	queue_free()
	GlobalSettings.are_you_winning_son = false
	GlobalSettings.deadite = 0
