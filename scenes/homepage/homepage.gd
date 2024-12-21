class_name Homepage
extends Node2D

const NORMAL_GAME_SPEED := 1
const FASTFORWARD_GAME_SPEED := 2

@onready var saver_loader = $Utilities/SaverLoader
@onready var music_player = %MusicPlayer


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

func set_fast_forward() -> void:
	if Engine.time_scale == NORMAL_GAME_SPEED:
		Engine.time_scale = FASTFORWARD_GAME_SPEED
	else:
		Engine.time_scale = NORMAL_GAME_SPEED
