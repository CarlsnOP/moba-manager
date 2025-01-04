extends Node2D

@onready var plus_particles = $PlusParticles
@onready var sparkles_particles = $SparklesParticles

func _ready():
	plus_particles.finished.connect(kill_instance)
	plus_particles.emitting = true
	sparkles_particles.emitting = true


func kill_instance() -> void:
	queue_free()
