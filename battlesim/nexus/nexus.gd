class_name Nexus
extends StaticBody2D

const ENEMY_NEXUS = preload("res://assets/art/map/enemy_nexus.png")
const FRIENDLY_NEXUS = preload("res://assets/art/map/friendly_nexus.png")

@onready var stats_component = $StatsComponent
@onready var sprite_2d = $Sprite2D
@onready var hurtbox_component = $HurtboxComponent
@onready var hitbox_component = $HitboxComponent


func setup(enemy: bool) -> void:
	#apply to both enemy and friendly tower
	
	#Apply to enemy towers
	if enemy:
		stats_component.enemy = enemy
		sprite_2d.texture = ENEMY_NEXUS
		hurtbox_component.set_collision_layer_value(2, true)
		hitbox_component.set_collision_mask_value(1, true)
	
	#Apply to firendly towers
	else:
		sprite_2d.texture = FRIENDLY_NEXUS
		hurtbox_component.set_collision_layer_value(1, true)
		hitbox_component.set_collision_mask_value(2, true)

func get_hurtbox() -> HurtboxComponent:
	return hurtbox_component
