class_name NewGameComponent
extends Node

@export var actor: PhysicsBody2D

func _ready() -> void:
	add_to_group("restart_map")

func new_game() -> void:
	actor.queue_free()
