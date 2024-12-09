class_name MoveComponent
extends Node

@export var actor: CharacterBody2D
@export var stats_component: StatsComponent

func move_to(delta, next_pos: Vector2) -> void:
	if actor.global_position.distance_to(next_pos) > 5.0:
		actor.velocity = actor.global_position.direction_to(next_pos) * stats_component.move_speed * delta
		actor.move_and_slide()
