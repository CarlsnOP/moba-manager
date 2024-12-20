class_name NavigationComponent
extends Node

const WHOLE_MAP_NAV_LAYER := 1
const TOP_LANE_NAV_LAYER := 2
const BOT_LANE_NAV_LAYER := 3
const ENABLED := true
const DISABLED := false


@export var navigation_agent: NavigationAgent2D

func clear_lanes() -> void:
	navigation_agent.set_navigation_layer_value(WHOLE_MAP_NAV_LAYER, DISABLED)
	navigation_agent.set_navigation_layer_value(TOP_LANE_NAV_LAYER, DISABLED)
	navigation_agent.set_navigation_layer_value(BOT_LANE_NAV_LAYER, DISABLED)

func set_lane(top: bool) -> void:
	if top:
		navigation_agent.set_navigation_layer_value(TOP_LANE_NAV_LAYER, ENABLED)
	elif !top:
		navigation_agent.set_navigation_layer_value(BOT_LANE_NAV_LAYER, ENABLED)
