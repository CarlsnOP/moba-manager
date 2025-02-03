class_name DeadState
extends State

@export var move_component: MoveComponent
@export var attack_component: AttackComponent

func enter() -> void:
	move_component.immovable = true
	attack_component.current_target_hurtbox = null

func update(_delta) -> void:
	move_component.immovable = true

func exit() -> void:
	move_component.immovable = false
	
