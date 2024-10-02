extends Timer


func _ready():
	wait_time = GeneratorManager.tick_duration

func on_save_game(saved_data:Array[SavedGame]):
	var my_data = SavedGame.new()
	my_data.rubber_duckies = CurrencyManager._rubberduckies
	
	saved_data.append(my_data)

func _on_timeout():
	#SignalManager.on_battle_end.emit()
	pass
