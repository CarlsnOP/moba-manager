class_name RetreatState
extends State

@export var actor: PhysicsBody2D
@export var stats_component: StatsComponent
@export var navigation_agent: NavigationAgent2D
@export var attack_component: AttackComponent
@export var state_machine_component: StateMachineComponent

var nexus_position: Vector2

func enter() -> void:
	attack_component.current_target_hurtbox = null
	
	for nexus in get_tree().get_nodes_in_group("nexus"):
		if stats_component.enemy:
			if nexus.is_in_group("enemy"):
				nexus_position = nexus.global_position
				navigation_agent.set_target_position(nexus_position)
	
		elif !stats_component.enemy:
				if nexus.is_in_group("team"):
					nexus_position = nexus.global_position
					navigation_agent.set_target_position(nexus_position)
					
func update(_delta) -> void:
	if actor.global_position.distance_to(nexus_position) < 50.0:
		state_machine_component.on_child_transition("TransitionState")
