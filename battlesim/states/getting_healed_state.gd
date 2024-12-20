class_name GettingHealedState
extends State

@export var move_component: MoveComponent

func enter() -> void:
	move_component.getting_healed = true

func exit() -> void:
	move_component.getting_healed = false
