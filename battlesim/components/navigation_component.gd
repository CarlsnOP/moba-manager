class_name NavigationComponent
extends Node

const TOP_LANE_NAV_LAYER := 2
const BOT_LANE_NAV_LAYER := 3

@export var navigation_agent: NavigationAgent2D


func set_lane(top: bool) -> void:
	if top:
		navigation_agent.set_navigation_layer_value(TOP_LANE_NAV_LAYER, true)
	elif !top:
		navigation_agent.set_navigation_layer_value(BOT_LANE_NAV_LAYER, true)
