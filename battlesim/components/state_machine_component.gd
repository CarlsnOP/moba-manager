class_name StateMachineComponent
extends Node

const DEAD_VALUE := 0

@export var actor: PhysicsBody2D
@export var initial_state: State
@export var health_bar_component: HealthBarComponent
@export var defensive_threshold := 0.6
@export var retreat_threshold := 0.15
@export var hurtbox_component: HurtboxComponent

var current_state: State
var states: Dictionary = {}


func _ready():
	if actor is Hero:
		health_bar_component.value_changed.connect(update_state)
		
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.on_child_transition.connect(on_child_transition)
	
	#Runs enter() whenever we enter the state
	if initial_state:
		initial_state.enter()
		current_state = initial_state
 
#Runs Update(delta) on state (the states _process(delta) function)
func _process(delta):
	if current_state:
		current_state.update(delta)

#Runs physics_update(delta) on state (the states _physics_process(delta) function)
func _physics_process(delta):
	if current_state:
		if current_state.has_method("physics_update"):
			current_state.physics_update(delta)

func respawn() -> void:
	current_state.exit()
	current_state = states.get("TransitionState".to_lower())

func on_child_transition(new_state_name: String):
	if current_state is DeadState:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	#Runs exit() function on state (something the state needs to do before it switches to new state)
	if current_state:
		current_state.exit()
		
	new_state.enter()
	
	current_state = new_state

func update_state(_v: float) -> void:
	if current_state is LaneChangeState or current_state is FallBackState or current_state is ManualState or current_state is GettingHealedState or current_state is DeadState:
		return
		
	var value = health_bar_component.value

	if value >= health_bar_component.max_value * defensive_threshold:
		on_child_transition("AggressiveState")
	elif value >= health_bar_component.max_value * retreat_threshold:
		on_child_transition("DefensiveState")
	elif value > DEAD_VALUE:
		on_child_transition("RetreatState")

func get_state() -> State:
	return current_state
