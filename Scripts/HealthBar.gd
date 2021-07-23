extends TextureProgress

func _ready():
	hide()

func _set_max(value):
	max_value = value

func update_healthbar(new_value):
	value = new_value
	show()
