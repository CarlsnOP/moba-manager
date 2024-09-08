extends Node

@onready var map_setup = %MapSetup
@onready var bot_lane_buddies = %BotLaneBuddies
@onready var top_lane_buddies = %TopLaneBuddies
@onready var bot_lane_bullies = %BotLaneBullies
@onready var top_lane_bullies = %TopLaneBullies
@onready var navigation_map = %NavigationMap

var top_lane_points_enemy := []
var bot_lane_points_enemy := []
var top_lane_points_team := []
var bot_lane_points_team := []

func top_lane_bully_setup() -> Array:
	var top_curve_bully = top_lane_bullies.curve
	var point_count = top_curve_bully.get_point_count()
	var top_lane_points_bully := []
	
	for i in range(point_count):
		var point_position = top_curve_bully.get_point_position(i)
		var global_point_position = top_lane_bullies.global_transform.origin + top_lane_bullies.global_transform.basis_xform(point_position)
		top_lane_points_bully.append(global_point_position)
	
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


func get_enemy_top_lane_data() -> Array:
	return top_lane_bully_setup()

func get_enemy_bot_lane_data() -> Array:
	return bot_lane_bully_setup()
	
func get_team_top_lane_data() -> Array:
	return top_lane_buddy_setup()
	
func get_team_bot_lane_data() -> Array:
	return bot_lane_buddy_setup()
