class_name HurtComponent
extends Node

@export var stats_component: StatsComponent
@export var hurtbox_component: HurtboxComponent


func _ready() -> void:
	hurtbox_component.hurt.connect(take_damage)

func take_damage(damage_taken: float) -> void:
	stats_component.health -= damage_taken
