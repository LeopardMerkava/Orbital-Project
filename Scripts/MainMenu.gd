extends MarginContainer

var lvlOne =  load("res://Levels/Level_1.tscn")
var levels = load("res://Menus/LevelsSel.tscn")
var options = load("res://Menus/Options.tscn")

# Selectors
onready var selectorOne = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selectorTwo = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selectorThree = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector
onready var selectorFour = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer4/HBoxContainer/Selector

var currentSelection = 0

func set_current_selection(_current_selection):
	selectorOne.text = ""
	selectorTwo.text = ""
	selectorThree.text = ""
	selectorFour.text = ""
	if _current_selection == 0:
		selectorOne.text = ">"
	elif _current_selection == 1:
		selectorTwo.text = ">"
	elif _current_selection == 2:
		selectorThree.text = ">"
	elif _current_selection == 3:
		selectorFour.text = ">"
		
# Inputs
func _process(delta):
	if Input.is_action_just_pressed("ui_down"):
		currentSelection += 1
		if currentSelection >= 4:
			currentSelection = 0
		set_current_selection(currentSelection)
	elif Input.is_action_just_pressed("ui_up"):
		currentSelection -= 1
		if currentSelection <= -1:
			currentSelection = 3
		set_current_selection(currentSelection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(currentSelection)

func handle_selection(_current_selection):
	if _current_selection == 0:
		get_parent().add_child(lvlOne.instance())
		queue_free()
	elif _current_selection == 1:
		get_parent().add_child(levels.instance())
		queue_free()
	elif _current_selection == 2:
		get_parent().add_child(options.instance())
		queue_free()
	elif _current_selection == 3:
		get_tree().quit()

# Called when the node enters the scene tree for the first time.
func _ready():
	set_current_selection(0)
	
func _physics_process(delta):
	$"MainBackground".volume_db = GlobalSettings.music
