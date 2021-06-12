extends Control
tool

export var starter_scene: PackedScene

func _on_NewGameButton_pressed() -> void:
	get_tree().change_scene_to(starter_scene)
