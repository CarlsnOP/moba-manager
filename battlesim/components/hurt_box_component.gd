class_name HurtboxComponent
extends Area2D

signal hurt(damage: float)

@export var stats_component: StatsComponent
@export var state_machine_component: StateMachineComponent

var last_hitter: PhysicsBody2D

func take_damage(damage_taken: float, lh: PhysicsBody2D) -> void:
	last_hitter = lh
	var actual_damage_taken = damage_taken * stats_component.damage_reduction
	stats_component.health -= actual_damage_taken
	hurt.emit(actual_damage_taken)

func get_healed(heal: float) -> void:
	if stats_component.health < stats_component.max_health:
		stats_component.health += heal
		state_machine_component.on_child_transition("GettingHealedState")
		if stats_component.health >= stats_component.max_health:
			stats_component.health = stats_component.max_health
			state_machine_component.on_child_transition("AggressiveState")
	else:
		state_machine_component.on_child_transition("AggressiveState")
