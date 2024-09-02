extends CharacterBody2D

@onready var bully = $".."


func take_damage(dmg: float) -> void:
	bully.take_damage(dmg)
