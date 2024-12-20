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
	state_machine_component.on_lane_change.connect(on_lane_change)
	
	for nexus in get_tree().get_nodes_in_group("nexus"):
		if nexus.is_in_group("team"):
			friendly_nexus = nexus
		else:
			enemy_nexus = nexus
	

func _process(_delta):
	pass

func on_lane_change(top: bool) -> void:
	if top_lane == top:
		return
		
	top_lane = top
	state_machine_component.on_child_transition("LaneChangeState")
	navigation_component.set_lane(top_lane)

func nexus_reached() -> void:
	navigation_component.clear_lanes()
	navigation_component.set_lane(top_lane)
