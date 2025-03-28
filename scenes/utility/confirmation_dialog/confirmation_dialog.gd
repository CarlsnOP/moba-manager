extends Control

func _ready():
	SignalManager.new_interface.connect(kill_instance)

func kill_instance(_interface: int) -> void:
	queue_free()

func _on_yes_button_pressed():
	SignalManager.restart_match.emit()
	queue_free()


func _on_no_button_pressed():
	queue_free()
