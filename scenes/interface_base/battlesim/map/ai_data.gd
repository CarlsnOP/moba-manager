extends Node

@onready var map_setup = %MapSetup

var top_lane_points_enemy := []
var bot_lane_points_enemy := []
var top_lane_points_team := []
var bot_lane_points_team := []


func _ready():
	setup_lane_points()

func setup_lane_points() -> void:
	top_lane_points_enemy = map_setup.top_lane_bully_setup()
	bot_lane_points_enemy = map_setup.bot_lane_bully_setup()
	top_lane_points_team = map_setup.top_lane_buddy_setup()
	bot_lane_points_team = map_setup.bot_lane_buddy_setup()

func get_enemy_top_lane_data() -> Array:
	return top_lane_points_enemy

func get_enemy_bot_lane_data() -> Array:
	return bot_lane_points_enemy
	
func get_team_top_lane_data() -> Array:
	return top_lane_points_team
	
func get_team_bot_lane_data() -> Array:
	return bot_lane_points_team
