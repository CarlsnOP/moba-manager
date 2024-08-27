extends Node2D

@onready var saver_loader = $Utilities/SaverLoader


func _on_save_button_pressed():
	saver_loader.save_game()


func _on_load_button_pressed():
	saver_loader.load_game()
