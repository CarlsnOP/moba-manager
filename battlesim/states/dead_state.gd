class_name DeadState
extends State

@export var move_component: MoveComponent

func enter() -> void:
	move_component.dead = true

func exit() -> void:
	move_component.dead = false
