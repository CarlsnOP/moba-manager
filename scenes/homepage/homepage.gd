extends Node2D

@onready var saver_loader = $Utilities/SaverLoader
@onready var music_player: AudioStreamPlayer = $MusicPlayer

func _ready():
	saver_loader.load_game()
	
	#speed up/slow down game. 1 = normal speed
	Engine.time_scale = 1
	call_deferred("play_music")

func play_music() -> void:
	music_player.play()

func _notification(what):
	if what == NOTIFICATION_CRASH:
		saver_loader.save_game()
		print("the game crashed.")

		get_tree().quit()
		
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		saver_loader.save_game()

		get_tree().quit()
