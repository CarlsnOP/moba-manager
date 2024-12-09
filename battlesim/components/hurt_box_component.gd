class_name HurtboxComponent
extends Area2D

signal hurt()

func take_damage(damage_taken: float) -> void:
	hurt.emit(damage_taken)
