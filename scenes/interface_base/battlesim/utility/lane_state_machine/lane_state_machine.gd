extends Node


@export var initial_lane: LaneState


var current_state: LaneState
var states: Dictionary = {}


func _ready():
	var parent_node = get_parent()
	
	if parent_node.has_method("get_initial_lane"):
		initial_lane = parent_node.get_initial_lane()
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.on_child_transition.connect(on_child_transition)
	
	if initial_lane:
		initial_lane.enter()
		current_state = initial_lane


func on_child_transition(state, new_state_name):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state

func get_minion_array() -> Array[PathFollow2D]:
	return current_state.get_minion_array()
