class_name DeadState
extends State

@export var move_component: MoveComponent

func enter() -> void:
	move_component.immovable = true
	
func update(_delta) -> void:
	move_component.immovable = true

func exit() -> void:
	move_component.immovable = false
