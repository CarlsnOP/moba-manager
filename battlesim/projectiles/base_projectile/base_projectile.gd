class_name BaseProjectile
extends Node2D

@onready var sprite_2d = %Sprite2D

signal reached_target

var _target: Vector2
var _direction: Vector2
var _speed := 500.0


func setup(pos: Vector2, target: Vector2, proj_res: ProjectileResource) -> void:
	look_at(target)
	sprite_2d.texture = proj_res.sprite
	sprite_2d.scale = proj_res.scale
	_target = target
	_direction = pos.direction_to(_target)
	_speed = proj_res.speed
	global_position = pos


func _process(_delta):
	if global_position.distance_to(_target) <= 15:
		ObjectMakerManager.create_explosion(global_position)
		reached_target.emit()
		queue_free()
