class_name Minion
extends CharacterBody2D

const ENEMY_MINION = preload("res://assets/art/map/enemy_minion.png")
const FRIENDLY_MINION = preload("res://assets/art/map/friendly_minion.png")

@onready var stats_component = $StatsComponent
@onready var sprite_2d = $Sprite2D
@onready var navigation_component = $NavigationComponent
@onready var hurtbox_component = $HurtboxComponent
@onready var hitbox_component = $HitboxComponent


var friendly_minion_scale := Vector2(0.06, 0.06)

func setup(enemy: bool, top: bool) -> void:
	if enemy:
		stats_component.enemy = enemy
		sprite_2d.texture = ENEMY_MINION
		hurtbox_component.set_collision_layer_value(2, true)
		hitbox_component.set_collision_mask_value(1, true)
	else:
		sprite_2d.texture = FRIENDLY_MINION
		sprite_2d.scale = friendly_minion_scale
		hurtbox_component.set_collision_layer_value(1, true)
		hitbox_component.set_collision_mask_value(2, true)
		
	#if top = true, then top lane, else bot lane
	navigation_component.set_lane(top)
