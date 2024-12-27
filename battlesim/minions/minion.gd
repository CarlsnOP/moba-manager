class_name Minion
extends CharacterBody2D

const ENEMY_MINION = preload("res://assets/art/characters/enemy_minion.png")
const FRIENDLY_MINION = preload("res://assets/art/characters/friendly_minion.png")

@onready var stats_component = $StatsComponent
@onready var sprite_2d = $Sprite2D
@onready var navigation_component = $NavigationComponent
@onready var hurtbox_component = $HurtboxComponent
@onready var hitbox_component = $HitboxComponent
@onready var health_bar_component = $HealthBarComponent


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

func apply_match_modifier(modifier: float) -> void:
	stats_component.max_health = stats_component.health * modifier
	stats_component.health = stats_component.health * modifier
	stats_component.damage = stats_component.damage * modifier
	health_bar_component.update_max_health()

func get_hurtbox() -> HurtboxComponent:
	return hurtbox_component
