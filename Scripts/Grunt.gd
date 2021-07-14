extends Mob

#Health, speed, and cash 
export var grunt_speed = 10
export var grunt_health = 4
export var grunt_cash = 5

func _ready() -> void:
	#Set parent speed, health, and cash
	speed = grunt_speed
	health = grunt_health
	cash = grunt_cash
	hit_animation_name = "Hit"
	death_animation_name = "Death"
	.set_mob(get_node("AnimatedSprite"))
	.set_anim_player(get_node("AnimationPlayer"))
	._on_ready()
