class_name StatsComponent
extends Node


signal health_changed()
signal no_health()

@export var actor: Node2D
@export var enemy: bool = false
@export var damage := 75.0
@export var move_speed := 5000.0
@export var att_speed := 1.0

@export var health: float = 1.0:
	set(value):
		health = value
		health_changed.emit()
		
		if health <= 0: no_health.emit()
