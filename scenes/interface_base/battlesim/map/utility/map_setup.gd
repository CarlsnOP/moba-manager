extends Node

@onready var bot_lane_buddies = %BotLaneBuddies
@onready var top_lane_buddies = %TopLaneBuddies
@onready var bot_lane_bullies = %BotLaneBullies
@onready var top_lane_bullies = %TopLaneBullies


func top_lane_bully_setup() -> Array:
	var top_curve_bully = top_lane_bullies.curve
	var point_count = top_curve_bully.get_point_count()
	var top_lane_points_bully := []
	
	for i in range(point_count):
		var point_position = top_curve_bully.get_point_position(i)
		top_lane_points_bully.append(point_position)
	
	return top_lane_points_bully
	
func bot_lane_bully_setup() -> Array:
	var bot_curve_bully = bot_lane_bullies.curve
	var point_count = bot_curve_bully.get_point_count()
	var bot_lane_points_bully := []
	
	for i in range(point_count):
		var point_position = bot_curve_bully.get_point_position(i)
		bot_lane_points_bully.append(point_position)
		
	return bot_lane_points_bully

func top_lane_buddy_setup() -> Array:
	var top_curve_buddy = top_lane_buddies.curve
	var point_count = top_curve_buddy.get_point_count()
	var top_lane_points_buddy := []
	
	for i in range(point_count):
		var point_position = top_curve_buddy.get_point_position(i)
		top_lane_points_buddy.append(point_position)
		
	return top_lane_points_buddy
	
func bot_lane_buddy_setup() -> Array:
	var bot_curve_buddy = bot_lane_buddies.curve
	var point_count = bot_curve_buddy.get_point_count()
	var bot_lane_points_buddy := []
	
	for i in range(point_count):
		var point_position = bot_curve_buddy.get_point_position(i)
		bot_lane_points_buddy.append(point_position)
	return bot_lane_points_buddy

func retrieve_lane_data(lanes: Array) -> Array:
	lanes.append(bot_lane_buddies)
	lanes.append(top_lane_buddies)
	lanes.append(bot_lane_bullies)
	lanes.append(top_lane_bullies)
	return lanes
