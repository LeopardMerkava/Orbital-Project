extends Enemies

export var grunt_speed = 10
export var grunt_health = 2
export var grunt_cash = 5
onready var anim_player = $AnimationPlayer

func _ready():
	speed = grunt_speed
	health = grunt_health
	cash = grunt_cash

func _on_Area2D_area_entered(area):
	if area.is_in_group("Projectile"):
		area.queue_free()
		anim_player.play("Hit")
		health -= area.get_damage()
		
		if health <= 0:
			get_parent().get_parent().add_cash(cash)
			anim_player.play("Death")
