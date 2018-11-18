extends Node2D

func _enter_tree():
	EventListener.add_listener(self, ['money_changed', 'life_changed', 'wave_finished', 'wave_started'])

func on_money_changed(coins):
	$CoinsText.text = str(coins)

func on_life_changed(hearts):
	for i in range($Hearts.get_child_count()):
		$Hearts.get_child(i).visible = hearts > i

func on_wave_finished(wave):
	$NextWaveButton.visible = true
	$WavesText.text = 'Next: Wave ' + str(wave + 1)

func on_wave_started(wave):
	$NextWaveButton.visible = false
	$WavesText.text = 'Wave ' + str(wave)
