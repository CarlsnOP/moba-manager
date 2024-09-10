extends Node


@export var initial_lane: LaneState


var current_state: LaneState
var states: Dictionary = {}
var parent_node: CharacterBody2D


func _ready():
	parent_node = get_parent()
	SignalManager.on_jungle_clear.connect(on_jungle_clear)
	SignalManager.on_jungle_respawn_enemy.connect(on_jungle_respawn_enemy)
	
	if parent_node.has_method("get_initial_lane"):
		initial_lane = parent_node.get_initial_lane()
	
	for child in get_children():
		if child is LaneState:
			states[child.name.to_lower()] = child
			child.on_child_transition.connect(on_child_transition)
	
	if initial_lane:
		initial_lane.enter()
		current_state = initial_lane


func on_child_transition(state, new_state_name: String):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state

func on_jungle_clear(_state, _new_state_name: String):
	if parent_node._jungler:
		on_child_transition(current_state, get_random_choice())

func on_jungle_respawn_enemy():
	if parent_node._jungler:
		on_child_transition(current_state, "JungleLane")
		
func get_random_choice() -> String:
	var rng_value = randf()  
	if rng_value < 0.5:
		return "BotLaneEnemy"
	else:
		return "topLaneEnemy"

func get_minion_array() -> Array[PathFollow2D]:
	return current_state.get_minion_array()
	
func get_jungle_array() -> Array:
	return current_state.get_jungle_array()
