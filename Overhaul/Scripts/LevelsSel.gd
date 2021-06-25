extends MarginContainer

var lvlOne = load("res://Levels/Level_1.tscn")
var lvlTwo = load("res://Levels/Level_2.tscn")

onready var selectorOne = $"CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/Level 1"
onready var selectorTwo = $"CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/Level 2"
onready var selectorThree = $"CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/Level 3"




# Code to add in!
func _unlock_Level(level):
	pass


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Level_1_pressed():
	get_parent().add_child(lvlOne.instance())
	queue_free()


func _on_Level_2_pressed():
	get_parent().add_child(lvlTwo.instance())
	queue_free()
