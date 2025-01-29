class_name OutlineComponent
extends Node

const OUTLINE_MATERIAL = preload("res://effects/outline_material.tres")
const TARGET_OUTLINE_MATERIAL = preload("res://effects/target_outline_material.tres")

@export var sprite: Sprite2D

var original_sprite_material: Material


func _ready() -> void:
	original_sprite_material = sprite.material

func apply_target_outline() -> void:
	sprite.material = TARGET_OUTLINE_MATERIAL

func apply_outline() -> void:
	sprite.material = OUTLINE_MATERIAL
	
func remove_outline() -> void:
	sprite.material = original_sprite_material
