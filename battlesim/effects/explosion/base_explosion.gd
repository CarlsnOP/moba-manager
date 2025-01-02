class_name BaseExplosion
extends Node2D

@onready var cpu_particles_2d = $CPUParticles2D

func setup(pos: Vector2) -> void:
	global_position = pos
	SoundManager.create_2d_audio_at_location(pos, SoundEffectSettings.SOUND_EFFECT_TYPE.EXPLOSIVE_FINALE_EXPLOSION)
	cpu_particles_2d.emitting = true
	cpu_particles_2d.finished.connect(finished)

func finished() -> void:
	await get_tree().create_timer(0.5).timeout
	queue_free()
