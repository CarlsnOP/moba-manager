class_name ProjectileMoveComponent
extends Node

@export var actor: BaseProjectile

func _process(delta):
	if is_instance_valid(actor._target):
		actor.global_position += actor.global_position.direction_to(actor._target.global_position) * actor._speed * delta
