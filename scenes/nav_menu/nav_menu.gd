extends Control

@onready var battle_label = $PC/MC/VB/BattleLabel

func _process(_delta):
	#battle_label.text = "Match: %02d:%02d" % time_left_of_match()
	pass

#Used for clock / saving for reference later
#func time_left_of_match():
	#var time_left = generator.time_left
	#var minute = floor(time_left / 60)
	#var second = int(time_left) % 60
	#return [minute, second]

func _on_home_button_pressed():
	SignalManager.new_interface.emit(0)

func _on_heroes_button_pressed():
	SignalManager.new_interface.emit(1)

func _on_battle_setup_button_pressed():
	SignalManager.new_interface.emit(2)
	
func _on_battle_sim_button_pressed():
	SignalManager.new_interface.emit(3)

func _on_inventorybutton_pressed():
	SignalManager.new_interface.emit(4)

func _on_crafting_button_pressed():
	SignalManager.new_interface.emit(5)

func _on_rank_button_pressed():
	SignalManager.new_interface.emit(6)

func _on_settings_button_pressed():
	SignalManager.new_interface.emit(7)

func _on_quit_button_pressed():
	get_tree().call_group("saver_loader", "save_game")
	get_tree().quit()
