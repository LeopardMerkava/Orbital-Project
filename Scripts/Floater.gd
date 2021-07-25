extends Mob

var id = 'Floater'
export var floater_speed = 80
export var max_health = 4
export var floater_cash = 7

func _ready() -> void:
	#Set parent speed, health, and cash
	speed = floater_speed
	health = max_health
	cash = floater_cash
	hit_animation_name = "Hit"
	death_animation_name = "Death"
	.set_mob(get_node("AnimatedSprite"))
	.set_anim_player(get_node("AnimationPlayer"))
	._on_ready()
