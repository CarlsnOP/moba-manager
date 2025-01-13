class_name BaseProjectile
extends Node2D

@onready var sprite_2d = %Sprite2D

signal reached_target

var _target: PhysicsBody2D
var _direction: Vector2
var _speed := 500.0

func setup(pos: Vector2, target: PhysicsBody2D, proj_res: ProjectileResource) -> void:
	look_at(target.global_position)
	sprite_2d.texture = proj_res.sprite
	sprite_2d.scale = proj_res.scale
	_target = target
	_direction = pos.direction_to(_target.global_position)
	_speed = proj_res.speed
	global_position = pos


func _process(_delta):
	if is_instance_valid(_target):
		for child in _target.get_children():
			if child is StateMachineComponent:
				if child.current_state is DeadState:
					queue_free()
		if global_position.distance_to(_target.global_position) <= 15:
			reached_target.emit(self)
			queue_free()
	else:
		queue_free()
