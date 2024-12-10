class_name HurtboxComponent
extends Area2D

signal hurt()

@export var stats_component: StatsComponent

func take_damage(damage_taken: float) -> void:
	stats_component.health -= damage_taken
