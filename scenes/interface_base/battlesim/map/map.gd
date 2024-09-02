extends Control

const BULLY = preload("res://scenes/interface_base/battlesim/bully/bully.tscn")
const BUDDY = preload("res://scenes/interface_base/battlesim/buddy/buddy.tscn")


@onready var bot_lane_budies = %BotLaneBudies
@onready var top_lane_budies = %TopLaneBudies
@onready var bot_lane_bullies = %BotLaneBullies
@onready var top_lane_bullies = %TopLaneBullies

var map_node
var enemies_in_wave := 0
var lanes := []
var buddies:= 0
var buddy := true


func _ready():
	retrieve_lane_data()
	start_next_wave()
	
func retrieve_lane_data():
	lanes.append(bot_lane_budies)
	lanes.append(top_lane_budies)
	lanes.append(bot_lane_bullies)
	lanes.append(top_lane_bullies)

func start_next_wave():
	spawn_enemies(lanes)

func spawn_enemies(all_lanes: Array):
	for lane in all_lanes:
		buddies += 1
		if buddies < 3:
			var new_buddy = BUDDY.instantiate()
			lane.add_child(new_buddy)
		else:
			var new_bully = BULLY.instantiate()
			lane.add_child(new_bully)
		
	buddies = 0
