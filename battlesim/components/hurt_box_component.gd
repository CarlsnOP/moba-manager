class_name HurtboxComponent
extends Area2D

signal hurt(damage: float)

@export var stats_component: StatsComponent
@export var state_machine_component: StateMachineComponent

var last_hitter: PhysicsBody2D

func take_damage(damage_taken: float, lh: PhysicsBody2D) -> void:
	last_hitter = lh
	var actual_damage_taken = damage_taken * stats_component.damage_reduction
	
	#If dodged we take 0 damage
	var dodged = randf() <= stats_component.dodge
	if dodged:
		actual_damage_taken = 0
	
	#If blocked we take 20 % damage and cant be critted
	var blocked = randf() <= stats_component.block
	if blocked and !dodged:
		actual_damage_taken *= 0.2
	
	#Roll chance to be critted if we didn't dodge or block
	var critted: bool
	if !dodged and !blocked:
		for child in lh.get_children():
			if child is StatsComponent:
				critted = randf() <= child.crit
				if critted:
					actual_damage_taken *= 2.0
	
	stats_component.health -= actual_damage_taken
	hurt.emit(actual_damage_taken, blocked, dodged, critted)

func get_healed(heal: float) -> void:
	if stats_component.health < stats_component.max_health:
		stats_component.health += heal
		state_machine_component.on_child_transition("GettingHealedState")
		if stats_component.health >= stats_component.max_health:
			stats_component.health = stats_component.max_health
			state_machine_component.on_child_transition("AggressiveState")
	else:
		state_machine_component.on_child_transition("AggressiveState")
