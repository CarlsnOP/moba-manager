extends Node2D

@onready var cpu_particles_2d = $CPUParticles2D

func _ready():
	cpu_particles_2d.finished.connect(kill_instance)
	cpu_particles_2d.emitting = true


func kill_instance() -> void:
	queue_free()
