class_name LaneManagerComponent
extends Node

@export var navigation_agent: NavigationAgent2D
@export var navigation_component: NavigationComponent
@export var state_machine_component: StateMachineComponent
@export var stats_component: StatsComponent

var enemy_nexus: Nexus
var friendly_nexus: Nexus
var top_lane: bool

func _ready():
	for nexus in get_tree().get_nodes_in_group("nexus"):
		if nexus.is_in_group("team"):
			friendly_nexus = nexus
		else:
			enemy_nexus = nexus
	

func on_lane_change(top: bool) -> void:
	if top_lane == top:
		return
	
	top_lane = top
	navigation_component.last_assigned_lane = top
	state_machine_component.on_child_transition("LaneChangeState")
