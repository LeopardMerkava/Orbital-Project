extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	$"CreditsBackground".volume_db = GlobalSettings.music


func _on_Exit_pressed():
	get_tree().change_scene("res://Menus/MainMenu.tscn")
	queue_free()
