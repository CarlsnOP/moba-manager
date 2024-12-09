class_name DeathComponent
extends Node


@export var actor: CharacterBody2D
@export var stats_component: StatsComponent

func _ready():
	stats_component.no_health.connect(process_death)

func process_death() -> void:
	actor.queue_free()
