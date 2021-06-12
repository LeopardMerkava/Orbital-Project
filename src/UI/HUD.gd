extends CanvasLayer

var health : int = 0
var cash : int = 0
var wave : int = 0
var waveamount : int = 0
signal start

func _ready():
	health = 0
	cash = 0
	wave = 0
	$Button.show()
	$WaveCounter.text = str(wave)
	$HealthCount.text = str(health)
	$CashCount.text = str(cash)
	$GameOver.hide()
	$Complete.hide()

func update_health(new_health):
	health = new_health
	$HealthCount.text = str(new_health)

func update_cash(new_cash):
	cash = new_cash
	$CashCount.text = str(new_cash)

func update_wave(new_wave):
	wave = new_wave
	$WaveCounter.text = str(min(new_wave, waveamount))
	
func update_wave_amount(new_wave_amount):
	waveamount = new_wave_amount
	$WaveAmount.text = str(new_wave_amount)

func _on_Button_pressed():
	$Button.hide()
	emit_signal("start")

func game_over():
	$GameOver.show()

func victory():
	$Complete.show()
