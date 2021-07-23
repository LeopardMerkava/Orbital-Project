extends Mob

var id = 'Tank'
export var tank_speed = 70
export var max_health = 15
export var tank_cash = 15

func _ready() -> void:
	#Set parent speed, health, and cash
	speed = tank_speed
	health = max_health
	cash = tank_cash
	hit_animation_name = "Hit"
	death_animation_name = "Death"
	.set_mob(get_node("AnimatedSprite"))
	.set_anim_player(get_node("AnimationPlayer"))
	._on_ready()
