class_name SoundEffectSettings
extends Resource

#Credits to Aarimous:
#https://www.youtube.com/watch?v=Egf2jgET3nQ

enum SOUND_EFFECT_TYPE {
	GAME_WIN,
	GAME_LOSE,
	CRUSHING_BLOW_HIT,
	EXPLOSIVE_FINALE_EXPLOSION,
	EXPLOSIVE_FINALE_ROCKET_FIRE,
}

@export_range(0, 10) var limit := 5
@export var type: SOUND_EFFECT_TYPE
@export var sound_effect: AudioStreamWAV
@export_range(-40, 20) var volume = 0
@export_range(0.0, 4.0, .01) var pitch_scale = 1.0
@export_range(0.0, 1.0, .01) var pitch_randomness = 0.3


var audio_count = 0

func change_audio_count(amount : int):
	audio_count = max(0, audio_count + amount)
	
func has_open_limit() -> bool:
	return audio_count < limit
	
func on_audio_finished():
	change_audio_count(-1)
