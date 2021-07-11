extends MarginContainer

var MainMenu = load("res://Menus/MainMenu.tscn")
onready var MusicSlider = $"CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/MusicSlider"
onready var SFXSlider = $"CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/SFXSlider"
signal volume_changed

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	MusicSlider.value = GlobalSettings.music
	SFXSlider.value = GlobalSettings.sfx

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Exit_pressed():
	get_parent().add_child(MainMenu.instance())
	queue_free()


func _on_MusicSlider_value_changed(value):
	GlobalSettings.music = value


func _on_SFXSlider_value_changed(value):
	GlobalSettings.sfx = value
	
func _physics_process(delta):
	$"OptionsBackground".volume_db = GlobalSettings.music
