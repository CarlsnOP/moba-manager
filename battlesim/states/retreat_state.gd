class_name RetreatState
extends State

@export var actor: PhysicsBody2D
@export var stats_component: StatsComponent
@export var navigation_agent: NavigationAgent2D
@export var attack_component: AttackComponent

func enter() -> void:
	attack_component.current_target_hurtbox = null
	
	for nexus in get_tree().get_nodes_in_group("nexus"):
		if stats_component.enemy:
			if nexus.is_in_group("enemy"):
				navigation_agent.set_target_position(nexus.global_position)
	
		elif !stats_component.enemy:
				if nexus.is_in_group("team"):
					navigation_agent.set_target_position(nexus.global_position)
