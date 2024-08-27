extends Control

@onready var generator = $Generator
@onready var battle_label = $PC/MC/VB/BattleLabel

func _process(_delta):
	battle_label.text = "Match: %02d:%02d" % time_left_of_match()

func time_left_of_match():
	var time_left = generator.time_left
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]

func _on_home_button_pressed():
	SignalManager.new_interface.emit(0)

func _on_heroes_button_pressed():
	SignalManager.new_interface.emit(1)

func _on_battle_setup_button_pressed():
	SignalManager.new_interface.emit(2)

func _on_inventorybutton_pressed():
	SignalManager.new_interface.emit(3)

func _on_crafting_button_pressed():
	SignalManager.new_interface.emit(4)

func _on_highscore_button_pressed():
	SignalManager.new_interface.emit(5)

func _on_settings_button_pressed():
	SignalManager.new_interface.emit(6)

func _on_quit_button_pressed():
	get_tree().quit()
