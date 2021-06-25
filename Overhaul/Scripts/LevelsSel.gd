extends MarginContainer

var lvlOne = load("res://Levels/Level_1.tscn")
var lvlTwo = load("res://Levels/Level_2.tscn")

onready var selectorOne = $"CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/Level 1"
onready var selectorTwo = $"CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/Level 2"
onready var selectorThree = $"CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/Level 3"

func _unlock_Level():
	if GlobalSettings.unlockedlevels.has(2):
		selectorTwo.disabled = false
	if GlobalSettings.unlockedlevels.has(3):
		selectorThree.disabled = false


# Called when the node enters the scene tree for the first time.
func _ready():
	_unlock_Level()

func _on_Level_1_pressed():
	get_parent().add_child(lvlOne.instance())
	queue_free()

func _on_Level_2_pressed():
	get_parent().add_child(lvlTwo.instance())
	queue_free()

func _on_Level_3_pressed():
	pass
