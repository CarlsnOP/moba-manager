class_name Homepage
extends Node2D

const NORMAL_GAME_SPEED := 1
const FASTFORWARD_GAME_SPEED := 3

@onready var saver_loader = $Utilities/SaverLoader
@onready var music_player = %MusicPlayer
@onready var ambience_player = %AmbiencePlayer

func _ready():
	saver_loader.load_game()
	
	
	#speed up/slow down game. 1 = normal speed
	Engine.time_scale = 1
	
	call_deferred("play_music")
	call_deferred("play_ambience")
	
	await get_tree().create_timer(0.1).timeout
	
	var temp_buttons = get_tree().get_nodes_in_group("sound_button")
	for button in temp_buttons:
		button.connect("mouse_entered", play_hover)
		button.connect("pressed", play_pressed)

func play_hover() -> void:
	SoundManager.create_ui_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_HOVER)

func play_pressed() -> void:
	SoundManager.create_ui_audio(SoundEffectSettings.SOUND_EFFECT_TYPE.UI_BUTTON_PRESSED)
	
func play_music() -> void:
	music_player.play()

func play_ambience() -> void:
	ambience_player.play()

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
