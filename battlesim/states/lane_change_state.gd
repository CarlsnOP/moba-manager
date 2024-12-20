class_name LaneChangeState
extends State

@export var stats_component: StatsComponent
@export var navigation_agent: NavigationAgent2D
@export var lane_manager_component: LaneManagerComponent
@export var state_machine_component: StateMachineComponent

func enter() -> void:
	if stats_component.enemy:
		navigation_agent.target_position = lane_manager_component.enemy_nexus.global_position
	else:
		navigation_agent.target_position = lane_manager_component.friendly_nexus.global_position

func update(_Delta) -> void:
	if navigation_agent.is_target_reached():
		state_machine_component.on_child_transition("PushingState")

func exit() -> void:
	lane_manager_component.nexus_reached()
