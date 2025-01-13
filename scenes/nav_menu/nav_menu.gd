extends Control

const WANT_TO_QUIT_POP_UP = preload("res://scenes/utility/want_to_quit_pop_up/want_to_quit_pop_up.tscn")

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

func _on_achievementsbutton_pressed():
	SignalManager.new_interface.emit(8)

func _on_quit_button_pressed():
	var temp = get_tree().get_first_node_in_group("want_to_quit_pop_up")
	if temp:
		temp.queue_free()
	else:
		ObjectMakerManager.instantiate_scene(WANT_TO_QUIT_POP_UP)
