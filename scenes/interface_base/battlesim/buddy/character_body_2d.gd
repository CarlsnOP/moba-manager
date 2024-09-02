extends CharacterBody2D

@onready var buddy = $".."


func take_damage(dmg: float) -> void:
	buddy.take_damage(dmg)
