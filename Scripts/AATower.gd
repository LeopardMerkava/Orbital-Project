extends Towers

var cost = 10

func _ready() -> void:
	.set_projectile(load("res://Projectiles/AAProjectile.tscn"))
	$TowerRange.connect("area_entered", self, "_on_Tower_Range_area_entered")
	$TowerRange.connect("area_exited", self, "_on_Tower_Range_area_exited")

