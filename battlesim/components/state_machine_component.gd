class_name StateMachineComponent
extends Node

@export var actor: Node2D
@export var initial_state: State
@export var navigation_agent: NavigationAgent2D

var current_state: State
var states: Dictionary = {}
var dead := false

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.on_child_transition.connect(on_child_transition)
	
	#Runs enter() when selecting state (the states _ready() function)
	if initial_state:
		initial_state.enter(actor, navigation_agent)
		current_state = initial_state
 
#Runs Update(delta) on state (the states _process(delta) function)
func _process(delta):
	if current_state and !dead:
		current_state.update(delta)

#Runs physics_update(delta) on state (the states _physics_process(delta) function)
func _physics_process(delta):
	if current_state and !dead:
		current_state.physics_update(delta)

func on_child_transition(state, new_state_name: String):
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	#Runs exit() function on state (something the state needs to do before it switches to new state)
	if current_state:
		current_state.exit()
		
	new_state.enter(actor, navigation_agent)
	
	current_state = new_state

func on_death() -> void:
	dead = true

func on_respawn() -> void:
	dead = false

func get_state() -> State:
	return current_state
