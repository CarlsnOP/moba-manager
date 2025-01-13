extends Control

func _ready():
	SignalManager.new_interface.connect(kill_instance)

func _on_yes_button_pressed():
	get_tree().call_group("saver_loader", "save_game")
	get_tree().quit()

func kill_instance(_interface: int) -> void:
	queue_free()

func _on_no_button_pressed():
	queue_free()
