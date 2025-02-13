class_name MoveComponent
extends Node

signal destination_reached

@export var actor: PhysicsBody2D
@export var stats_component: StatsComponent
@export var navigation_agent: NavigationAgent2D
@export var attack_component: AttackComponent
@export var hitbox_component: HitboxComponent
@export var state_machine_component: StateMachineComponent

var immovable := false
var standing_still := true


func _physics_process(delta):
	if !immovable:
		var next_path_position: Vector2 = navigation_agent.get_next_path_position()

		if actor.global_position.distance_to(next_path_position) > 20.0:
			actor.velocity = actor.global_position.direction_to(next_path_position) * stats_component.move_speed * delta
			actor.move_and_slide()
			standing_still = false
		elif standing_still == false:
			if actor is Hero:
				if state_machine_component.current_state is ManualState:
					destination_reached.emit()
			standing_still = true
