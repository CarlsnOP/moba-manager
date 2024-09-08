extends Node

@onready var bot_lane_buddies = %BotLaneBuddies
@onready var top_lane_buddies = %TopLaneBuddies
@onready var bot_lane_bullies = %BotLaneBullies
@onready var top_lane_bullies = %TopLaneBullies


func retrieve_lane_data(lanes: Array) -> Array:
	lanes.append(bot_lane_buddies)
	lanes.append(top_lane_buddies)
	lanes.append(bot_lane_bullies)
	lanes.append(top_lane_bullies)
	return lanes
