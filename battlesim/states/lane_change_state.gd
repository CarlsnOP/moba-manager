class_name LaneChangeState
extends State

@export var stats_component: StatsComponent
@export var navigation_agent: NavigationAgent2D
@export var navigation_component: NavigationComponent
@export var lane_manager_component: LaneManagerComponent
@export var state_machine_component: StateMachineComponent


func enter() -> void:
	navigation_component.enable_navigation_whole_map()
	
	if stats_component.enemy:
		navigation_agent.target_position = lane_manager_component.enemy_nexus.global_position
	else:
		navigation_agent.target_position = lane_manager_component.friendly_nexus.global_position

func update(_Delta) -> void:
	if navigation_agent.is_target_reached():
		if !state_machine_component.current_state is DeadState:
			state_machine_component.on_child_transition("TransitionState")
		

func exit() -> void:
	navigation_component.set_lane(navigation_component.last_assigned_lane)
