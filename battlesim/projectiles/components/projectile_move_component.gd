class_name ProjectileMoveComponent
extends Node

@export var actor: BaseProjectile


func _process(delta):
	actor.global_position += actor._direction * actor._speed * delta
