extends Node

const BULLY = preload("res://scenes/interface_base/battlesim/bully/bully.tscn")
const BUDDY = preload("res://scenes/interface_base/battlesim/buddy/buddy.tscn")


@onready var map_setup = %MapSetup
@onready var spawn_timer = %SpawnTimer

var lanes := []


func _ready():
	lanes = map_setup.retrieve_lane_data(lanes)
	spawn_enemies()

func new_game() -> void:
	spawn_enemies()
	spawn_timer.stop()
	spawn_timer.start()

func spawn_enemies():
	var buddies := 0
	
	for lane in lanes:
		buddies += 1
		if buddies < 3:
			var new_buddy = BUDDY.instantiate()
			lane.add_child(new_buddy)
		else:
			var new_bully = BULLY.instantiate()
			lane.add_child(new_bully)


func _on_spawn_timer_timeout():
	spawn_enemies()
