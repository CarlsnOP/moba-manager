extends CharacterBody2D

@onready var health_bar = %HealthBar

var _damage_reduction := 1.0

func take_damage(dmg: float, _attacker: Node2D) -> void:
	health_bar.take_damage(dmg * _damage_reduction)
	
func set_dmg_red(dmg_red: float) -> void:
	_damage_reduction += dmg_red
