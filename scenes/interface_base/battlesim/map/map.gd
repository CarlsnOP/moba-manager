extends Control

const BULLY = preload("res://scenes/interface_base/battlesim/bully/bully.tscn")
const BUDDY = preload("res://scenes/interface_base/battlesim/buddy/buddy.tscn")
const JUNGLE_MOB = preload("res://scenes/interface_base/battlesim/jungle_basic/jungle_juggernaut.tscn")


@onready var bot_lane_budies = %BotLaneBudies
@onready var top_lane_budies = %TopLaneBudies
@onready var bot_lane_bullies = %BotLaneBullies
@onready var top_lane_bullies = %TopLaneBullies
@onready var wave_label = %WaveLabel
@onready var spawn_timer = %SpawnTimer
@onready var top_jungle_bully = %TopJungleBully
@onready var mid_jungle_bully = %MidJungleBully
@onready var mid_jungle_buddy = %MidJungleBuddy
@onready var bot_jungle_buddy = %BotJungleBuddy


@export var wave_spawn_timer := 15.0

var map_node
var enemies_in_wave := 0
var lanes := []
var buddies:= 0
var buddy := true


func _ready():
	retrieve_lane_data()
	spawn_jungle()
	spawn_timer.wait_time = wave_spawn_timer
	spawn_timer.start()
	start_next_wave()

func _process(_delta):
	wave_label.text = "Wave in: %02d" % time_till_next_wave()

func time_till_next_wave():
	var time_left = spawn_timer.time_left
	var second = int(time_left) % 60
	return [second]

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

func spawn_jungle() -> void:
	var jungle = []
	jungle.append(top_jungle_bully)
	jungle.append(mid_jungle_bully)
	jungle.append(mid_jungle_buddy)
	jungle.append(bot_jungle_buddy)
	for mobs in jungle:
		var new_mob = JUNGLE_MOB.instantiate()
		mobs.add_child(new_mob)

func _on_spawn_timer_timeout():
	start_next_wave()

func _on_respawn_timer_1_timeout():
	var new_mob = JUNGLE_MOB.instantiate()
	top_jungle_bully.add_child(new_mob)

func _on_respawn_timer_2_timeout():
	var new_mob = JUNGLE_MOB.instantiate()
	mid_jungle_bully.add_child(new_mob)

func _on_respawn_timer_3_timeout():
	var new_mob = JUNGLE_MOB.instantiate()
	mid_jungle_buddy.add_child(new_mob)

func _on_respawn_timer_4_timeout():
	var new_mob = JUNGLE_MOB.instantiate()
	bot_jungle_buddy.add_child(new_mob)
