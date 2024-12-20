class_name HurtboxComponent
extends Area2D

signal hurt()

@export var stats_component: StatsComponent
@export var state_machine_component: StateMachineComponent

func take_damage(damage_taken: float) -> void:
	stats_component.health -= damage_taken

func get_healed(heal: float) -> void:
	if stats_component.health < stats_component.max_health:
		stats_component.health += heal
		state_machine_component.on_child_transition("GettingHealedState")
		if stats_component.health >= stats_component.max_health:
			stats_component.health = stats_component.max_health
			state_machine_component.on_child_transition("AggressiveState")
