class_name TransitionState
extends State

#This state is used to transition between States
#This is required as some states like manual and fallback should not be changed if we get hit

@export var state_machine_component: StateMachineComponent

func update(_delta) -> void:
	if state_machine_component.current_state is TransitionState:
		state_machine_component.update_state(1)
		await get_tree().create_timer(1).timeout
		
