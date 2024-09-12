extends Node


@export var initial_state: State
@export var hero: CharacterBody2D
@export var nav_agent: NavigationAgent2D

var current_state: State
var states: Dictionary = {}
var parent_node

func _ready():
	parent_node = get_parent()
	SignalManager.on_jungle_respawn_enemy.connect(on_jungle_respawn_enemy)

	if parent_node.has_method("get_initial_state"):
		initial_state = parent_node.get_initial_state()
		
	
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.on_child_transition.connect(on_child_transition)
	
	if initial_state:
		initial_state.enter(hero, nav_agent)
		current_state = initial_state
 
func _process(delta):
	if current_state:
		current_state.update(delta)

func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)

func on_child_transition(state, new_state_name: String):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
		
	new_state.enter(hero, nav_agent)
	
	current_state = new_state
	#parent_node.on_new_state(current_state)

func on_jungle_respawn_enemy():
	if parent_node.jungler:
		on_child_transition(current_state, "Jungle")

func get_state() -> State:
	return current_state
