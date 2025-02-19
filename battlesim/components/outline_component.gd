class_name OutlineComponent
extends Node

enum OUTLINE_TYPE { SELF, TARGET, FRIENDLY }

const OUTLINE_MATERIAL = preload("res://effects/outline_material.tres")
const TARGET_OUTLINE_MATERIAL = preload("res://effects/target_outline_material.tres")
const FRIENDLY_OUTLINE_MATERIAL = preload("res://effects/friendly_outline_material.tres")

@export var sprite: Sprite2D

var original_sprite_material: Material


func _ready() -> void:
	original_sprite_material = sprite.material

func apply_outline(type: OUTLINE_TYPE) -> void:
	match type:
		OUTLINE_TYPE.SELF:
			sprite.material = OUTLINE_MATERIAL
		
		OUTLINE_TYPE.TARGET:
			sprite.material = TARGET_OUTLINE_MATERIAL
		
		OUTLINE_TYPE.FRIENDLY:
			sprite.material = FRIENDLY_OUTLINE_MATERIAL
	
func remove_outline() -> void:
	sprite.material = original_sprite_material
