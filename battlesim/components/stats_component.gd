class_name StatsComponent
extends Node


signal health_changed()
signal no_health()

@export var actor: CharacterBody2D
@export var enemy: bool = false
@export var health: int = 1:
	set(value):
		health = value
		health_changed.emit()
		
		if health == 0: no_health.emit()

@export var damage := 75.0
@export var move_speed := 0.3
@export var att_speed := 1.0

func _ready():
	if enemy:
		actor.add_to_group("enemy")
	else:
		actor.add_to_group("team")
