class_name StatsComponent
extends Node


signal health_changed()
signal no_health()

@export var actor: PhysicsBody2D
@export var enemy: bool = false
@export var damage := 75.0
@export var health_regen := 5.0
@export var ability_power := 0
@export var dodge := 0.01
@export var block := 0.05
@export var crit := 0.05

@export var move_speed := 5000.0
@export var att_speed := 1.0
@export var max_health := 1.0
@export var health := 1.0:
	set(value):
		health = value
		health_changed.emit()
		
		if health <= 0: no_health.emit()
