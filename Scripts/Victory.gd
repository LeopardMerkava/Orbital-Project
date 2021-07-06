extends Control

var LevelSelect = load("res://Menus/LevelsSel.tscn")
var MainMenu = load("res://Menus/MainMenu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Return_pressed():
	get_tree().change_scene("res://Menus/MainMenu.tscn")
	queue_free()


func _on_Reset_pressed():
	get_tree().change_scene("res://Menus/LevelsSel.tscn")
	queue_free()
