extends Node2D

@onready var saver_loader = $Utilities/SaverLoader

func _ready():
	saver_loader.load_game()
	
	#speed up/slow down game. 1 = normal speed
	Engine.time_scale = 20

func _notification(what):
	if what == NOTIFICATION_CRASH:
		saver_loader.save_game()
		print("the game crashed.")

		get_tree().quit()
		
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		saver_loader.save_game()

		get_tree().quit()

func _on_save_button_pressed():
	saver_loader.save_game()

func _on_load_button_pressed():
	saver_loader.load_game()
