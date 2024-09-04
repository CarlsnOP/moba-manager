extends CharacterBody2D

@onready var health_bar = %HealthBar


func take_damage(dmg: float) -> void:
	health_bar.take_damage(dmg)
